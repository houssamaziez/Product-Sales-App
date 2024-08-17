import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Util/Theme/theme_light.dart';
import 'View/Screens/Home/home.dart';
import 'View/Screens/SplashScreen/screenStart.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: themeLight,
      home: const ScreenStart(),
    );
  }
}
