import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'App/Service/ConnectivityService.dart';
import 'App/myapp.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(ConnectivityController());
  runApp(const MyApp());
}
