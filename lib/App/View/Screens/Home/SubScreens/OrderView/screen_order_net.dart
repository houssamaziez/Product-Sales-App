import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_sales_app/App/Util/Style/stylecontainer.dart';
import 'package:product_sales_app/App/View/Widgets/flutter_spinkit.dart';
import '../../../../../Controller/Order/order_controller.dart';
import '../../../../../Util/Date/formatDate.dart';

class OrderListScreen extends StatefulWidget {
  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  final OrderController orderController = Get.put(OrderController());
  @override
  void initState() {
    orderController.fetchOrders(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
            'Total:  ${orderController.totalAllOrdersPrice.value.toStringAsFixed(2)} DA')),
      ),
      body: Obx(() {
        if (orderController.isLoading.value == true) {
          return Center(
            child: spinkit,
          );
        }

        return ListView.builder(
          itemCount: orderController.orders.length,
          itemBuilder: (context, index) {
            final order = orderController.orders[index];
            final double totalPrice = order.productSells.fold(
              0.0,
              (sum, item) => sum + (item.price * item.quantity),
            );

            return Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, top: 10),
              child: Container(
                decoration: StyleContainer.style1,
                child: ExpansionTile(
                  leading: Image.asset(
                    'assets/icons/checkout.png',
                    height: 24,
                  ),
                  title: Row(
                    children: [
                      Text(
                        'Order ID: ${order.orderId}',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w700),
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
                    'Total Order Price:  ${totalPrice.toStringAsFixed(2)}DA',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: order.productSells.length,
                      itemBuilder: (context, productIndex) {
                        final product = order.productSells[productIndex];
                        return ListTile(
                          title: Text(
                            (productIndex + 1).toString() + '- ' + product.name,
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Description: ${product.description}'),
                              Text(
                                  'Price:   ${product.price.toStringAsFixed(2)} DA'),
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
        );
      }),
    );
  }
}
