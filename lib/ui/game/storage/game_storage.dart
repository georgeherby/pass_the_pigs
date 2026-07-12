import 'dart:convert';

import 'package:pass_the_pigs/ui/game/models/game.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameStorage {
  GameStorage(this._prefs);

  static const gameKey = 'pass_the_pigs.game';

  final SharedPreferences _prefs;

  Future<Game?> load() async {
    final raw = _prefs.getString(gameKey);
    if (raw == null || raw.isEmpty) return null;
    try {
      return Game.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } on Object {
      return null;
    }
  }

  /// Persists an in-progress game, or names only after win/exit.
  Future<void> save(Game game) async {
    final toStore =
        game.isGameActive && !game.hasWinner ? game : game.withNamesOnly();
    await _prefs.setString(gameKey, jsonEncode(toStore.toJson()));
  }

  Future<void> clear() async {
    await _prefs.remove(gameKey);
  }
}
