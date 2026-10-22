import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app.dart';
import 'config/economy_config.dart';
import 'config/economy_config_loader.dart';
import 'core/time/clock.dart';
import 'features/game/game_cubit.dart';
import 'features/game/save_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  const clock = SystemClock();
  final config = await EconomyConfigLoader(rootBundle).load();
  final preferences = await SharedPreferences.getInstance();
  final repository = SaveRepository(preferences, clock: clock);
  final loaded = repository.load();
  final cubit = GameCubit(
    config: config,
    repository: repository,
    clock: clock,
    restored: loaded.state,
  );
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<EconomyConfig>.value(value: config),
        RepositoryProvider<SaveRepository>.value(value: repository),
      ],
      child: BlocProvider<GameCubit>.value(
        value: cubit,
        child: const CoffeeEmpireApp(clock: clock),
      ),
    ),
  );
}
