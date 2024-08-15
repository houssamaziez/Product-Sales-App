import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_sales_app/App/Util/Go.dart';
import 'package:product_sales_app/App/Util/Style/stylecontainer.dart';
import 'package:product_sales_app/App/View/Screens/Home/screen_add_product.dart';
import 'package:product_sales_app/App/View/Screens/Home/screen_Edite_product.dart';
import 'package:product_sales_app/App/View/Widgets/flutter_spinkit.dart';

import '../../../Controller/product_controller.dart';
import '../../../Model/product_mod.dart';
import '../../../Util/Date/formatDate.dart';
import '../../Widgets/Dialog/delete.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
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
                      Go.to(context, AddProductScreen());
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
                      ProductData data = _controller.listProduct[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: StyleContainer.style1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      data.name,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black),
                                    ),
                                    Spacer(),
                                    Text(
                                      formatDate(data.createdAt.toString()),
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                  ],
                                ),
                                Text(data.description),
                                Row(
                                  children: [
                                    Text(
                                      "Quantity:",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      data.quantity.toString(),
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Price:",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      data.price.toString() + " DA",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Go.to(context,
                                            EditeProductScreen(data: data));
                                      },
                                      child: Container(
                                        decoration:
                                            StyleContainer.stylecontainer(
                                                raduis: 8,
                                                color: Color(0Xff3BB432)),
                                        height: 27,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 8, top: 3),
                                          child: Text(
                                            "Edite",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    IconButton(
                                        onPressed: () {
                                          showDeleteDialog(
                                            coontext,
                                            () {
                                              productController.deleteProduct(
                                                  context,
                                                  id: data.id);
                                            },
                                          );
                                        },
                                        icon: Icon(
                                          Icons.delete_outline_rounded,
                                          color: Colors.red,
                                        ))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
          }),
    );
  }
}
