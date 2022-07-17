import 'package:equatable/equatable.dart';
import 'package:pass_the_pigs/pages/game/models/player.dart';

class Game extends Equatable {
  const Game(
      {this.currentPlayer = 0,
      this.players = const [],
      this.isGameActive = false});

  factory Game.initial() {
    return const Game(
      currentPlayer: 0,
      players: [],
      isGameActive: false,
    );
  }

  final int currentPlayer;
  final List<Player> players;
  final bool isGameActive;

  @override
  List<Object> get props => [currentPlayer, players, isGameActive];

  Game copyWith({
    int? currentPlayer,
    List<Player>? players,
    bool? isGameActive,
  }) {
    return Game(
      currentPlayer: currentPlayer ?? this.currentPlayer,
      players: players ?? this.players,
      isGameActive: isGameActive ?? this.isGameActive,
    );
  }

  Game updatePlayer(Player updatedPlayer) {
    return copyWith(
      players: players
          .map(
            (player) => player.id == updatedPlayer.id ? updatedPlayer : player,
          )
          .toList(),
    );
  }
}
