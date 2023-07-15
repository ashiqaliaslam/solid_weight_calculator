import 'package:flutter/material.dart';
import 'package:solid_weight_calculator/src/models/functions.dart';
import 'package:solid_weight_calculator/src/ui/text_styles.dart';

class DurationMoreThan24Hours extends StatelessWidget {
  const DurationMoreThan24Hours({
    super.key,
    required this.totalDuration,
  });

  final Duration totalDuration;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Column(
        children: [
          errorText('⛔️ The total duration cannot exceed 24 hours.'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 5),
              largeErrorText(formattedDuration(totalDuration)),
              const SizedBox(width: 5),
              largeErrorText('Hours'),
            ],
          ),
        ],
      ),
    );
  }
}
