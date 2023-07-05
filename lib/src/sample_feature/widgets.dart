import 'package:flutter/material.dart';
import 'package:solid_weight_calculator/src/models/extensions.dart';

import '../ui/text_styles.dart';

/// TimePickerButton to pick the time
class TimePickerButton extends StatelessWidget {
  final String labelText;
  final TimeOfDay time;
  final Function(TimeOfDay) onTimeChanged;

  const TimePickerButton({
    super.key,
    required this.labelText,
    required this.time,
    required this.onTimeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(labelText),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            // minimumSize: const Size.fromHeight(45),
            // maximumSize: const Size.fromHeight(45),
            // padding: const EdgeInsets.all(5.0),
            elevation: 10,
          ),
          onPressed: () {
            showTimePicker(
              context: context,
              initialTime: time,
              useRootNavigator: false,
              builder: (BuildContext context, Widget? child) {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                    alwaysUse24HourFormat: true,
                  ),
                  child: child!,
                );
              },
            ).then((pickedTime) {
              if (pickedTime != null) {
                onTimeChanged(pickedTime);
              }
            });
          },
          child: Text(time.to24Hours()),
        ),
      ],
    );
  }
}

/// Calculate duration from two TimeOfDay values
class TimeToDuration {
  static String duration(TimeOfDay startTime, TimeOfDay endTime) {
    DateTime now = DateTime.now().toUtc();
    final startDateTime = DateTime(
        now.year, now.month, now.day, startTime.hour, startTime.minute);
    final endDateTime =
        DateTime(now.year, now.month, now.day, endTime.hour, endTime.minute);
    Duration difference = endDateTime.difference(startDateTime);
    return '${difference.inHours.toString().padLeft(2, '0')}:${(difference.inMinutes % 60).toString().padLeft(2, '0')}';
  }
}

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
      children: [
        Text(labelText),
        TextFormField(
          initialValue: '',
          decoration: InputDecoration(
            // labelText: labelText,
            hintText: hintText,
            // floatingLabelAlignment: FloatingLabelAlignment.center,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            contentPadding: const EdgeInsets.all(10),
            isCollapsed: true,
            constraints: const BoxConstraints(maxWidth: 100),
            border: const OutlineInputBorder(
              // borderSide: BorderSide(width: 2.0),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            // contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          ),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'Please enter the lime weight';
            }
            return null;
          },
          onChanged: (value) {
            onLevelChanged(double.tryParse(value) ?? 0);
          },
        ),
      ],
    );
  }
}

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
      mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Text(label),
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
