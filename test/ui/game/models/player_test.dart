import 'package:flutter_test/flutter_test.dart';
import 'package:pass_the_pigs/common/common.dart';
import 'package:pass_the_pigs/ui/game/models/player.dart';
import 'package:pass_the_pigs/ui/turn/enums/position.dart';

void main() {
  group('Player', () {
    Player playerWithScore(int target) {
      // Double leaning jowler = 60; use enough throws to reach target.
      final throws = <Throw>[];
      var remaining = target;
      while (remaining >= 60) {
        throws.add(
          const Throw(
            pigOne: Position.leaningJowler,
            pigTwo: Position.leaningJowler,
          ),
        );
        remaining -= 60;
      }
      while (remaining >= 20) {
        throws.add(
          const Throw(
            pigOne: Position.trotter,
            pigTwo: Position.trotter,
          ),
        );
        remaining -= 20;
      }
      while (remaining >= 5) {
        throws.add(
          const Throw(
            pigOne: Position.trotter,
            pigTwo: Position.sideNoSpot,
          ),
        );
        remaining -= 5;
      }
      while (remaining > 0) {
        throws.add(
          const Throw(
            pigOne: Position.sideNoSpot,
            pigTwo: Position.sideNoSpot,
          ),
        );
        remaining -= 1;
      }
      return Player(id: 0, name: 'Test', throws: throws);
    }

    test('is not winner below 100', () {
      expect(playerWithScore(99).isWinner, isFalse);
    });

    test('is winner at exactly 100', () {
      final player = playerWithScore(100);
      expect(player.score, 100);
      expect(player.isWinner, isTrue);
    });

    test('is winner above 100', () {
      expect(playerWithScore(101).isWinner, isTrue);
    });
  });
}
