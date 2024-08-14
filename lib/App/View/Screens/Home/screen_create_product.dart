import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_sales_app/App/View/Widgets/flutter_spinkit.dart';

import '../../../Controller/product_controller.dart';

class AddProductScreen extends StatefulWidget {
  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final ProductController productController = Get.put(ProductController());
  @override
  void initState() {
    productController.fetchProduct(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GetBuilder<ProductController>(
          init: ProductController(),
          builder: (controller) {
            return controller.isLoadingadd
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      productController.addProduct(
                        context,
                        name: "nameTest",
                        description: "description",
                        quantity: 2,
                        price: 3.0,
                        userId: 2,
                      );
                    },
                    child: const Text('Add Product'),
                  );
          }),
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: GetBuilder<ProductController>(
          init: ProductController(),
          builder: (_controller) {
            return _controller.isLoading == true
                ? const Center(child: spinkit)
                : ListView.builder(
                    itemCount: _controller.listProduct.length,
                    itemBuilder: (coontext, index) {
                      return Card(
                        child: ListTile(
                          title: Text(
                            _controller.listProduct[index].name,
                          ),
                        ),
                      );
                    });
          }),
    );
  }
}
