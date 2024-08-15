// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hive/hive.dart';

// import 'App/Service/ConnectivityService.dart';
// import 'App/myapp.dart';
// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // Initialize Hive
//   await Hive.initFlutter();

//   // Register adapters

//   Get.put(ConnectivityController());
//   runApp(const MyApp());
// }
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'App/Model/order_model.dart';
import 'App/Model/product_model.dart';
import 'App/View/Screens/Home/add_order_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(OrderAdapter());
  await Hive.openBox<Product>('productsBox');
  await Hive.openBox<Order>('ordersBox');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Hive App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AddOrderScreen(),
    );
  }
}
