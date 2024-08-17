import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_sales_app/App/Util/Style/stylecontainer.dart';
import '../../../../../Controller/Order/order_controller.dart';

// ignore: use_key_in_widget_constructors
class CartScreen extends StatelessWidget {
  final OrderController _controller = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Light background color
      appBar: AppBar(
        title: const Text("My Cart"),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () {
            return _controller.products.isEmpty
                ? _buildEmptyCart(context)
                : _buildCartList(context);
          },
        ),
      ),
      floatingActionButton: Obx(
        () => AnimatedOpacity(
          opacity: _controller.products.isNotEmpty ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 300),
          child: ElevatedButton(
            onPressed: () {
              _controller.saveOrder(context);
            },
            child: const Text("Save Order"),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            "Your cart is empty",
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Add products to get started",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartList(BuildContext context) {
    return ListView(
      children: [
        Container(
          decoration: StyleContainer.style1,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your Products",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const Divider(thickness: 1.5),
                ..._controller.products.map((product) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "${product.quantity} x \$${product.price.toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline),
                          color: Colors.redAccent,
                          onPressed: () {
                            _controller.removeProduct(product);
                          },
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
