import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pass_the_pigs/theme/color_schemes.g.dart';
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
    final colorScheme = Theme.of(context).colorScheme;
    final isSelected =
        context.watch<TurnCalculatorCubit>().currentThrow.getPigPosition(pig) ==
            valueOfButton;

    return FilterChip(
      showCheckmark: false,
      selected: isSelected,
      shape: appShape(),
      side: BorderSide.none,
      selectedColor: colorScheme.secondaryContainer,
      backgroundColor: colorScheme.surfaceContainerHighest,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.standard,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      labelPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      labelStyle: TextStyle(color: colorScheme.onSurface),
      onSelected: (selected) {
        if (selected) {
          context.read<TurnCalculatorCubit>().addPig(pig, valueOfButton);
        } else {
          context.read<TurnCalculatorCubit>().removePig(pig);
        }
      },
      label: SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.28,
        child: Text(
          valueOfButton.displayText,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
