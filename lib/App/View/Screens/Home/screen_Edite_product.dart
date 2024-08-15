import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_sales_app/App/Controller/add_product_controller.dart';
import 'package:product_sales_app/App/View/Widgets/buttonall.dart';

import '../../../Controller/product_controller.dart';
import '../../../Model/product_mod.dart';

class EditeProductScreen extends StatefulWidget {
  EditeProductScreen({super.key, required this.data});
  final ProductData data;

  @override
  State<EditeProductScreen> createState() => _EditeProductScreenState();
}

class _EditeProductScreenState extends State<EditeProductScreen> {
  TextEditingController? nameController;
  TextEditingController? descriptionController;
  TextEditingController? priceController;
  TextEditingController? quantityController;

  void submitProduct(context) {
    final ProductController productController = Get.put(ProductController());

    if (nameController!.text.isNotEmpty &&
        descriptionController!.text.isNotEmpty &&
        priceController!.text.isNotEmpty &&
        quantityController!.text.isNotEmpty) {
      productController.editeProduct(
        context,
        name: nameController!.text,
        description: descriptionController!.text,
        quantity: int.parse(quantityController!.text),
        price: double.parse(priceController!.text),
        id: widget.data.id,
      );
    } else {
      Get.snackbar('Error', 'Please fill out all fields');
    }
  }

  void clearForm() {
    nameController!.clear();
    descriptionController!.clear();
    priceController!.clear();
    quantityController!.clear();
  }

  @override
  void initState() {
    descriptionController =
        TextEditingController(text: widget.data.description);
    nameController = TextEditingController(text: widget.data.name);
    priceController = TextEditingController(text: widget.data.price.toString());
    quantityController =
        TextEditingController(text: widget.data.quantity.toString());
    super.initState();
  }

  @override
  void dispose() {
    nameController!.dispose();
    descriptionController!.dispose();
    priceController!.dispose();
    quantityController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edite Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            children: [
              TextFormField(
                controller: nameController,
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
                controller: descriptionController,
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
                controller: priceController,
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
                controller: quantityController,
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
                          submitProduct(context);
                        },
                        title: 'Edite Product');
                  })
            ],
          ),
        ),
      ),
    );
  }
}
