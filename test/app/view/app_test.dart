import 'package:flutter_test/flutter_test.dart';
import 'package:pass_the_pigs/app/app.dart';
import 'package:pass_the_pigs/pages/game/game.dart';

void main() {
  group('App', () {
    testWidgets('renders GamePage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(GamePage), findsOneWidget);
    });
  });
}
