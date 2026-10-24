import 'package:equatable/equatable.dart';

class DailyRewardState extends Equatable {
  const DailyRewardState({this.streak = 0, this.lastClaimedAt});

  factory DailyRewardState.fromJson(Map<String, dynamic> json) {
    final last = json['lastClaimedAt'] as String?;
    return DailyRewardState(
      streak: (json['streak'] as num?)?.toInt() ?? 0,
      lastClaimedAt: last == null ? null : DateTime.parse(last).toUtc(),
    );
  }

  final int streak;
  final DateTime? lastClaimedAt;

  Map<String, dynamic> toJson() => {
    'streak': streak,
    'lastClaimedAt': lastClaimedAt?.toUtc().toIso8601String(),
  };

  @override
  List<Object?> get props => [streak, lastClaimedAt];
}
