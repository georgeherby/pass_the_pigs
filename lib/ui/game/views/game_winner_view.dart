import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pass_the_pigs/ui/game/cubit/game_cubit.dart';

class GameWinnerView extends StatefulWidget {
  const GameWinnerView(
      {super.key, required this.winnerName, required this.score});
  final String winnerName;
  final int score;

  @override
  State<GameWinnerView> createState() => _GameWinnerViewState();
}

class _GameWinnerViewState extends State<GameWinnerView> {
  late ConfettiController _controllerCenter;

  @override
  void initState() {
    super.initState();
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 10));
    _controllerCenter.play();
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.logout_rounded),
            tooltip: 'End game',
            onPressed: () => context.read<GameCubit>().endGame()),
        centerTitle: true,
        title: const Text('Game over'),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: ConfettiWidget(
                confettiController: _controllerCenter,
                blastDirectionality: BlastDirectionality
                    .explosive, // don't specify a direction, blast randomly
                shouldLoop:
                    true, // start again as soon as the animation is finished
                colors: const [
                  Colors.green,
                  Colors.blue,
                  Colors.pink,
                  Colors.orange,
                  Colors.purple
                ],
              ),
            ),
            Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(widget.score.toString(),
                        style: Theme.of(context).textTheme.displayLarge),
                    Text('${widget.winnerName} wins!',
                        style: Theme.of(context).textTheme.displaySmall),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
