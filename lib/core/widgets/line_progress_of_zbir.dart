import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../theme/text_style.dart';

class LineProgressOfZbir extends StatelessWidget {
  const LineProgressOfZbir({super.key, required this.collected, required this.goal});

  final double collected;
  final double goal;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("₴${collected.toStringAsFixed(0)}",
                style: bodyMedium14Text.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer)),
            Text("₴${goal.toStringAsFixed(0)}",
                style: bodyMedium14Text.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer)),
          ],
        ),
        LinearProgressIndicator(
          minHeight: 12,
          borderRadius: BorderRadius.circular(10),
          value: collected / goal,
          backgroundColor: bg200Color,
          valueColor: const AlwaysStoppedAnimation<Color>(primary200Color),
        ),
      ],
    );
  }
}
