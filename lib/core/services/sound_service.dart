enum GameSound { tap, cupFull, purchase, prestige }

abstract class SoundService {
  Future<void> play(GameSound sound);
}

class NoopSoundService implements SoundService {
  const NoopSoundService();

  @override
  Future<void> play(GameSound sound) async {}
}
