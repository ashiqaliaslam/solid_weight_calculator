import 'package:flutter/material.dart';
import 'package:solid_weight_calculator/src/ui/widgets/card_calculated_values.dart';
import 'package:solid_weight_calculator/src/ui/widgets/level_input_field.dart';
import 'package:solid_weight_calculator/src/ui/widgets/time_to_duration.dart';

import '../../models/lime_data.dart';
import '../widgets/time_picker_button.dart';

class LimeDataCard extends StatelessWidget {
  final LimeData limeData;
  final ValueChanged<double> onStartLevelChanged;
  final ValueChanged<double> onEndLevelChanged;
  final ValueChanged<TimeOfDay> onStartTimeChanged;
  final ValueChanged<TimeOfDay> onEndTimeChanged;

  const LimeDataCard({
    super.key,
    required this.limeData,
    required this.onStartLevelChanged,
    required this.onEndLevelChanged,
    required this.onStartTimeChanged,
    required this.onEndTimeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final limeConsumptionDuration =
        TimeToDuration.durationAsString(limeData.startTime, limeData.endTime);

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
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: LevelInputTextField(
                              onLevelChanged: onStartLevelChanged,
                              hintText: '50',
                              labelText: 'Start Level'),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: LevelInputTextField(
                              onLevelChanged: onEndLevelChanged,
                              hintText: '30',
                              labelText: 'End Level'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 45,
                      child: CardCalculatedValues(
                        parameter: weight.toStringAsFixed(2),
                        label: 'Weight',
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TimePickerButton(
                            labelText: 'Start Time',
                            time: limeData.startTime,
                            onTimeChanged: onStartTimeChanged,
                          ),
                        ),
                        Expanded(
                          child: TimePickerButton(
                            labelText: 'End Time',
                            time: limeData.endTime,
                            onTimeChanged: onEndTimeChanged,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 45,
                      child: CardCalculatedValues(
                        parameter: limeConsumptionDuration,
                        label: 'Duration',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
