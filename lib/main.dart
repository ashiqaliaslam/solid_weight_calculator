import 'package:flutter/material.dart';
import 'package:solid_weight_calculator/src/app.dart';
import 'package:solid_weight_calculator/src/settings/settings_controller.dart';
import 'package:solid_weight_calculator/src/settings/settings_service.dart';

void main() async {
  final settingsController = SettingsController(SettingsService());

  await settingsController.loadSettings();

  runApp(MyApp(settingsController: settingsController));
}
