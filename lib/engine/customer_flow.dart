import 'dart:math';

import '../config/cafe_config.dart';
import 'cafe_customer.dart';
import 'cafe_floor_plan.dart';
import 'grid_pathfinding.dart';

class CustomerFlow {
  CustomerFlow({
    required this.config,
    required this.plan,
    required Random random,
  }) : _random = random,
       _paths = GridPathfinder(cols: plan.cols, rows: plan.rows);

  final ServiceConfig config;
  final CafeFloorPlan plan;
  final Random _random;
  final GridPathfinder _paths;
  final List<CafeCustomer> customers = [];
  final List<BaristaWorker> baristas = [];
  double _spawnTimer = 0;
  int _nextId = 0;

  int get orderSlots => 1 + baristas.length;

  int get laneOccupancy => customers.where((c) => c.laneIndex != null).length;

  CafeCustomer? get playerOrder {
    for (final customer in customers) {
      if (customer.claim == OrderClaim.player) return customer;
    }
    return null;
  }

  CafeCustomer? byId(int id) {
    for (final customer in customers) {
      if (customer.id == id) return customer;
    }
    return null;
  }

  void setBaristaCount(int count) {
    while (baristas.length > count) {
      final worker = baristas.removeLast();
      final target = worker.targetId;
      if (target != null) byId(target)?.claim = OrderClaim.none;
    }
    while (baristas.length < count) {
      baristas.add(BaristaWorker(baristas.length));
    }
  }

  void clear() {
    customers.clear();
    for (final worker in baristas) {
      worker.targetId = null;
    }
    _spawnTimer = 0;
  }

  bool claimForPlayer(int id) {
    final customer = byId(id);
    if (customer == null || playerOrder != null) return false;
    if (!customer.isWaitingForOrder || customer.isMoving) return false;
    if (customer.claim != OrderClaim.none) return false;
    customer.claim = OrderClaim.player;
    return true;
  }

  void markPlayerOrderReady() => playerOrder?.orderReady = true;

  double? deliverPlayerOrder(int id) {
    final customer = byId(id);
    if (customer == null || customer.claim != OrderClaim.player) return null;
    if (!customer.orderReady) return null;
    final ratio = customer.patience / config.patienceSeconds;
    _serve(customer);
    return ratio;
  }

  List<FlowEvent> update(
    double dt, {
    required bool spawning,
    required List<String> drinks,
    required double arrivalSeconds,
    required double autoServeSeconds,
  }) {
    final events = <FlowEvent>[];
    if (spawning) _spawn(dt, drinks, arrivalSeconds);
    for (final customer in List.of(customers)) {
      _move(customer, dt);
      _advancePhase(customer, dt, events);
    }
    _runBaristas(dt, autoServeSeconds, events);
    return events;
  }

  void _spawn(double dt, List<String> drinks, double arrivalSeconds) {
    _spawnTimer = min(_spawnTimer + dt, arrivalSeconds);
    if (_spawnTimer < arrivalSeconds || drinks.isEmpty) return;
    if (laneOccupancy >= plan.lane.length) return;
    if (customers.length >= config.maxCustomers) return;
    _spawnTimer = 0;
    final customer = CafeCustomer(
      id: _nextId++,
      look: _random.nextInt(1 << 16),
      drinkId: drinks[_random.nextInt(drinks.length)],
      x: plan.door.x.toDouble(),
      y: plan.door.y.toDouble(),
      patience: config.patienceSeconds,
    )..laneIndex = laneOccupancy;
    customers.add(customer);
    _walkTo(customer, plan.lane[customer.laneIndex ?? 0]);
  }

  void _walkTo(CafeCustomer customer, GridCell target) {
    final blocked = plan.blocked.difference({customer.cell, target});
    final path = _paths.findPath(
      from: customer.cell,
      to: target,
      blocked: blocked,
    );
    customer
      ..path = path == null ? [target] : path.skip(1).toList()
      ..pathIndex = 0;
  }

  void _move(CafeCustomer customer, double dt) {
    var budget = config.walkCellsPerSecond * dt;
    while (budget > 0 && customer.isMoving) {
      final target = customer.path[customer.pathIndex];
      final dx = target.x - customer.x;
      final dy = target.y - customer.y;
      final distance = sqrt(dx * dx + dy * dy);
      if (distance > 0) {
        customer.facing = (x: dx.sign.toInt(), y: dy.sign.toInt());
      }
      if (distance <= budget) {
        customer
          ..x = target.x.toDouble()
          ..y = target.y.toDouble()
          ..pathIndex += 1;
        budget -= distance;
      } else {
        customer
          ..x += dx / distance * budget
          ..y += dy / distance * budget;
        budget = 0;
      }
    }
  }

  void _advancePhase(CafeCustomer customer, double dt, List<FlowEvent> events) {
    switch (customer.phase) {
      case CustomerPhase.entering || CustomerPhase.queueing:
        if (customer.isMoving) return;
        customer.phase = (customer.laneIndex ?? orderSlots) < orderSlots
            ? CustomerPhase.ordering
            : CustomerPhase.queueing;
      case CustomerPhase.ordering:
        customer.patience -= dt;
        if (customer.patience > 0) return;
        customer
          ..patience = 0
          ..phase = CustomerPhase.leavingAngry;
        _releaseBarista(customer);
        _leaveLane(customer);
        _walkTo(customer, plan.door);
        events.add(CustomerLost(customer));
      case CustomerPhase.toSeat:
        if (customer.isMoving) return;
        customer
          ..phase = CustomerPhase.seated
          ..seatTimer = config.seatSeconds;
      case CustomerPhase.seated:
        customer.seatTimer -= dt;
        if (customer.seatTimer > 0) return;
        customer
          ..phase = CustomerPhase.leaving
          ..seat = null;
        _walkTo(customer, plan.door);
      case CustomerPhase.leaving || CustomerPhase.leavingAngry:
        if (customer.isMoving) return;
        customers.remove(customer);
        events.add(CustomerGone(customer));
    }
  }

  void _runBaristas(double dt, double serveSeconds, List<FlowEvent> events) {
    for (final worker in baristas) {
      final targetId = worker.targetId;
      if (targetId == null) {
        final next = customers.where(_baristaMayTake);
        if (next.isEmpty) continue;
        final customer = next.first..claim = OrderClaim.barista;
        worker
          ..targetId = customer.id
          ..remaining = serveSeconds
          ..total = serveSeconds;
        continue;
      }
      worker.remaining -= dt;
      if (worker.remaining > 0) continue;
      worker.targetId = null;
      final customer = byId(targetId);
      if (customer == null || !customer.isWaitingForOrder) continue;
      _serve(customer);
      events.add(BaristaServed(customer, worker.index));
    }
  }

  bool _baristaMayTake(CafeCustomer customer) {
    if (!customer.isWaitingForOrder || customer.isMoving) return false;
    if (customer.claim != OrderClaim.none) return false;
    if (customer.laneIndex != 0) return true;
    return customer.patience / config.patienceSeconds <
        config.baristaTakesHeadBelowPatience;
  }

  void _releaseBarista(CafeCustomer customer) {
    for (final worker in baristas) {
      if (worker.targetId == customer.id) worker.targetId = null;
    }
  }

  void _serve(CafeCustomer customer) {
    customer
      ..claim = OrderClaim.none
      ..orderReady = false;
    _leaveLane(customer);
    final seat = _freeSeat(customer);
    if (seat == null) {
      customer.phase = CustomerPhase.leaving;
      _walkTo(customer, plan.door);
      return;
    }
    customer
      ..phase = CustomerPhase.toSeat
      ..seat = seat;
    _walkTo(customer, seat);
  }

  GridCell? _freeSeat(CafeCustomer customer) {
    final taken = {
      for (final other in customers)
        if (other.seat != null) other.seat,
    };
    for (final seat in plan.seats) {
      if (taken.contains(seat)) continue;
      final blocked = plan.blocked.difference({customer.cell, seat});
      if (_paths.findPath(from: customer.cell, to: seat, blocked: blocked) !=
          null) {
        return seat;
      }
    }
    return null;
  }

  void _leaveLane(CafeCustomer customer) {
    final freed = customer.laneIndex;
    customer.laneIndex = null;
    if (freed == null) return;
    for (final other in customers) {
      final index = other.laneIndex;
      if (index == null || index <= freed) continue;
      other.laneIndex = index - 1;
      _walkTo(other, plan.lane[index - 1]);
      if (other.phase == CustomerPhase.queueing) {
        other.phase = CustomerPhase.entering;
      }
    }
  }
}
