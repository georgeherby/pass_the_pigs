import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:pass_the_pigs/ui/game/models/game.dart';
import 'package:pass_the_pigs/ui/game/storage/game_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

class BootstrapData {
  const BootstrapData({
    required this.gameStorage,
    required this.initialGame,
  });

  final GameStorage gameStorage;
  final Game initialGame;
}

Future<BootstrapData> loadBootstrapData() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final gameStorage = GameStorage(prefs);
  final initialGame = await gameStorage.load() ?? Game.initial();
  return BootstrapData(
    gameStorage: gameStorage,
    initialGame: initialGame,
  );
}

Future<void> bootstrap(
  FutureOr<Widget> Function(BootstrapData data) builder,
) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  await runZonedGuarded(
    () async {
      Bloc.observer = AppBlocObserver();
      final data = await loadBootstrapData();
      runApp(await builder(data));
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
