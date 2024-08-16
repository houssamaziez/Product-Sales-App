import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../../Model/Local/order.dart';
import '../../../../../Controller/Order/order_controller.dart';
import 'package:get/get.dart';

import '../../../../../Util/Date/formatDate.dart';
import '../../../../../Util/Style/stylecontainer.dart';

class OrderListScreenLocal extends StatefulWidget {
  @override
  _OrderListScreenLocalState createState() => _OrderListScreenLocalState();
}

class _OrderListScreenLocalState extends State<OrderListScreenLocal> {
  late Box<Order> _ordersBox;
  final OrderController _orderController = Get.put(OrderController());

  @override
  void initState() {
    super.initState();
    _ordersBox = Hive.box<Order>('ordersBox');
    _orderController.calculateTotalPrice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton.icon(
        onPressed: () {
          _orderController.sendOrdersToServer(context);
        },
        icon: Icon(
          Icons.cloud_upload,
          size: 18,
        ),
        label: Text(
          'Send All Orders',
          style: TextStyle(fontSize: 12),
        ),
      ),
      appBar: AppBar(
        title: Text('Order Pending'),
      ),
      body: ValueListenableBuilder(
        valueListenable: _ordersBox.listenable(),
        builder: (context, Box<Order> box, _) {
          if (box.values.isEmpty) {
            return Center(
              child: Text('No orders available'),
            );
          }

          return Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: box.length,
                      itemBuilder: (context, index) {
                        final order = box.getAt(index);
                        final double totalPrice = order?.products.fold(
                              0.0,
                              (sum, item) =>
                                  sum! + (item.price * item.quantity),
                            ) ??
                            0.0;

                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8, top: 10),
                          child: Container(
                            decoration: StyleContainer.style1,
                            child: ExpansionTile(
                              leading: Image.asset(
                                'assets/icons/waiting-box.png',
                                height: 24,
                              ),
                              title: Row(
                                children: [
                                  Text(
                                    'Order ID: ${order!.orderId}',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                              iconColor: Theme.of(context).primaryColor,
                              trailing: Column(
                                children: [
                                  Spacer(),
                                  Text(
                                    ' ${formatDate(order.orderDate.toString())}',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Icon(
                                    Icons.arrow_drop_down,
                                  ),
                                  Spacer(),
                                ],
                              ),
                              subtitle: Text(
                                'Total Order Price:  ${totalPrice.toStringAsFixed(2)} DA ',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: order.products.length,
                                  itemBuilder: (context, productIndex) {
                                    final product =
                                        order.products[productIndex];
                                    return ListTile(
                                      title: Text(
                                        (productIndex + 1).toString() +
                                            '- ' +
                                            product.name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              'Description: ${product.description}'),
                                          Text(
                                              'Price:  ${product.price.toStringAsFixed(2)} DA'),
                                          Text('Quantity: ${product.quantity}'),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              GetBuilder<OrderController>(
                  init: OrderController(),
                  builder: (cont) {
                    return _orderController.isLoadingsend == true
                        ? Center(
                            child: Image.asset(
                              "assets/icons/upload-unscreen.gif",
                              height: 100,
                            ),
                          )
                        : Container();
                  })
            ],
          );
        },
      ),
    );
  }
}
