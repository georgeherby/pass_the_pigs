import 'package:flutter_test/flutter_test.dart';
import 'package:pass_the_pigs/app/app.dart';
import 'package:pass_the_pigs/ui/game/game.dart';
import 'package:pass_the_pigs/ui/game/models/game.dart';
import 'package:pass_the_pigs/ui/game/storage/game_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('App', () {
    testWidgets('renders GamePage', (tester) async {
      SharedPreferences.setMockInitialValues({});
      final storage = GameStorage(await SharedPreferences.getInstance());

      await tester.pumpWidget(
        App(
          gameStorage: storage,
          initialGame: Game.initial(),
        ),
      );
      expect(find.byType(GamePage), findsOneWidget);
    });
  });
}
