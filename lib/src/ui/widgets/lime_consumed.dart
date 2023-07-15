import 'package:flutter/material.dart';
import 'package:solid_weight_calculator/src/ui/text_styles.dart';

class LimeConsumed extends StatelessWidget {
  const LimeConsumed({
    super.key,
    required this.totalWeight,
  });

  final double totalWeight;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Column(
        children: [
          mediumText('Total Lime Weight'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              largeText(totalWeight.toStringAsFixed(2)),
              const SizedBox(width: 5),
              largeText('Ton'),
            ],
          ),
        ],
      ),
    );
  }
}
