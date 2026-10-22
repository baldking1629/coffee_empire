class DurationUnitLabels {
  const DurationUnitLabels({
    required this.days,
    required this.hours,
    required this.minutes,
    required this.seconds,
  });

  final String Function(int value) days;
  final String Function(int value) hours;
  final String Function(int value) minutes;
  final String Function(int value) seconds;
}

class DurationFormatter {
  const DurationFormatter(this.labels);

  final DurationUnitLabels labels;

  String format(Duration duration) {
    final safe = duration.isNegative ? Duration.zero : duration;
    final days = safe.inDays;
    final hours = safe.inHours % Duration.hoursPerDay;
    final minutes = safe.inMinutes % Duration.minutesPerHour;
    final seconds = safe.inSeconds % Duration.secondsPerMinute;
    if (days > 0) return _pair(labels.days(days), hours, labels.hours);
    if (hours > 0) return _pair(labels.hours(hours), minutes, labels.minutes);
    if (minutes > 0) {
      return _pair(labels.minutes(minutes), seconds, labels.seconds);
    }
    return labels.seconds(seconds);
  }

  String _pair(String major, int minorValue, String Function(int) minorLabel) =>
      minorValue > 0 ? '$major ${minorLabel(minorValue)}' : major;
}
