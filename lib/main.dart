import 'package:flutter/material.dart';
import 'package:senfin/injection.dart';
import 'package:senfin/presentation/core/appwidgets.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection();

  runApp(AppWidget());
}
