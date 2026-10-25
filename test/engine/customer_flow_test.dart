import 'dart:math';

import 'package:coffee_empire/engine/cafe_customer.dart';
import 'package:coffee_empire/engine/economy_engine.dart';
import 'package:coffee_empire/engine/customer_flow.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_economy.dart';

void main() {
  final economy = loadTestEconomy();
  final config = economy.service;
  final rules = EconomyEngine(economy).layoutRules;
  final plan = rules.planFor(
    rules.roomFor(1),
    economy.cafe.defaultLayout.items,
  );

  CustomerFlow newFlow() =>
      CustomerFlow(config: config, plan: plan, random: Random(7));

  List<FlowEvent> run(
    CustomerFlow flow,
    double seconds, {
    bool spawning = true,
    double arrival = 6,
    double serve = 8,
  }) {
    final events = <FlowEvent>[];
    for (var t = 0.0; t < seconds; t += 0.1) {
      events.addAll(
        flow.update(
          0.1,
          spawning: spawning,
          drinks: const ['espresso', 'americano'],
          arrivalSeconds: arrival,
          autoServeSeconds: serve,
        ),
      );
    }
    return events;
  }

  test('default layout leaves the door, lane and every seat walkable', () {
    expect(plan.lane, hasLength(config.queueCapacity));
    expect(plan.blocked.contains(plan.door), isFalse);
    for (final cell in [...plan.lane, ...plan.seats]) {
      expect(plan.blocked.contains(cell), isFalse, reason: '$cell');
    }
    expect(plan.seats, hasLength(4));
  });

  test('a customer walks from the door into the lane and starts ordering', () {
    final flow = newFlow();
    run(flow, 6.05);
    expect(flow.customers, hasLength(1));
    run(flow, 4, spawning: false);
    final customer = flow.customers.single;
    expect(customer.phase, CustomerPhase.ordering);
    expect(customer.cell, plan.lane.first);
    expect(customer.patience, lessThan(config.patienceSeconds));
  });

  test('queue never exceeds its capacity and only the head orders', () {
    final flow = newFlow();
    run(flow, 60, arrival: 1);
    final inLane = flow.customers.where((c) => c.laneIndex != null).toList();
    expect(inLane.length, lessThanOrEqualTo(config.queueCapacity));
    final ordering = flow.customers.where(
      (c) => c.phase == CustomerPhase.ordering,
    );
    expect(ordering.length, lessThanOrEqualTo(flow.orderSlots));
  });

  test('patience running out sends the customer away angry', () {
    final flow = newFlow();
    run(flow, 6.05);
    final events = run(flow, config.patienceSeconds + 8, spawning: false);
    expect(events.whereType<CustomerLost>(), hasLength(1));
    expect(events.whereType<CustomerGone>(), hasLength(1));
    expect(flow.customers, isEmpty);
  });

  test('player claims, readies and delivers; the customer takes a seat', () {
    final flow = newFlow();
    run(flow, 10.05);
    final customer = flow.customers.single;
    expect(flow.claimForPlayer(customer.id), isTrue);
    expect(flow.deliverPlayerOrder(customer.id), isNull);
    flow.markPlayerOrderReady();
    final ratio = flow.deliverPlayerOrder(customer.id);
    expect(ratio, isNotNull);
    expect(ratio, greaterThan(0.7));
    expect(customer.phase, CustomerPhase.toSeat);
    expect(plan.seats, contains(customer.seat));
    run(flow, 6, spawning: false);
    expect(customer.phase, CustomerPhase.seated);
    final events = run(flow, config.seatSeconds + 10, spawning: false);
    expect(events.whereType<CustomerGone>(), hasLength(1));
  });

  test('a second order cannot be claimed while one is in progress', () {
    final flow = newFlow()..setBaristaCount(1);
    run(flow, 40, arrival: 2);
    final ordering = flow.customers
        .where(
          (c) =>
              c.phase == CustomerPhase.ordering && c.claim == OrderClaim.none,
        )
        .toList();
    if (ordering.isNotEmpty) {
      expect(flow.claimForPlayer(ordering.first.id), isTrue);
    }
    final others = flow.customers
        .where((c) => c.claim == OrderClaim.none)
        .toList();
    for (final other in others) {
      expect(flow.claimForPlayer(other.id), isFalse);
    }
  });

  test('a hired barista serves on their own', () {
    final flow = newFlow()..setBaristaCount(1);
    final events = run(flow, 30, arrival: 6, serve: 4);
    expect(events.whereType<BaristaServed>(), isNotEmpty);
    expect(events.whereType<CustomerLost>(), isEmpty);
  });

  test('baristas leave the lane head to the player until patience is low', () {
    final flow = newFlow()..setBaristaCount(1);
    run(flow, 6.05, serve: 100);
    run(flow, 4, spawning: false, serve: 100);
    final head = flow.customers.single;
    expect(head.laneIndex, 0);
    expect(head.claim, OrderClaim.none);
    var claimedAtRatio = 1.0;
    for (var step = 0; step < 300 && head.claim == OrderClaim.none; step++) {
      claimedAtRatio = head.patience / config.patienceSeconds;
      run(flow, 0.1, spawning: false, serve: 100);
    }
    expect(head.claim, OrderClaim.barista);
    expect(
      claimedAtRatio,
      lessThan(config.baristaTakesHeadBelowPatience + 0.01),
    );
  });

  test('clear empties the cafe', () {
    final flow = newFlow();
    run(flow, 20, arrival: 2);
    flow.clear();
    expect(flow.customers, isEmpty);
  });
}
