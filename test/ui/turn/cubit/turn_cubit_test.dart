import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pass_the_pigs/common/common.dart';
import 'package:pass_the_pigs/ui/turn/cubit/turn_cubit.dart';
import 'package:pass_the_pigs/ui/turn/enums/pig.dart';
import 'package:pass_the_pigs/ui/turn/enums/position.dart';
import 'package:pass_the_pigs/ui/turn/models/turn_action_result.dart';

void main() {
  group('TurnCalculatorCubit', () {
    late TurnCalculatorCubit cubit;

    setUp(() {
      cubit = TurnCalculatorCubit();
    });

    tearDown(() async {
      await cubit.close();
    });

    void selectCompleteThrow(Position one, Position two) {
      cubit
        ..addPig(Pig.one, one)
        ..addPig(Pig.two, two);
    }

    test('commitRoll rejects incomplete throw', () {
      cubit.addPig(Pig.one, Position.trotter);
      expect(cubit.commitRoll(gameScore: 0), isA<TurnIncomplete>());
      expect(cubit.state, isEmpty);
    });

    blocTest<TurnCalculatorCubit, List<Throw>>(
      'commitRoll accumulates scoring rolls',
      build: TurnCalculatorCubit.new,
      act: (cubit) {
        cubit
          ..addPig(Pig.one, Position.trotter)
          ..addPig(Pig.two, Position.sideNoSpot);
        expect(cubit.commitRoll(gameScore: 0), isA<TurnContinue>());
        cubit
          ..addPig(Pig.one, Position.snouter)
          ..addPig(Pig.two, Position.sideSpot);
        expect(cubit.commitRoll(gameScore: 0), isA<TurnContinue>());
      },
      expect: () => [
        isA<List<Throw>>(),
        isA<List<Throw>>(),
        [
          const Throw(pigOne: Position.trotter, pigTwo: Position.sideNoSpot),
        ],
        isA<List<Throw>>(),
        isA<List<Throw>>(),
        [
          const Throw(pigOne: Position.trotter, pigTwo: Position.sideNoSpot),
          const Throw(pigOne: Position.snouter, pigTwo: Position.sideSpot),
        ],
      ],
      verify: (cubit) {
        expect(cubit.getTurnScore(), 15);
        expect(cubit.currentThrow.isEmpty, isTrue);
      },
    );

    test('commitRoll on Pig Out discards turn score', () {
      selectCompleteThrow(Position.trotter, Position.sideNoSpot);
      expect(cubit.commitRoll(gameScore: 0), isA<TurnContinue>());
      expect(cubit.getTurnScore(), 5);

      selectCompleteThrow(Position.sideNoSpot, Position.sideSpot);
      expect(cubit.commitRoll(gameScore: 0), isA<TurnPigOut>());
      expect(cubit.state, isEmpty);
      expect(cubit.getTurnScore(), 0);
      expect(cubit.currentThrow.isEmpty, isTrue);
    });

    test('commitRoll banks immediately when game + turn score reaches 100', () {
      selectCompleteThrow(Position.trotter, Position.sideNoSpot);
      expect(cubit.commitRoll(gameScore: 0), isA<TurnContinue>());

      // Double leaning jowler = 60; with prior 5 and gameScore 35 → 100.
      selectCompleteThrow(Position.leaningJowler, Position.leaningJowler);
      final result = cubit.commitRoll(gameScore: 35);

      expect(result, isA<TurnBanked>());
      final banked = result as TurnBanked;
      expect(
        banked.throws.fold<int>(0, (sum, t) => sum + (t.getScore() ?? 0)),
        65,
      );
      expect(cubit.state, isEmpty);
    });

    test('bankTurn after roll-again with empty current throw', () {
      selectCompleteThrow(Position.razorback, Position.sideSpot);
      expect(cubit.commitRoll(gameScore: 0), isA<TurnContinue>());

      final result = cubit.bankTurn();
      expect(result, isA<TurnBanked>());
      final banked = result as TurnBanked;
      expect(banked.throws, hasLength(1));
      expect(banked.throws.first.getScore(), 5);
      expect(cubit.state, isEmpty);
    });

    test('bankTurn includes in-progress complete scoring throw', () {
      selectCompleteThrow(Position.trotter, Position.sideNoSpot);
      cubit.commitRoll(gameScore: 0);
      selectCompleteThrow(Position.snouter, Position.sideSpot);

      final result = cubit.bankTurn();
      expect(result, isA<TurnBanked>());
      final banked = result as TurnBanked;
      expect(banked.throws, hasLength(2));
      expect(
        banked.throws.fold<int>(0, (sum, t) => sum + (t.getScore() ?? 0)),
        15,
      );
    });

    test('bankTurn on Pig Out discards turn', () {
      selectCompleteThrow(Position.trotter, Position.sideNoSpot);
      cubit.commitRoll(gameScore: 0);
      selectCompleteThrow(Position.sideSpot, Position.sideNoSpot);

      expect(cubit.bankTurn(), isA<TurnPigOut>());
      expect(cubit.state, isEmpty);
    });

    test('bankTurn with nothing to bank', () {
      expect(cubit.bankTurn(), isA<TurnNothingToBank>());
    });

    test('bankTurn rejects partial current throw', () {
      selectCompleteThrow(Position.trotter, Position.sideNoSpot);
      cubit.commitRoll(gameScore: 0);
      cubit.addPig(Pig.one, Position.snouter);

      expect(cubit.bankTurn(), isA<TurnIncomplete>());
      expect(cubit.state, hasLength(1));
    });

    test('resolveOinker clears turn state', () {
      selectCompleteThrow(Position.trotter, Position.sideNoSpot);
      cubit.commitRoll(gameScore: 0);

      expect(cubit.resolveOinker(), isA<TurnOinker>());
      expect(cubit.state, isEmpty);
      expect(cubit.currentThrow.isEmpty, isTrue);
    });
  });
}
