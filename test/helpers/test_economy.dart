import 'dart:io';

import 'package:coffee_empire/config/economy_config.dart';

EconomyConfig loadTestEconomy() => EconomyConfig.fromJsonString(
  File('assets/config/economy.json').readAsStringSync(),
);
