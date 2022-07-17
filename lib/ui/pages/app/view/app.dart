import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pass_the_pigs/pages/game/views/game_page.dart';
import 'package:pass_the_pigs/theme/color_schemes.g.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(foregroundColor: Color(0xFFFDF2BF)),
        colorScheme: lightColorScheme,
        scaffoldBackgroundColor: lightColorScheme.background,
        textTheme: GoogleFonts.dmSerifDisplayTextTheme(),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: darkColorScheme,
        scaffoldBackgroundColor: darkColorScheme.background,
        textTheme: GoogleFonts.dmSerifDisplayTextTheme(),
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
