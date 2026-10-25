import '../config/cafe_config.dart';

enum CustomerPhase {
  entering,
  queueing,
  ordering,
  toSeat,
  seated,
  leaving,
  leavingAngry,
}

enum OrderClaim { none, player, barista }

class CafeCustomer {
  CafeCustomer({
    required this.id,
    required this.look,
    required this.drinkId,
    required this.x,
    required this.y,
    required this.patience,
  });

  final int id;
  final int look;
  final String drinkId;
  double x;
  double y;
  double patience;
  CustomerPhase phase = CustomerPhase.entering;
  List<GridCell> path = const [];
  int pathIndex = 0;
  int? laneIndex;
  OrderClaim claim = OrderClaim.none;
  bool orderReady = false;
  GridCell? seat;
  double seatTimer = 0;
  GridCell facing = (x: 0, y: -1);

  bool get isMoving => pathIndex < path.length;

  GridCell get cell => (x: x.round(), y: y.round());

  bool get isWaitingForOrder => phase == CustomerPhase.ordering;
}

sealed class FlowEvent {
  const FlowEvent(this.customer);

  final CafeCustomer customer;
}

class CustomerLost extends FlowEvent {
  const CustomerLost(super.customer);
}

class CustomerGone extends FlowEvent {
  const CustomerGone(super.customer);
}

class BaristaServed extends FlowEvent {
  const BaristaServed(super.customer, this.baristaIndex);

  final int baristaIndex;
}

class BaristaWorker {
  BaristaWorker(this.index);

  final int index;
  int? targetId;
  double remaining = 0;
  double total = 0;

  bool get isBusy => targetId != null;

  double get progress => total <= 0 ? 0 : 1 - remaining / total;
}
