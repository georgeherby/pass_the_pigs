import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pass_the_pigs/pages/turn/cubit/turn_cubit.dart';
import 'package:pass_the_pigs/pages/turn/enums/pig.dart';
import 'package:pass_the_pigs/pages/turn/enums/position.dart';

class ChoiceButton extends StatefulWidget {
  const ChoiceButton({
    super.key,
    required this.valueOfButton,
    required this.pig,
  });

  final Position valueOfButton;
  final Pig pig;

  @override
  State<ChoiceButton> createState() => _ChoiceButtonState();
}

class _ChoiceButtonState extends State<ChoiceButton> {
  @override
  Widget build(BuildContext context) {
    var isSelected =
        context.read<TurnCalculatorCubit>().state.getPigPosition(widget.pig) ==
            widget.valueOfButton;

    return FilterChip(
      showCheckmark: false,
      selected: isSelected,
      onSelected: (state) {
        isSelected = state;
        if (isSelected) {
          context
              .read<TurnCalculatorCubit>()
              .addPig(widget.pig, widget.valueOfButton);
        } else {
          context.read<TurnCalculatorCubit>().removePig(widget.pig);
        }
        setState(() {});
      },
      label: SizedBox(
        width: MediaQuery.of(context).size.width * 0.3,
        child: Center(
          child: Column(
            children: [
              Text(
                widget.valueOfButton.displayText,
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
