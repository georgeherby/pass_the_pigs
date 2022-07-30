import 'package:bloc/bloc.dart';
import 'package:pass_the_pigs/common/common.dart';
import 'package:pass_the_pigs/ui/game/models/game.dart';
import 'package:pass_the_pigs/ui/game/models/player.dart';

class GameCubit extends Cubit<Game> {
  GameCubit() : super(Game.initial());

  void startGame() {
    emit(state.copyWith(isGameActive: true));
  }

  void endGame() {
    emit(state.copyWith(
        isGameActive: false,
        players: state.players.map((e) => e.copyWith(throws: [])).toList()));
  }

  void addPlayer(String playerName) {
    emit(state.copyWith(players: [
      ...state.players,
      Player(id: state.players.length, name: playerName, throws: const [])
    ]));
  }

  void removePlayer(int playerId) {
    emit(state.copyWith(
        players:
            state.players.where((player) => player.id != playerId).toList()));
  }

  void nextPlayer() {
    if (state.currentPlayer == state.players.length - 1) {
      emit(state.copyWith(currentPlayer: 0));
    } else {
      emit(state.copyWith(currentPlayer: state.currentPlayer + 1));
    }
  }

  void addThrowToPlayer(Throw newThrow) {
    final player = state.players[state.currentPlayer];

    final updatedPlayer = player.addThrowToPlayer(newThrow);

    emit(state.updatePlayer(updatedPlayer));
  }

  void makingBacon() {
    final player = state.players[state.currentPlayer];
    final updatedPlayer = player.makingBacon();

    emit(state.updatePlayer(updatedPlayer));
  }
}
