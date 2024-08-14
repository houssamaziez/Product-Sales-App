import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Util/Theme/theme_light.dart';
import 'View/Screens/Home/screen_all_product.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: themeLight,
      home: ProductsScreen(),
    );
  }
}
