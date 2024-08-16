import 'package:flutter/material.dart';

import '../../../View/Screens/Home/ScreensHome/OrderView/screen_order_local.dart';
import '../../../View/Screens/Home/ScreensHome/OrderView/screen_order_net.dart';
import '../../../View/Screens/Home/ScreensHome/CartView/screen_cart.dart';
import '../../../View/Screens/Home/ScreensHome/ProductView/screen_all_product.dart';

List<Widget> listscreenHome = [
  OrderListScreen(),
  OrderListScreenLocal(),
  OrderListScreenLocal(),
  CartScreen(),
  const ProductsScreen(),
];
