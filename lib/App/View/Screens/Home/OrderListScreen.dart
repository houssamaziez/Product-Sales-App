import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../Model/order.dart';

class OrderListScreen extends StatefulWidget {
  @override
  _OrderListScreenState createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  late Box<Order> _ordersBox;
  double totalAllOrdersPrice = 0.0;

  @override
  void initState() {
    super.initState();
    _ordersBox = Hive.box<Order>('ordersBox');
    _calculateTotalPrice();
  }

  void _calculateTotalPrice() {
    double total = 0.0;

    for (int i = 0; i < _ordersBox.length; i++) {
      final order = _ordersBox.getAt(i);
      total += order?.products.fold(
            0.0,
            (sum, item) => sum! + (item.price * item.quantity),
          ) ??
          0.0;
    }

    setState(() {
      totalAllOrdersPrice = total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Total: \$${totalAllOrdersPrice.toStringAsFixed(2)}'),
      ),
      body: ValueListenableBuilder(
        valueListenable: _ordersBox.listenable(),
        builder: (context, Box<Order> box, _) {
          if (box.values.isEmpty) {
            return Center(
              child: Text('No orders available'),
            );
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final order = box.getAt(index);
              final double totalPrice = order?.products.fold(
                    0.0,
                    (sum, item) => sum! + (item.price * item.quantity),
                  ) ??
                  0.0;

              return ExpansionTile(
                title: Text('Order ID: ${order?.orderId}'),
                subtitle: Text('Order Date: ${order?.orderDate.toString()}'),
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: order?.products.length,
                    itemBuilder: (context, productIndex) {
                      final product = order?.products[productIndex];
                      return ListTile(
                        title: Text(product?.name ?? ''),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Description: ${product?.description ?? ''}'),
                            Text(
                                'Price: \$${product?.price.toStringAsFixed(2)}'),
                            Text('Quantity: ${product?.quantity}'),
                          ],
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Total Order Price: \$${totalPrice.toStringAsFixed(2)}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
