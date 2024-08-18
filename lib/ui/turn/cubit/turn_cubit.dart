import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pass_the_pigs/common/common.dart';
import 'package:pass_the_pigs/ui/turn/enums/pig.dart';
import 'package:pass_the_pigs/ui/turn/enums/position.dart';

class TurnCalculatorCubit extends Cubit<List<Throw>> {
  TurnCalculatorCubit() : super([]);

  Throw _currentThrow = const Throw();

  Throw get currentThrow => _currentThrow;

  void addPig(Pig pig, Position position) {
    switch (pig) {
      case Pig.one:
        _currentThrow = _currentThrow.copyWith(pigOne: position);
        break;
      case Pig.two:
        _currentThrow = _currentThrow.copyWith(pigTwo: position);
        break;
    }
    emit(List.from(state));
  }

  void removePig(Pig pig) {
    _currentThrow = _currentThrow.removePig(pig);
    emit(List.from(state));
  }

  void saveThrowToTurnAndResetThrow() {
    if (_currentThrow.isThrowComplete) {
      emit(List.from(state)..add(_currentThrow));
      _currentThrow =
          const Throw(); // Reset the current throw for the next turn
    } else {
      throw Exception('Cannot save an incomplete throw');
    }
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
