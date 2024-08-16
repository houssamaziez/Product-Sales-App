import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_sales_app/App/Util/Route/Go.dart';

import 'App/Model/Local/order.dart';
import 'App/Model/Local/product_data.dart';
import 'App/Service/ConnectivityService.dart';
// import 'App/myapp.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'App/View/Screens/Home/home.dart';
import 'App/myapp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register adapters
  await Hive.initFlutter();
  Hive.registerAdapter(ProductDataAdapter());
  Hive.registerAdapter(OrderAdapter());
  await Hive.openBox<Order>('ordersBox');
  Get.put(ConnectivityController());
  runApp(MyApp());
}
