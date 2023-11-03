import 'package:flutter/material.dart';

import 'package:users/app.dart';
import 'package:users/di.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  DI.init();

  runApp(const MyApp());
}
