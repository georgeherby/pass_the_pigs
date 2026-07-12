import 'package:equatable/equatable.dart';
import 'package:pass_the_pigs/ui/turn/enums/pig.dart';
import 'package:pass_the_pigs/ui/turn/enums/position.dart';

class Throw extends Equatable {
  const Throw({this.pigOne, this.pigTwo});

  factory Throw.fromJson(Map<String, dynamic> json) {
    return Throw(
      pigOne: _positionFromName(json['pigOne'] as String?),
      pigTwo: _positionFromName(json['pigTwo'] as String?),
    );
  }

  final Position? pigOne;
  final Position? pigTwo;

  bool get isThrowComplete => pigOne != null && pigTwo != null;

  bool get isEmpty => pigOne == null && pigTwo == null;

  /// Pig Out: pigs land on opposite sides (dot vs no-dot).
  bool get isPigOut {
    if (!isThrowComplete) return false;
    return (pigOne == Position.sideNoSpot && pigTwo == Position.sideSpot) ||
        (pigOne == Position.sideSpot && pigTwo == Position.sideNoSpot);
  }

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

  int? getScore() {
    if (!isThrowComplete) {
      return null;
    }
    if (isPigOut) {
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
    }

    return _getValueForPosition(pigOne!) + _getValueForPosition(pigTwo!);
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

  Map<String, dynamic> toJson() => {
        'pigOne': pigOne?.name,
        'pigTwo': pigTwo?.name,
      };

  static Position? _positionFromName(String? name) {
    if (name == null) return null;
    return Position.values.byName(name);
  }

  @override
  List<Object?> get props => [pigOne, pigTwo];
}
