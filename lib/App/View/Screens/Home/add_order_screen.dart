import 'package:flutter/material.dart';

import '../../../Controller/order_controller.dart';
import '../../../Model/order_model.dart';
import '../../../Model/product_model.dart';

class AddOrderScreen extends StatefulWidget {
  @override
  _AddOrderScreenState createState() => _AddOrderScreenState();
}

class _AddOrderScreenState extends State<AddOrderScreen> {
  final OrderController _orderController = OrderController();
  final List<Product> _orderProducts = [];

  void _addProduct() {
    final Product newProduct = Product(
      name: 'Sample Product',
      description: 'Sample Description',
      price: 100.0,
      quantity: 1,
    );
    setState(() {
      _orderProducts.add(newProduct);
    });
  }

  void _saveOrder() {
    Order newOrder = Order(
      products: [
        Product(
          name: 'Sample dezProduct',
          description: 'Samplzede Description',
          price: 100.0,
          quantity: 1,
        ),
        Product(
          name: 'Sample Prodzeduct',
          description: 'Samzedple Description',
          price: 100.0,
          quantity: 1,
        ),
        Product(
          name: 'Sample Prozedduct',
          description: 'Sampzedle Description',
          price: 100.0,
          quantity: 1,
        )
      ],
      orderDate: DateTime.now(),
    );
    _orderController.addOrder(newOrder);
    setState(() {
      _orderProducts.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Order'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _addProduct,
            child: Text('Add Sample Product'),
          ),
          ElevatedButton(
            onPressed: _saveOrder,
            child: Text('Save Order'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _orderController.getOrders().length,
              itemBuilder: (context, index) {
                final order = _orderController.getOrders()[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ExpansionTile(
                    title: Text('Order Date: ${order.orderDate}'),
                    children: order.products.map((product) {
                      return ListTile(
                        title: Text(product.name),
                        subtitle: Text('${product.price} USD'),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
