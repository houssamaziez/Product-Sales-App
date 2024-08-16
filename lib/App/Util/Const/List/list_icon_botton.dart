import 'package:awesome_bottom_bar/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controller/Order/order_controller.dart';

List<TabItem> items = [
  const TabItem(
    icon: Icons.receipt,
    title: 'Order',
  ),
  TabItem(
    count: GetBuilder<OrderController>(
        init: OrderController(),
        builder: (controller) {
          return controller.lengthLocal == 0
              ? Container()
              : CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.red,
                  child: Center(
                      child: Text(
                    controller.lengthLocal.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  )));
        }),
    icon: Icons.cloud_upload,
    title: 'Pending',
  ),
  const TabItem(
    icon: Icons.qr_code,
    title: 'Wishlist',
  ),
  TabItem(
    count: GetBuilder<OrderController>(
        init: OrderController(),
        builder: (controller) {
          return controller.products.length == 0
              ? Container()
              : CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.red,
                  child: Center(
                      child: Text(
                    controller.products.length.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  )));
        }),
    icon: Icons.shopping_cart_outlined,
    title: 'Cart',
  ),
  const TabItem(
    icon: Icons.store,
    title: 'Products',
  ),
];
