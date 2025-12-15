import 'package:doctor_app/core/utils/log_helper.dart';
import 'package:flutter/material.dart';

import 'app/my_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LogHelper.info("App started");
  runApp(const MyApp());
}
