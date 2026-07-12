import 'package:flutter_test/flutter_test.dart';
import 'package:pass_the_pigs/common/common.dart';
import 'package:pass_the_pigs/ui/game/models/game.dart';
import 'package:pass_the_pigs/ui/game/models/player.dart';
import 'package:pass_the_pigs/ui/game/storage/game_storage.dart';
import 'package:pass_the_pigs/ui/turn/enums/position.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('Game serialization', () {
    test('round-trips an in-progress game', () {
      const game = Game(
        isGameActive: true,
        currentPlayer: 1,
        players: [
          Player(
            id: 0,
            name: 'Alice',
            throws: [
              Throw(pigOne: Position.trotter, pigTwo: Position.sideNoSpot),
            ],
          ),
          Player(id: 1, name: 'Bob', throws: []),
        ],
      );

      final restored = Game.fromJson(game.toJson());
      expect(restored, game);
      expect(restored.players[0].score, 5);
    });

    test('withNamesOnly clears scores and deactivates', () {
      const game = Game(
        isGameActive: true,
        currentPlayer: 1,
        players: [
          Player(
            id: 0,
            name: 'Alice',
            throws: [
              Throw(pigOne: Position.trotter, pigTwo: Position.trotter),
            ],
          ),
        ],
      );

      final namesOnly = game.withNamesOnly();
      expect(namesOnly.isGameActive, isFalse);
      expect(namesOnly.currentPlayer, 0);
      expect(namesOnly.players.single.name, 'Alice');
      expect(namesOnly.players.single.throws, isEmpty);
    });
  });

  group('GameStorage', () {
    late GameStorage storage;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      storage = GameStorage(await SharedPreferences.getInstance());
    });

    test('returns null when nothing saved', () async {
      expect(await storage.load(), isNull);
    });

    test('persists mid-game progress for resume', () async {
      const game = Game(
        isGameActive: true,
        currentPlayer: 0,
        players: [
          Player(
            id: 0,
            name: 'Alice',
            throws: [
              Throw(pigOne: Position.snouter, pigTwo: Position.sideSpot),
            ],
          ),
          Player(id: 1, name: 'Bob', throws: []),
        ],
      );

      await storage.save(game);
      final loaded = await storage.load();

      expect(loaded, isNotNull);
      expect(loaded!.isGameActive, isTrue);
      expect(loaded.players[0].score, 10);
      expect(loaded.players[1].name, 'Bob');
    });

    test('persists names only after win', () async {
      final winningThrows = List.generate(
        5,
        (_) => const Throw(
          pigOne: Position.leaningJowler,
          pigTwo: Position.leaningJowler,
        ),
      );
      final game = Game(
        isGameActive: true,
        currentPlayer: 0,
        players: [
          Player(id: 0, name: 'Alice', throws: winningThrows),
          const Player(id: 1, name: 'Bob', throws: []),
        ],
      );
      expect(game.hasWinner, isTrue);

      await storage.save(game);
      final loaded = await storage.load();

      expect(loaded!.isGameActive, isFalse);
      expect(loaded.hasWinner, isFalse);
      expect(loaded.players.map((p) => p.name), ['Alice', 'Bob']);
      expect(loaded.players.every((p) => p.throws.isEmpty), isTrue);
    });

    test('persists names only when game is inactive', () async {
      const game = Game(
        isGameActive: false,
        players: [
          Player(
            id: 0,
            name: 'Alice',
            throws: [
              Throw(pigOne: Position.trotter, pigTwo: Position.sideNoSpot),
            ],
          ),
        ],
      );

      await storage.save(game);
      final loaded = await storage.load();

      expect(loaded!.isGameActive, isFalse);
      expect(loaded.players.single.name, 'Alice');
      expect(loaded.players.single.throws, isEmpty);
    });
  });
}
