import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pass_the_pigs/ui/game/game.dart';
import 'package:pass_the_pigs/theme/color_schemes.g.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: lightColorScheme,
        scaffoldBackgroundColor: lightColorScheme.background,
        // textTheme: GoogleFonts.dmSerifDisplayTextTheme(
        //   ThemeData.light().textTheme,
        // ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: darkColorScheme,
        scaffoldBackgroundColor: darkColorScheme.background,
        // textTheme: GoogleFonts.dmSerifDisplayTextTheme(
        //   ThemeData.dark().textTheme,
        // ),
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const GamePage(),
    );
  }
}
