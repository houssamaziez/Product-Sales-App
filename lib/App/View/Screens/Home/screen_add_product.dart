import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_sales_app/App/Controller/add_product_controller.dart';
import 'package:product_sales_app/App/View/Widgets/buttonall.dart';

import '../../../Controller/product_controller.dart';

class AddProductScreen extends StatelessWidget {
  final ScreenAddProductController productController =
      Get.put(ScreenAddProductController());

  AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            children: [
              TextFormField(
                controller: productController.nameController,
                decoration: const InputDecoration(labelText: 'Product Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the product name';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                maxLines: 6,
                minLines: 3,
                controller: productController.descriptionController,
                decoration:
                    const InputDecoration(labelText: 'Product Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the product description';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: productController.priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the price';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: productController.quantityController,
                decoration: const InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the quantity';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              GetBuilder<ProductController>(
                  init: ProductController(),
                  builder: (_controller) {
                    return ButtonAll(
                        islogin: _controller.isLoadingadd,
                        function: () {
                          productController.submitProduct(context);
                        },
                        title: 'Add Product');
                  })
            ],
          ),
        ),
      ),
    );
  }
}
