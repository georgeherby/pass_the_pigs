// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appBarTitle => 'Pass The Pigs';

  @override
  String get resetButton => 'Reset';

  @override
  String get pigOneLabel => 'Pig One';

  @override
  String get pigTwoLabel => 'Pig Two';

  @override
  String get rollScoreLabel => 'Roll';

  @override
  String get turnScoreLabel => 'Turn';

  @override
  String get endTurnButtonLabel => 'Save and end turn';

  @override
  String get nextPlayerFab => 'Save and end turn';

  @override
  String get saveAndRollAgain => 'Save and roll again';

  @override
  String get makinBacon => 'Makin\' Bacon (reset total score)';

  @override
  String get makinBaconDialogBody =>
      'Both pigs are touching. This will reset your game score to 0 and end your turn.';

  @override
  String get cancel => 'Cancel';

  @override
  String get resetScore => 'Reset score';

  @override
  String get turnNotComplete => 'Select a position for both pigs';

  @override
  String get nothingToBank =>
      'Nothing to bank — roll first or finish the current roll';

  @override
  String get pigOutMessage => 'Pig Out — turn score lost';

  @override
  String get endGameDialogTitle => 'Are you sure?';

  @override
  String get endGameDialogContent =>
      'This will result in the termination of the game and the loss of your existing scorecard.';

  @override
  String get enterPlayerName => 'Enter player name';

  @override
  String get minimumOfTwoPlayers =>
      'A minimum of two players are needed to start a game.';

  @override
  String get startGameButton => 'Start game';

  @override
  String get endGameConfirmButton => 'End game';
}
