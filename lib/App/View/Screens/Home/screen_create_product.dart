import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_sales_app/App/View/Widgets/flutter_spinkit.dart';

import '../../../Controller/home_controller.dart';
import '../../../Model/product_model.dart';

class AddProductScreen extends StatefulWidget {
  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final ProductController productController = Get.put(ProductController());
  @override
  void initState() {
    productController.fetchProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GetBuilder<ProductController>(
          init: ProductController(),
          builder: (controller) {
            return controller.isLoadingadd
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
          }),
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: GetBuilder<ProductController>(
          init: ProductController(),
          builder: (_controller) {
            return _controller.isLoading == true
                ? Center(child: spinkit)
                : ListView.builder(
                    itemCount: _controller.listProduct.length,
                    itemBuilder: (coontext, index) {
                      return Card(
                        child: ListTile(
                          title: Text(
                            _controller.listProduct[index].name!,
                          ),
                        ),
                      );
                    });
          }),
    );
  }
}
