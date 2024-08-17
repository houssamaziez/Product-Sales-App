import 'package:flutter/material.dart';

import '../../../View/Screens/Home/SubScreens/OrderView/screen_order_local.dart';
import '../../../View/Screens/Home/SubScreens/OrderView/screen_order_net.dart';
import '../../../View/Screens/Home/SubScreens/CartView/screen_cart.dart';
import '../../../View/Screens/Home/SubScreens/ProductView/screen_all_product.dart';

List<Widget> suplistscreenHome = [
  OrderListScreen(),
  OrderListScreenLocal(),
  OrderListScreenLocal(),
  CartScreen(),
  const ProductsScreen(),
];
