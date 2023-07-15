import 'package:flutter/material.dart';

class LevelInputField extends StatelessWidget {
  const LevelInputField({
    super.key,
    required this.onLevelChanged,
    required this.hintText,
    required this.labelText,
  });

  final ValueChanged<double> onLevelChanged;
  final String hintText;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(labelText),
        TextField(
          // initialValue: '',
          decoration: InputDecoration(
            // labelText: labelText,
            hintText: hintText,
            // floatingLabelAlignment: FloatingLabelAlignment.center,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            contentPadding: const EdgeInsets.all(6),
            isCollapsed: true,
            constraints: const BoxConstraints(maxWidth: 100),
            border: const OutlineInputBorder(
              // borderSide: BorderSide(width: 2.0),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            // contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          ),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            onLevelChanged(double.tryParse(value) ?? 0);
          },
        ),
      ],
    );
  }
}
