import 'package:flutter/material.dart';
import 'package:solid_weight_calculator/src/ui/text_styles.dart';

class CardCalculatedValues extends StatelessWidget {
  const CardCalculatedValues({
    super.key,
    required this.parameter,
    required this.label,
  });

  final String parameter;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Text(
            parameter,
            style: TextStyles.medium,
          ),
        ),
      ],
    );
  }
}
