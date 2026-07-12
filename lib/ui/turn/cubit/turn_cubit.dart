import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pass_the_pigs/common/common.dart';
import 'package:pass_the_pigs/ui/turn/enums/pig.dart';
import 'package:pass_the_pigs/ui/turn/enums/position.dart';
import 'package:pass_the_pigs/ui/turn/models/turn_action_result.dart';

class TurnCalculatorCubit extends Cubit<List<Throw>> {
  TurnCalculatorCubit() : super([]);

  Throw _currentThrow = const Throw();

  Throw get currentThrow => _currentThrow;

  void addPig(Pig pig, Position position) {
    switch (pig) {
      case Pig.one:
        _currentThrow = _currentThrow.copyWith(pigOne: position);
      case Pig.two:
        _currentThrow = _currentThrow.copyWith(pigTwo: position);
    }
    emit(List.from(state));
  }

  void removePig(Pig pig) {
    _currentThrow = _currentThrow.removePig(pig);
    emit(List.from(state));
  }

  /// Commit the current roll and prepare for another roll this turn.
  ///
  /// If [gameScore] + the new turn total reaches 100, the turn is banked
  /// immediately and the player wins without needing to end the turn.
  TurnActionResult commitRoll({required int gameScore}) {
    if (!_currentThrow.isThrowComplete) {
      return const TurnIncomplete();
    }
    if (_currentThrow.isPigOut) {
      resetTurn();
      return const TurnPigOut();
    }
    emit(List.from(state)..add(_currentThrow));
    _currentThrow = const Throw();

    if (gameScore + getTurnScore() >= 100) {
      final throwsToBank = List<Throw>.from(state);
      resetTurn();
      return TurnBanked(throwsToBank);
    }

    return const TurnContinue();
  }

  /// Bank accumulated turn points (and any complete non-Pig-Out current roll).
  TurnActionResult bankTurn() {
    if (_currentThrow.isThrowComplete) {
      if (_currentThrow.isPigOut) {
        resetTurn();
        return const TurnPigOut();
      }
      emit(List.from(state)..add(_currentThrow));
      _currentThrow = const Throw();
    } else if (!_currentThrow.isEmpty) {
      return const TurnIncomplete();
    }

    if (state.isEmpty) {
      return const TurnNothingToBank();
    }

    final throwsToBank = List<Throw>.from(state);
    resetTurn();
    return TurnBanked(throwsToBank);
  }

  /// Clear turn state after an Oinker; caller wipes game score and advances.
  TurnActionResult resolveOinker() {
    resetTurn();
    return const TurnOinker();
  }

  void resetCurrentThrow() {
    _currentThrow = const Throw();
  }

  void resetTurn() {
    emit([]);
    resetCurrentThrow();
  }

  int getTurnScore() {
    return state.fold(
      0,
      (total, throwItem) => total + (throwItem.getScore() ?? 0),
    );
  }
}
