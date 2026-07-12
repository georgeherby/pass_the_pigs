import 'package:pass_the_pigs/app/app.dart';
import 'package:pass_the_pigs/bootstrap.dart';

void main() {
  bootstrap(
    (data) => App(
      gameStorage: data.gameStorage,
      initialGame: data.initialGame,
    ),
  );
}
