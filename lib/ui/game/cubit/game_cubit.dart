import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:pass_the_pigs/common/common.dart';
import 'package:pass_the_pigs/ui/game/models/game.dart';
import 'package:pass_the_pigs/ui/game/models/player.dart';
import 'package:pass_the_pigs/ui/game/storage/game_storage.dart';

class GameCubit extends Cubit<Game> {
  GameCubit({
    required GameStorage storage,
    Game? initialGame,
  })  : _storage = storage,
        super(initialGame ?? Game.initial());

  final GameStorage _storage;

  void _emitAndPersist(Game game) {
    emit(game);
    unawaited(_storage.save(game));
  }

  void startGame() {
    _emitAndPersist(state.copyWith(isGameActive: true, currentPlayer: 0));
  }

  void endGame() {
    _emitAndPersist(state.withNamesOnly());
  }

  void addPlayer(String playerName) {
    _emitAndPersist(state.copyWith(players: [
      ...state.players,
      Player(id: state.players.length, name: playerName, throws: const [])
    ]));
  }

  void removePlayer(int playerId) {
    _emitAndPersist(state.copyWith(
        players:
            state.players.where((player) => player.id != playerId).toList()));
  }

  void nextPlayer() {
    if (state.currentPlayer == state.players.length - 1) {
      _emitAndPersist(state.copyWith(currentPlayer: 0));
    } else {
      _emitAndPersist(state.copyWith(currentPlayer: state.currentPlayer + 1));
    }
  }

  void addTurnToPlayer(List<Throw> newThrows) {
    final player = state.players[state.currentPlayer];
    final updatedPlayer = player.addThrowsToPlayer(newThrows);
    _emitAndPersist(state.updatePlayer(updatedPlayer));
  }

  void resetAllThrows() {
    final player = state.players[state.currentPlayer];
    final updatedPlayer = player.resetAllThrows();
    _emitAndPersist(state.updatePlayer(updatedPlayer));
  }
}
