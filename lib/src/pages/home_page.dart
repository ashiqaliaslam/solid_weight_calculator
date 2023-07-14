import 'package:flutter/material.dart';
import 'package:solid_weight_calculator/src/pages/form_fields.dart';
import 'package:solid_weight_calculator/src/pages/widgets.dart';

import '../models/lime_data.dart';
import '../settings/settings_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const routeName = '/';

  @override
  State<HomePage> createState() => _LimeDataFormState();
}

class _LimeDataFormState extends State<HomePage> {
  List<LimeData> limeDataList = [];
  double totalWeight = 0;
  Duration totalDuration = const Duration();
  // final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now().toUtc();
    var timeStartToday = TimeOfDay.fromDateTime(
      DateTime(now.year, now.month, now.day, 0, 0),
    );

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Lime Data'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          centerTitle: true,
          elevation: 5,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.restorablePushNamed(
                      context, SettingsView.routeName);
                },
                icon: const Icon(
                  Icons.settings,
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(5.0),
          // child: Form(
          //   key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  LimeConsumed(totalWeight: totalWeight),
                  if (totalDuration.inMinutes > 1440)
                    DurationMoreThan24Hours(totalDuration: totalDuration),
                  if (totalDuration.inMinutes <= 1440)
                    LimeConsumptionDuration(totalDuration: totalDuration)
                ],
              ),
              const Divider(),
              ProjectedLimeWeight(
                  totalWeight: totalWeight, totalDuration: totalDuration),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: limeDataList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Dismissible(
                      key: ValueKey(limeDataList[index]),
                      onDismissed: (DismissDirection direction) {
                        setState(() {
                          limeDataList.removeAt(index);
                          calculateTotals();
                        });
                      },
                      child: LimeDataField(
                        limeData: limeDataList[index],
                        onStartLevelChanged: (startLevel) {
                          setState(() {
                            limeDataList[index].startLevel = startLevel;
                            calculateTotals();
                          });
                        },
                        onEndLevelChanged: (endLevel) {
                          setState(() {
                            limeDataList[index].endLevel = endLevel;
                            calculateTotals();
                          });
                        },
                        onStartTimeChanged: (TimeOfDay startTime) {
                          setState(() {
                            limeDataList[index].startTime = startTime;
                            calculateTotals();
                          });
                        },
                        onEndTimeChanged: (TimeOfDay endTime) {
                          setState(() {
                            limeDataList[index].endTime = endTime;
                            calculateTotals();
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (limeDataList.isEmpty) {
                          limeDataList.add(
                            LimeData(
                              startLevel: 0,
                              endLevel: 0,
                              startTime: timeStartToday,
                              endTime: TimeOfDay.now(),
                            ),
                          );
                        } else {
                          limeDataList.add(
                            LimeData(
                                startLevel: 0,
                                endLevel: 0,
                                startTime: limeDataList.last.endTime,
                                endTime: TimeOfDay.now()),
                          );
                        }
                      });
                    },
                    child: const Text('Add Data'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        limeDataList.removeRange(0, limeDataList.length);
                        calculateTotals();
                      });
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.clear_all),
                        SizedBox(width: 10),
                        Text('Clear All'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          // ),
        ),
      ),
    );
  }

  void calculateTotals() {
    totalWeight = 0.0;
    totalDuration = const Duration();

    for (var limeData in limeDataList) {
      final limeConsumptionDuration =
          TimeToDuration.durationAsTime(limeData.startTime, limeData.endTime);
      totalDuration += limeConsumptionDuration;

      double startLevel = limeData.startLevel;
      double endLevel = limeData.endLevel;
      totalWeight += startLevel - endLevel;
    }
  }
}
