import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:product_sales_app/App/Util/Go.dart';
import 'package:product_sales_app/App/View/Screens/Home/BasketSaleScreen.dart';
import '../../../Model/order.dart';
import '../../../Model/product_data.dart';
import 'OrderListScreen.dart';

class AddOrderScreen extends StatefulWidget {
  @override
  _AddOrderScreenState createState() => _AddOrderScreenState();
}

class _AddOrderScreenState extends State<AddOrderScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for the order form
  final TextEditingController _orderIdController = TextEditingController();
  final List<ProductData> _products = [];

  // Controllers for the product form
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productDescriptionController =
      TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _productQuantityController =
      TextEditingController();

  void _addProduct() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _products.add(
          ProductData(
            id: _products.length + 1, // Auto-increment ID
            name: _productNameController.text,
            description: _productDescriptionController.text,
            price: double.parse(_productPriceController.text),
            quantity: int.parse(_productQuantityController.text),
            userId: 1, // Assuming a fixed userId for simplicity
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        );

        // Clear product fields
        _productNameController.clear();
        _productDescriptionController.clear();
        _productPriceController.clear();
        _productQuantityController.clear();
      });
    }
  }

  void _saveOrder() async {
    if (_products.isNotEmpty) {
      var ordersBox = Hive.box<Order>('ordersBox');
      Order newOrder = Order(
        orderId: int.parse(_orderIdController.text),
        products: _products,
        orderDate: DateTime.now(),
      );
      await ordersBox.add(newOrder);
      print(ordersBox.values.length);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please add at least one product")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        Go.to(context, OrderListScreen());
      }),
      appBar: AppBar(
        title: Text("Add Order"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _orderIdController,
                decoration: InputDecoration(labelText: "Order ID"),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Order ID';
                  }
                  return null;
                },
              ),
              Divider(),
              Text("Add Products", style: TextStyle(fontSize: 18)),
              TextFormField(
                controller: _productNameController,
                decoration: InputDecoration(labelText: "Product Name"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Product Name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _productDescriptionController,
                decoration: InputDecoration(labelText: "Product Description"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Product Description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _productPriceController,
                decoration: InputDecoration(labelText: "Product Price"),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Product Price';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _productQuantityController,
                decoration: InputDecoration(labelText: "Product Quantity"),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Product Quantity';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _addProduct,
                child: Text("Add Product"),
              ),
              Divider(),
              if (_products.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Added Products", style: TextStyle(fontSize: 18)),
                    ..._products.map((product) {
                      return ListTile(
                        title: Text(product.name),
                        subtitle:
                            Text("${product.quantity} x \$${product.price}"),
                      );
                    }).toList(),
                  ],
                ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveOrder,
                child: Text("Save Order"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
