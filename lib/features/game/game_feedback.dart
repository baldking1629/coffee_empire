import '../../core/services/haptic_service.dart';
import '../../core/services/sound_service.dart';
import 'game_settings.dart';

enum FeedbackKind {
  tap,
  cupFull,
  purchase,
  prestige,
  denied,
  orderTaken,
  serve,
  customerLost,
}

class GameFeedback {
  const GameFeedback({
    this.haptics = const SilentHapticService(),
    this.sound = const NoopSoundService(),
  });

  final HapticService haptics;
  final SoundService sound;

  void play(FeedbackKind kind, GameSettings settings) {
    if (settings.haptics) {
      switch (kind) {
        case FeedbackKind.tap || FeedbackKind.orderTaken:
          haptics.selection();
        case FeedbackKind.cupFull ||
            FeedbackKind.denied ||
            FeedbackKind.customerLost:
          haptics.light();
        case FeedbackKind.purchase || FeedbackKind.serve:
          haptics.medium();
        case FeedbackKind.prestige:
          haptics.heavy();
      }
    }
    if (settings.sound) {
      sound.play(switch (kind) {
        FeedbackKind.tap => GameSound.tap,
        FeedbackKind.cupFull => GameSound.cupFull,
        FeedbackKind.purchase => GameSound.purchase,
        FeedbackKind.prestige => GameSound.prestige,
        FeedbackKind.denied => GameSound.denied,
        FeedbackKind.orderTaken => GameSound.orderTaken,
        FeedbackKind.serve => GameSound.serve,
        FeedbackKind.customerLost => GameSound.customerLost,
      });
    }
  }
}
