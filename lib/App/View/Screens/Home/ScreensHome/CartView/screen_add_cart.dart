import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_sales_app/App/Util/Style/stylecontainer.dart';

import '../../../../../Controller/Order/order_controller.dart';
import '../../../../../Model/Local/product_data.dart';
import '../../../../../Util/Route/Go.dart';

class ScreenAddProductCart extends StatefulWidget {
  const ScreenAddProductCart({super.key, required this.strin});
  final String strin;

  @override
  State<ScreenAddProductCart> createState() => _ScreenAddProductCartState();
}

class _ScreenAddProductCartState extends State<ScreenAddProductCart> {
  late ProductData _productData;
  late TextEditingController _quantityController;

  @override
  void initState() {
    super.initState();
    _productData = _convertStringToProductData(widget.strin);
    _quantityController =
        TextEditingController(text: _productData.quantity.toString());
  }

  ProductData _convertStringToProductData(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    return ProductData.fromJson(json);
  }

  void _updateQuantity(int change) {
    setState(() {
      int newQuantity = int.parse(_quantityController.text) + change;
      if (newQuantity < 0) newQuantity = 0;
      _quantityController.text = newQuantity.toString();
      _productData = _productData.copyWith(quantity: newQuantity);
    });
  }

  void _addToCart() {
    final OrderController _controller = Get.put(OrderController());
    _controller.addProduct(
      _productData.copyWith(
        userId: 1, // Replace with actual user ID
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );
    Go.back(context);
  }

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Spacer(),
            Container(
              decoration: StyleContainer.style1,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _productData.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _productData.description,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Price: \$${_productData.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(Icons.person, color: Colors.grey[600]),
                        const SizedBox(width: 8),
                        Text(
                          'User ID: ${_productData.userId}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: () => _updateQuantity(-1),
                        ),
                        Expanded(
                          child: TextField(
                            controller: _quantityController,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 10),
                            ),
                            onChanged: (value) {
                              if (int.tryParse(value) == null) {
                                _quantityController.text = '0';
                              }
                            },
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline),
                          onPressed: () => _updateQuantity(1),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _addToCart,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Add to Cart',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
