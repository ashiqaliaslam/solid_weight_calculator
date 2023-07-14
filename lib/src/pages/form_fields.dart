import 'package:flutter/material.dart';
import 'package:solid_weight_calculator/src/sample_feature/widgets.dart';

import '../models/lime_data.dart';

class LimeDataField extends StatelessWidget {
  final LimeData limeData;
  // final VoidCallback onDelete;
  final ValueChanged<double> onStartLevelChanged;
  final ValueChanged<double> onEndLevelChanged;
  final ValueChanged<TimeOfDay> onStartTimeChanged;
  final ValueChanged<TimeOfDay> onEndTimeChanged;
  // final VoidCallback onEdit;

  const LimeDataField({
    super.key,
    required this.limeData,
    // required this.onDelete,
    required this.onStartLevelChanged,
    required this.onEndLevelChanged,
    required this.onStartTimeChanged,
    required this.onEndTimeChanged,
    // required this.onEdit,
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
          child: NewCard(
            onStartLevelChanged: onStartLevelChanged,
            onEndLevelChanged: onEndLevelChanged,
            onStartTimeChanged: onStartTimeChanged,
            onEndTimeChanged: onEndTimeChanged,
            limeData: limeData,
            weight: weight,
            limeConsumptionDuration: limeConsumptionDuration,
          ),
        ),
      ),
    );
  }
}

class NewCard extends StatelessWidget {
  const NewCard({
    super.key,
    required this.onStartLevelChanged,
    required this.onEndLevelChanged,
    required this.onStartTimeChanged,
    required this.onEndTimeChanged,
    required this.limeData,
    required this.weight,
    required this.limeConsumptionDuration,
  });

  final ValueChanged<double> onStartLevelChanged;
  final ValueChanged<double> onEndLevelChanged;
  final ValueChanged<TimeOfDay> onStartTimeChanged;
  final ValueChanged<TimeOfDay> onEndTimeChanged;
  final LimeData limeData;
  final double weight;
  final String limeConsumptionDuration;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: LevelInputField(
                        onLevelChanged: onStartLevelChanged,
                        hintText: '50',
                        labelText: 'Start Level'),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: LevelInputField(
                        onLevelChanged: onEndLevelChanged,
                        hintText: '30',
                        labelText: 'End Level'),
                  ),
                ],
              ),
              // const Divider(),
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
              // const Divider(),
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
    );
  }
}
