import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pass_the_pigs/l10n/app_localizations.dart';
import 'package:pass_the_pigs/theme/color_schemes.g.dart';
import 'package:pass_the_pigs/ui/game/game.dart';
import 'package:pass_the_pigs/ui/game/models/game.dart';
import 'package:pass_the_pigs/ui/game/storage/game_storage.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required this.gameStorage,
    required this.initialGame,
  });

  final GameStorage gameStorage;
  final Game initialGame;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: lightColorScheme,
        scaffoldBackgroundColor: lightColorScheme.surface,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: darkColorScheme,
        scaffoldBackgroundColor: darkColorScheme.surface,
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: GamePage(
        gameStorage: gameStorage,
        initialGame: initialGame,
      ),
    );
  }
}
