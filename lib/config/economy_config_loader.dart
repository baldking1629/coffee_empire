import 'package:flutter/services.dart';

import 'economy_config.dart';

class EconomyConfigLoader {
  const EconomyConfigLoader(this.bundle);

  static const String assetPath = 'assets/config/economy.json';

  final AssetBundle bundle;

  Future<EconomyConfig> load() async {
    final source = await bundle.loadString(assetPath);
    return EconomyConfig.fromJsonString(source);
  }
}
