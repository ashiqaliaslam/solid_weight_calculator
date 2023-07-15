import 'package:flutter/material.dart';
import 'package:solid_weight_calculator/src/models/functions.dart';
import 'package:solid_weight_calculator/src/ui/text_styles.dart';

class ProjectedLimeWeight extends StatelessWidget {
  const ProjectedLimeWeight({
    super.key,
    required this.totalWeight,
    required this.totalDuration,
  });

  final double totalWeight;
  final Duration totalDuration;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        smallText('Projected Lime Consumed'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            largeBoldText(
                projectedWeight(totalWeight, totalDuration).toStringAsFixed(2)),
            const SizedBox(width: 5),
            largeText('Ton'),
          ],
        ),
      ],
    );
  }
}
