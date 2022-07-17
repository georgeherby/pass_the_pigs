import 'package:equatable/equatable.dart';
import 'package:pass_the_pigs/pages/turn/enums/pig.dart';
import 'package:pass_the_pigs/pages/turn/enums/position.dart';

class Throw extends Equatable {
  const Throw({this.pigOne, this.pigTwo});

  final Position? pigOne;
  final Position? pigTwo;

  bool get isTurnComplete => pigOne != null && pigTwo != null;

  Throw removePig(Pig pig) {
    switch (pig) {
      case Pig.one:
        return Throw(pigTwo: pigTwo);
      case Pig.two:
        return Throw(pigOne: pigOne);
    }
  }

  int _getValueForPosition(Position position) {
    switch (position) {
      case Position.razorback:
      case Position.trotter:
        return 5;
      case Position.snouter:
        return 10;
      case Position.leaningJowler:
        return 15;
      case Position.sideNoSpot:
      case Position.sideSpot:
        return 0;
    }
  }

  int getScore() {
    if (pigOne == null && pigTwo == null) {
      return 0;
    }
    if (pigOne == pigTwo) {
      switch (pigOne!) {
        case Position.leaningJowler:
          return 60;
        case Position.snouter:
          return 40;
        case Position.razorback:
        case Position.trotter:
          return 20;
        case Position.sideNoSpot:
        case Position.sideSpot:
          return 1;
      }
    } else {
      if (pigOne == Position.sideNoSpot && pigTwo == Position.sideSpot) {
        return 0;
      }
      var score = 0;
      if (pigOne != null) {
        score += _getValueForPosition(pigOne!);
      }
      if (pigTwo != null) {
        score += _getValueForPosition(pigTwo!);
      }
      return score;
    }
  }

  Throw copyWith({
    Position? pigOne,
    Position? pigTwo,
  }) {
    return Throw(
      pigOne: pigOne ?? this.pigOne,
      pigTwo: pigTwo ?? this.pigTwo,
    );
  }

  Position? getPigPosition(Pig pig) {
    switch (pig) {
      case Pig.one:
        return pigOne;
      case Pig.two:
        return pigTwo;
    }
  }

  @override
  List<Object?> get props => [pigOne, pigTwo];
}
