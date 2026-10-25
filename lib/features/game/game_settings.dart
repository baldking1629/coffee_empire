import 'package:equatable/equatable.dart';

class GameSettings extends Equatable {
  const GameSettings({
    this.locale = systemLocale,
    this.sound = true,
    this.haptics = true,
    this.notifications = true,
    this.scientific = false,
  });

  factory GameSettings.fromJson(Map<String, dynamic> json) => GameSettings(
    locale: json['locale'] as String? ?? systemLocale,
    sound: json['sound'] as bool? ?? true,
    haptics: json['haptics'] as bool? ?? true,
    notifications: json['notifications'] as bool? ?? true,
    scientific: json['scientific'] as bool? ?? false,
  );

  static const String systemLocale = 'system';

  final String locale;
  final bool sound;
  final bool haptics;
  final bool notifications;
  final bool scientific;

  GameSettings copyWith({
    String? locale,
    bool? sound,
    bool? haptics,
    bool? notifications,
    bool? scientific,
  }) => GameSettings(
    locale: locale ?? this.locale,
    sound: sound ?? this.sound,
    haptics: haptics ?? this.haptics,
    notifications: notifications ?? this.notifications,
    scientific: scientific ?? this.scientific,
  );

  Map<String, dynamic> toJson() => {
    'locale': locale,
    'sound': sound,
    'haptics': haptics,
    'notifications': notifications,
    'scientific': scientific,
  };

  @override
  List<Object?> get props => [
    locale,
    sound,
    haptics,
    notifications,
    scientific,
  ];
}

class GameStats extends Equatable {
  const GameStats({
    this.totalTaps = 0,
    this.cupsFilled = 0,
    this.ordersServed = 0,
    this.perfectServes = 0,
    this.customersLost = 0,
  });

  factory GameStats.fromJson(Map<String, dynamic> json) {
    int read(String key) => (json[key] as num?)?.toInt() ?? 0;
    return GameStats(
      totalTaps: read('totalTaps'),
      cupsFilled: read('cupsFilled'),
      ordersServed: read('ordersServed'),
      perfectServes: read('perfectServes'),
      customersLost: read('customersLost'),
    );
  }

  final int totalTaps;
  final int cupsFilled;
  final int ordersServed;
  final int perfectServes;
  final int customersLost;

  GameStats copyWith({
    int? totalTaps,
    int? cupsFilled,
    int? ordersServed,
    int? perfectServes,
    int? customersLost,
  }) => GameStats(
    totalTaps: totalTaps ?? this.totalTaps,
    cupsFilled: cupsFilled ?? this.cupsFilled,
    ordersServed: ordersServed ?? this.ordersServed,
    perfectServes: perfectServes ?? this.perfectServes,
    customersLost: customersLost ?? this.customersLost,
  );

  Map<String, dynamic> toJson() => {
    'totalTaps': totalTaps,
    'cupsFilled': cupsFilled,
    'ordersServed': ordersServed,
    'perfectServes': perfectServes,
    'customersLost': customersLost,
  };

  @override
  List<Object?> get props => [
    totalTaps,
    cupsFilled,
    ordersServed,
    perfectServes,
    customersLost,
  ];
}
