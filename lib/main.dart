import 'package:calculator/app/app.dart';
import 'package:flutter/material.dart';

import 'core/utils/hydrated_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HydratedStorage.init();
  runApp(const CalculatorApp());
}