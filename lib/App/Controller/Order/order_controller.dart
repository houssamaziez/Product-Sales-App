import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../Model/Remote/orderR.dart';
import '../../Model/Local/order.dart';
import '../../Model/Local/product_data.dart';
import 'package:product_sales_app/App/RouteEndPoint/EndPoint.dart';

import '../../View/Widgets/Messages/snack_bar.dart';

class OrderController extends GetxController {
  var orders = <OrderRemote>[].obs;
  var totalAllOrdersPrice = 0.0.obs;
  var isLoading = false.obs;
  bool isLoadingsend = false;
  int lengthLocal = 0;
  int lengthprodcts = 0;
  final _products = <ProductData>[].obs;
  final orderIdController = TextEditingController();

  List<ProductData> get products => _products;

  @override
  void onInit() {
    super.onInit();
    lengthLocal = Hive.box<Order>('ordersBox').length;
    update();
    lengthprodcts = _products.length;
    update();
  }

  Future<void> fetchOrders(context) async {
    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse(Endpoint.apiOrdergetAll));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<OrderRemote> fetchedOrders = (data['data'] as List)
            .map((orderData) => OrderRemote.fromJson(orderData))
            .toList();

        orders.assignAll(fetchedOrders);
        calculateTotalPrice();
      } else {
        handleError(context,
            'Failed to load orders. Status code: ${response.statusCode}');
      }
    } catch (e) {
      handleError(context, 'An error occurred while fetching orders: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void calculateTotalPrice() {
    totalAllOrdersPrice.value = orders.fold(
      0.0,
      (sum, order) =>
          sum +
          order.productSells.fold(
            0.0,
            (sum, item) => sum + (item.price * item.quantity),
          ),
    );
  }

  void addProduct(ProductData product) {
    _products.add(product);
    lengthprodcts = _products.length;
    update();
  }

  void removeProductindex(int index) {
    _products.removeAt(index);
    lengthprodcts = _products.length;
    update();
  }

  void removeProduct(index) {
    _products.remove(index);
    lengthprodcts = _products.length;
    update();
  }

  void clearProducts() {
    _products.clear();
    lengthprodcts = _products.length;
    update();
  }

  saveOrder(context) async {
    if (_products.isNotEmpty) {
      try {
        var ordersBox = Hive.box<Order>('ordersBox');
        Order newOrder = Order(
          orderId: int.tryParse(orderIdController.text) ?? 0,
          products: List.from(_products),
          orderDate: DateTime.now(),
        );

        await ordersBox.add(newOrder);
        lengthLocal = ordersBox.length;
        update();
        clearProducts();
      } catch (e) {
        handleError(context, 'Failed to save order: $e');
      }
    } else {
      Get.snackbar('Error', 'Please add at least one product');
    }
  }

  sendOrdersToServer(context) async {
    try {
      isLoadingsend = true;
      update();
      final ordersBox = Hive.box<Order>('ordersBox');
      final List<Order> orders = ordersBox.values.toList();
      final List<int> successfullySentOrders = [];

      for (int i = 0; i < orders.length; i++) {
        final orderData = _prepareOrderData(orders[i]);

        final response = await _sendOrderToServer(orderData);

        if (response.statusCode == 200) {
          successfullySentOrders.add(i);
        } else {
          _handleError(context, 'Failed to send order: ${response.body}');
        }
      }

      _removeSentOrders(successfullySentOrders, ordersBox);
    } catch (e) {
      _handleError(context, 'An unexpected error occurred: $e');
    } finally {
      isLoadingsend = false;
      update();
    }
  }

  Map<String, dynamic> _prepareOrderData(Order order) {
    return {
      'user_id': 1, // Replace with actual user ID
      'order_id': order.orderId,
      'order_date': order.orderDate.toIso8601String(),
      'products_sells': order.products.map((product) {
        return {
          'product_id': 2, // Make sure this matches your model
          'name': product.name,
          'description': product.description,
          'price': product.price,
          'quantity': product.quantity,
        };
      }).toList(),
    };
  }

  Future<http.Response> _sendOrderToServer(
      Map<String, dynamic> orderData) async {
    return await http.post(
      Uri.parse(Endpoint.apiOrderadd),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(orderData),
    );
  }

  void _removeSentOrders(List<int> indices, Box<Order> ordersBox) {
    for (int i = indices.length - 1; i >= 0; i--) {
      ordersBox.deleteAt(indices[i]);
    }
    lengthLocal = ordersBox.length;
    update();
  }

  void _handleError(context, String message) {
    // Log the error or show a message to the user
    showMessage(context, title: "An error occurred");
  }

  void handleError(context, String message) {
    showMessage(context, title: "Check internet connection");
  }
}
