import 'package:flutter/material.dart';
import 'package:glowy/app/app.dart';
import 'package:glowy/app/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(MyApp());
}
