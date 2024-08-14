import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controller/home_controller.dart';

class AddProductScreen extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GetBuilder<ProductController>(
                init: ProductController(),
                builder: (controller) {
                  return controller.isLoading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () {
                            productController.addProduct(
                              name: "nameTest",
                              description: "description",
                              quantity: 2,
                              price: 3.0,
                              userId: 2,
                            );
                          },
                          child: Text('Add Product'),
                        );
                })
          ],
        ),
      ),
    );
  }
}
