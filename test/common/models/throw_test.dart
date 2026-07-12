import 'package:flutter_test/flutter_test.dart';
import 'package:pass_the_pigs/common/common.dart';
import 'package:pass_the_pigs/ui/turn/enums/position.dart';

void main() {
  group('Throw', () {
    test('incomplete throw has null score', () {
      expect(const Throw().getScore(), isNull);
      expect(const Throw(pigOne: Position.trotter).getScore(), isNull);
    });

    test('sider scores 1', () {
      expect(
        const Throw(
          pigOne: Position.sideNoSpot,
          pigTwo: Position.sideNoSpot,
        ).getScore(),
        1,
      );
      expect(
        const Throw(
          pigOne: Position.sideSpot,
          pigTwo: Position.sideSpot,
        ).getScore(),
        1,
      );
    });

    test('isPigOut for opposite sides in either order', () {
      const noSpotThenSpot = Throw(
        pigOne: Position.sideNoSpot,
        pigTwo: Position.sideSpot,
      );
      const spotThenNoSpot = Throw(
        pigOne: Position.sideSpot,
        pigTwo: Position.sideNoSpot,
      );

      expect(noSpotThenSpot.isPigOut, isTrue);
      expect(spotThenNoSpot.isPigOut, isTrue);
      expect(noSpotThenSpot.getScore(), 0);
      expect(spotThenNoSpot.getScore(), 0);
    });

    test('doubles score correctly', () {
      expect(
        const Throw(
          pigOne: Position.razorback,
          pigTwo: Position.razorback,
        ).getScore(),
        20,
      );
      expect(
        const Throw(
          pigOne: Position.trotter,
          pigTwo: Position.trotter,
        ).getScore(),
        20,
      );
      expect(
        const Throw(
          pigOne: Position.snouter,
          pigTwo: Position.snouter,
        ).getScore(),
        40,
      );
      expect(
        const Throw(
          pigOne: Position.leaningJowler,
          pigTwo: Position.leaningJowler,
        ).getScore(),
        60,
      );
    });

    test('mixed combo sums individual values', () {
      expect(
        const Throw(
          pigOne: Position.trotter,
          pigTwo: Position.snouter,
        ).getScore(),
        15,
      );
      expect(
        const Throw(
          pigOne: Position.razorback,
          pigTwo: Position.sideNoSpot,
        ).getScore(),
        5,
      );
    });

    test('single scoring position with sider companion', () {
      expect(
        const Throw(
          pigOne: Position.leaningJowler,
          pigTwo: Position.sideSpot,
        ).getScore(),
        15,
      );
    });
  });
}
