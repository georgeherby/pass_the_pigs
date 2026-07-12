import 'package:equatable/equatable.dart';
import 'package:pass_the_pigs/ui/game/models/player.dart';

class Game extends Equatable {
  const Game({
    this.currentPlayer = 0,
    this.players = const [],
    this.isGameActive = false,
  });

  factory Game.initial() {
    return const Game(
      currentPlayer: 0,
      players: [],
      isGameActive: false,
    );
  }

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      currentPlayer: json['currentPlayer'] as int? ?? 0,
      isGameActive: json['isGameActive'] as bool? ?? false,
      players: (json['players'] as List<dynamic>? ?? [])
          .map((p) => Player.fromJson(p as Map<String, dynamic>))
          .toList(),
    );
  }

  final int currentPlayer;
  final List<Player> players;
  final bool isGameActive;

  bool get hasWinner =>
      isGameActive && players.any((player) => player.isWinner);

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

  /// Players with scores cleared, inactive — used after win/exit for name persistence.
  Game withNamesOnly() {
    return Game(
      currentPlayer: 0,
      isGameActive: false,
      players: players
          .map((p) => Player(id: p.id, name: p.name, throws: const []))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'currentPlayer': currentPlayer,
        'isGameActive': isGameActive,
        'players': players.map((p) => p.toJson()).toList(),
      };

  @override
  List<Object> get props => [currentPlayer, players, isGameActive];
}
