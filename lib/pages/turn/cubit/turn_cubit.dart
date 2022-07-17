import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pass_the_pigs/common/common.dart';
import 'package:pass_the_pigs/pages/turn/enums/pig.dart';
import 'package:pass_the_pigs/pages/turn/enums/position.dart';

class TurnCalculatorCubit extends Cubit<Throw> {
  TurnCalculatorCubit() : super(const Throw());

  void addPig(Pig pig, Position position) {
    switch (pig) {
      case Pig.one:
        return emit(state.copyWith(pigOne: position));
      case Pig.two:
        return emit(state.copyWith(pigTwo: position));
    }
  }

  void addPigTwo(Position position) => emit(state.copyWith(pigTwo: position));

  void removePig(Pig pig) => emit(state.removePig(pig));

  void reset() => emit(const Throw());
}
