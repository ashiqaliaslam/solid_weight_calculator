import 'package:flutter/material.dart';
import 'package:solid_weight_calculator/src/models/functions.dart';
import 'package:solid_weight_calculator/src/ui/text_styles.dart';

class LimeConsumptionDuration extends StatelessWidget {
  const LimeConsumptionDuration({
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
          mediumText('Total Duration'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 5),
              largeText(formattedDuration(totalDuration)),
              const SizedBox(width: 5),
              largeText('Hours'),
            ],
          ),
        ],
      ),
    );
  }
}
