import 'package:flutter/material.dart';
import 'package:solid_weight_calculator/src/models/extensions.dart';
import 'package:solid_weight_calculator/src/models/functions.dart';

import '../ui/text_styles.dart';

/// [TimePickerButton] to pick the time
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
            padding: const EdgeInsets.all(0),
          ),
          onPressed: () async {
            await showTimePicker(
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

// / Calculate duration from two TimeOfDay values`
class TimeToDuration {
  static Duration durationAsTime(TimeOfDay startTime, TimeOfDay endTime) {
    DateTime now = DateTime.now().toUtc();
    DateTime tomorrow = DateTime.now().add(const Duration(days: 1)).toUtc();
    final startDateTime = DateTime(
        now.year, now.month, now.day, startTime.hour, startTime.minute);

    if (endTime == const TimeOfDay(hour: 00, minute: 00)) {
      final endDateTime = DateTime(tomorrow.year, tomorrow.month, tomorrow.day,
          endTime.hour, endTime.minute);
      Duration difference = endDateTime.difference(startDateTime);
      return difference;
    } else {
      final endDateTime =
          DateTime(now.year, now.month, now.day, endTime.hour, endTime.minute);
      Duration difference = endDateTime.difference(startDateTime);
      return difference;
    }
  }

  static String durationAsString(TimeOfDay startTime, TimeOfDay endTime) {
    return formattedDuration(durationAsTime(startTime, endTime));
  }
}

// class TimeToDuration {
//   static String durationAsString(TimeOfDay startTime, TimeOfDay endTime) {
//     final startDateTime = _getDateTime(startTime);
//     final endDateTime = _getDateTime(endTime);
//     final difference = endDateTime.difference(startDateTime);
//     return _formatDuration(difference);
//   }

//   static Duration durationAsTime(TimeOfDay startTime, TimeOfDay endTime) {
//     final startDateTime = _getDateTime(startTime);
//     final endDateTime = _getDateTime(endTime);
//     return endDateTime.difference(startDateTime);
//   }

//   static DateTime _getDateTime(TimeOfDay time) {
//     final now = DateTime.now().toUtc();
//     final tomorrow = DateTime.now().add(const Duration(days: 1)).toUtc();
//     return DateTime(
//       now.year,
//       now.month,
//       now.day,
//       time.hour,
//       time.minute,
//     );
//   }

//   static String _formatDuration(Duration duration) {
//     final hours = duration.inHours.toString().padLeft(2, '0');
//     final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
//     return '$hours:$minutes';
//   }
// }

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
        TextFormField(
          initialValue: '',
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


// class LevelInputField extends StatelessWidget {
//   const LevelInputField({
//     super.key,
//     required this.onLevelChanged,
//     required this.hintText,
//     required this.labelText,
//   });

//   final ValueChanged<double> onLevelChanged;
//   final String hintText;
//   final String labelText;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(labelText),
//         TextFormField(
//           initialValue: '',
//           decoration: InputDecoration(
//             // labelText: labelText,
//             hintText: hintText,
//             // floatingLabelAlignment: FloatingLabelAlignment.center,
//             floatingLabelBehavior: FloatingLabelBehavior.never,
//             contentPadding: const EdgeInsets.all(10),
//             isCollapsed: true,
//             constraints: const BoxConstraints(maxWidth: 100),
//             border: const OutlineInputBorder(
//               // borderSide: BorderSide(width: 2.0),
//               borderRadius: BorderRadius.all(Radius.circular(10)),
//             ),
//             // contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
//           ),
//           keyboardType: TextInputType.number,
//           validator: (value) {
//             if (value?.isEmpty ?? true) {
//               return 'Please enter the lime weight';
//             }
//             return null;
//           },
//           onChanged: (value) {
//             onLevelChanged(double.tryParse(value) ?? 0);
//           },
//         ),
//       ],
//     );
//   }
// }