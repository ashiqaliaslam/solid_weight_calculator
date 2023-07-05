import 'package:flutter/material.dart';
import 'package:solid_weight_calculator/src/sample_feature/widgets.dart';

import '../models/lime_data.dart';

class LimeDataField extends StatelessWidget {
  final LimeData limeData;
  final VoidCallback onDelete;
  final ValueChanged<double> onStartLevelChanged;
  final ValueChanged<double> onEndLevelChanged;
  final ValueChanged<TimeOfDay> onStartTimeChanged;
  final ValueChanged<TimeOfDay> onEndTimeChanged;
  // final VoidCallback onEdit;

  const LimeDataField({
    super.key,
    required this.limeData,
    required this.onDelete,
    required this.onStartLevelChanged,
    required this.onEndLevelChanged,
    required this.onStartTimeChanged,
    required this.onEndTimeChanged,
    // required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final limeConsumptionDuration =
        TimeToDuration.duration(limeData.startTime, limeData.endTime);

    final weight = limeData.startLevel - limeData.endLevel;

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Card(
        elevation: 5,
        color: Theme.of(context).colorScheme.tertiaryContainer,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 2),
          child: SizedBox(
            height: 120,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: LevelInputField(
                            onLevelChanged: onStartLevelChanged,
                            hintText: '50',
                            labelText: 'Start Level'),
                      ),
                      // const Divider(),
                      Flexible(
                        child: TimePickerButton(
                          labelText: 'Start Time',
                          time: limeData.startTime,
                          onTimeChanged: onStartTimeChanged,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: LevelInputField(
                            onLevelChanged: onEndLevelChanged,
                            hintText: '30',
                            labelText: 'End Level'),
                      ),
                      // const Divider(),
                      Flexible(
                        child: TimePickerButton(
                          labelText: 'End Time',
                          time: limeData.endTime,
                          onTimeChanged: onEndTimeChanged,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: CardCalculatedValues(
                          parameter: weight.toStringAsFixed(2),
                          label: 'Weight',
                        ),
                      ),
                      const Divider(),
                      Flexible(
                        child: CardCalculatedValues(
                          parameter: limeConsumptionDuration,
                          label: 'Duration',
                        ),
                      ),
                    ],
                  ),
                ),
                // Expanded(
                //   // height: 50,
                //   child: Column(
                //     children: [
                //       Expanded(
                //         child: LevelInputField(
                //           onLevelChanged: onStartLevelChanged,
                //           hintText: '100',
                //           labelText: 'Start Level',
                //         ),
                //       ),
                //       // const SizedBox(width: 10),
                //       Expanded(
                //         child: LevelInputField(
                //           onLevelChanged: onEndLevelChanged,
                //           hintText: '55',
                //           labelText: 'End Level',
                //         ),
                //       ),
                //       // const SizedBox(width: 10),
                //       // CardCalculatedValues(
                //       //     parameter: weight.toStringAsFixed(2), label: 'Weight'),
                //     ],
                //   ),
                // ),
                // const SizedBox(height: 10),
                // const Divider(),
                // Expanded(
                //   // height: 60,
                //   child: Column(
                //     children: [
                //       Expanded(
                //         child: TimePickerButton(
                //             labelText: 'Start Time',
                //             time: limeData.startTime,
                //             onTimeChanged: onStartTimeChanged),
                //       ),
                //       // const SizedBox(width: 10),
                //       Expanded(
                //           child: TimePickerButton(
                //         labelText: 'End Time',
                //         time: limeData.endTime,
                //         onTimeChanged: onEndTimeChanged,
                //       )),
                //       // const SizedBox(width: 10),
                //       // CardCalculatedValues(
                //       //     parameter: limeConsumptionDuration, label: 'Duration'),
                //       // Expanded(
                //       //   child: Column(),
                //       // ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
