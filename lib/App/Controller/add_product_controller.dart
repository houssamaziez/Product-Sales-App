import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:product_sales_app/App/Controller/product_controller.dart';

import '../Model/product_model.dart';

class ScreenAddProductController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  void submitProduct(context) {
    final ProductController productController = Get.put(ProductController());

    if (nameController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        priceController.text.isNotEmpty &&
        quantityController.text.isNotEmpty) {
      productController.addProduct(
        context,
        name: nameController.text,
        description: descriptionController.text,
        quantity: int.parse(quantityController.text),
        price: double.parse(priceController.text),
        userId: 2,
      );
    } else {
      Get.snackbar('Error', 'Please fill out all fields');
    }
  }

  void clearForm() {
    nameController.clear();
    descriptionController.clear();
    priceController.clear();
    quantityController.clear();
  }

  @override
  void onClose() {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
    super.onClose();
  }
}
