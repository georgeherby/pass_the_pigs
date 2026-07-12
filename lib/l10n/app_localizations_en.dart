// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appBarTitle => 'Pass the Pigs';

  @override
  String get pigOneLabel => 'Pig One';

  @override
  String get pigTwoLabel => 'Pig Two';

  @override
  String get rollScoreLabel => 'Roll';

  @override
  String get turnScoreLabel => 'Turn';

  @override
  String get nextPlayerFab => 'Save and end turn';

  @override
  String get saveAndRollAgain => 'Save and roll again';

  @override
  String get makinBacon => 'Makin\' Bacon';

  @override
  String get makinBaconButton => 'Makin\' Bacon — reset total score';

  @override
  String get makinBaconDialogBody =>
      'Both pigs are touching. This resets your game score to 0 and ends your turn.';

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
  String get endGameDialogTitle => 'End this game?';

  @override
  String get endGameDialogContent =>
      'Scores will be cleared. Player names will be kept for the next game.';

  @override
  String get enterPlayerName => 'Enter player name';

  @override
  String get playerNameRequired => 'Please enter a player name';

  @override
  String get addPlayerButton => 'Add player';

  @override
  String get minimumOfTwoPlayers => 'Add at least two players to start a game.';

  @override
  String get startGameButton => 'Start game';

  @override
  String get endGameConfirmButton => 'End game';

  @override
  String get endGameTooltip => 'End game';

  @override
  String totalScoreLabel(int score) {
    return 'Total score: $score';
  }

  @override
  String get scoreboardTitle => 'Scoreboard';

  @override
  String get scoreboardTooltip => 'Open scoreboard';

  @override
  String get gameOverTitle => 'Game over';

  @override
  String winnerMessage(String name) {
    return '$name wins!';
  }

  @override
  String get playAgainButton => 'Play again';

  @override
  String get removePlayerTooltip => 'Remove player';
}
