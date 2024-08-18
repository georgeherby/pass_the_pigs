import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pass_the_pigs/ui/turn/cubit/turn_cubit.dart';
import 'package:pass_the_pigs/ui/turn/enums/pig.dart';
import 'package:pass_the_pigs/ui/turn/enums/position.dart';

class ChoiceButton extends StatelessWidget {
  const ChoiceButton({
    super.key,
    required this.valueOfButton,
    required this.pig,
  });

  final Position valueOfButton;
  final Pig pig;

  @override
  Widget build(BuildContext context) {
    final isSelected =
        context.watch<TurnCalculatorCubit>().currentThrow.getPigPosition(pig) ==
            valueOfButton;

    return FilterChip(
      showCheckmark: false,
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          context.read<TurnCalculatorCubit>().addPig(pig, valueOfButton);
        } else {
          context.read<TurnCalculatorCubit>().removePig(pig);
        }
      },
      label: SizedBox(
        width: MediaQuery.of(context).size.width * 0.3,
        child: Center(
          child: Column(
            children: [
              Text(
                valueOfButton.displayText,
                style: TextStyle(
                    color: isSelected
                        ? Theme.of(context).colorScheme.onSecondaryContainer
                        : Theme.of(context).colorScheme.onSurface),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
