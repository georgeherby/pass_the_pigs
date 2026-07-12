import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// App title shown on the setup screen
  ///
  /// In en, this message translates to:
  /// **'Pass the Pigs'**
  String get appBarTitle;

  /// Text shown in the Label for Pig One
  ///
  /// In en, this message translates to:
  /// **'Pig One'**
  String get pigOneLabel;

  /// Text shown in the Label for Pig Two
  ///
  /// In en, this message translates to:
  /// **'Pig Two'**
  String get pigTwoLabel;

  /// Text shown in the Label for Roll Score
  ///
  /// In en, this message translates to:
  /// **'Roll'**
  String get rollScoreLabel;

  /// Text shown in the Label for Turn Score
  ///
  /// In en, this message translates to:
  /// **'Turn'**
  String get turnScoreLabel;

  /// Button to bank turn score and end turn
  ///
  /// In en, this message translates to:
  /// **'Save and end turn'**
  String get nextPlayerFab;

  /// Primary button to commit roll and continue the turn
  ///
  /// In en, this message translates to:
  /// **'Save and roll again'**
  String get saveAndRollAgain;

  /// Short title for Makin' Bacon dialog and button
  ///
  /// In en, this message translates to:
  /// **'Makin\' Bacon'**
  String get makinBacon;

  /// Full button label when pigs are touching
  ///
  /// In en, this message translates to:
  /// **'Makin\' Bacon — reset total score'**
  String get makinBaconButton;

  /// Body of Makin' Bacon confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Both pigs are touching. This resets your game score to 0 and ends your turn.'**
  String get makinBaconDialogBody;

  /// Used anywhere that cancel is needed
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Used anywhere that reset score is needed
  ///
  /// In en, this message translates to:
  /// **'Reset score'**
  String get resetScore;

  /// Error when current roll is incomplete
  ///
  /// In en, this message translates to:
  /// **'Select a position for both pigs'**
  String get turnNotComplete;

  /// Error when ending turn with no points to bank
  ///
  /// In en, this message translates to:
  /// **'Nothing to bank — roll first or finish the current roll'**
  String get nothingToBank;

  /// Message when opposite sides are rolled
  ///
  /// In en, this message translates to:
  /// **'Pig Out — turn score lost'**
  String get pigOutMessage;

  /// Title for end game dialog
  ///
  /// In en, this message translates to:
  /// **'End this game?'**
  String get endGameDialogTitle;

  /// Content for end game dialog
  ///
  /// In en, this message translates to:
  /// **'Scores will be cleared. Player names will be kept for the next game.'**
  String get endGameDialogContent;

  /// Enter player name input label
  ///
  /// In en, this message translates to:
  /// **'Enter player name'**
  String get enterPlayerName;

  /// Validation error when player name is empty
  ///
  /// In en, this message translates to:
  /// **'Please enter a player name'**
  String get playerNameRequired;

  /// Button to add a player on the setup screen
  ///
  /// In en, this message translates to:
  /// **'Add player'**
  String get addPlayerButton;

  /// Error when starting the game with less than 2 players
  ///
  /// In en, this message translates to:
  /// **'Add at least two players to start a game.'**
  String get minimumOfTwoPlayers;

  /// Start game button label
  ///
  /// In en, this message translates to:
  /// **'Start game'**
  String get startGameButton;

  /// End game confirm button label
  ///
  /// In en, this message translates to:
  /// **'End game'**
  String get endGameConfirmButton;

  /// Tooltip for ending the game
  ///
  /// In en, this message translates to:
  /// **'End game'**
  String get endGameTooltip;

  /// Player total score under the turn AppBar
  ///
  /// In en, this message translates to:
  /// **'Total score: {score}'**
  String totalScoreLabel(int score);

  /// Title for the scoreboard bottom sheet
  ///
  /// In en, this message translates to:
  /// **'Scoreboard'**
  String get scoreboardTitle;

  /// Tooltip for opening the scoreboard
  ///
  /// In en, this message translates to:
  /// **'Open scoreboard'**
  String get scoreboardTooltip;

  /// Title on the winner screen
  ///
  /// In en, this message translates to:
  /// **'Game over'**
  String get gameOverTitle;

  /// Winner celebration message
  ///
  /// In en, this message translates to:
  /// **'{name} wins!'**
  String winnerMessage(String name);

  /// Button on winner screen to return to setup
  ///
  /// In en, this message translates to:
  /// **'Play again'**
  String get playAgainButton;

  /// Tooltip for removing a player from the setup list
  ///
  /// In en, this message translates to:
  /// **'Remove player'**
  String get removePlayerTooltip;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
