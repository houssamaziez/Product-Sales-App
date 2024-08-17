// order.dart

import 'product_sell.dart';

//cahange folder name to Remote
class OrderRemote {
  final int id;
  final String userId;
  final String orderId;
  final DateTime orderDate;
  final List<ProductSell> productSells;

  OrderRemote({
    required this.id,
    required this.userId,
    required this.orderId,
    required this.orderDate,
    required this.productSells,
  });

  factory OrderRemote.fromJson(Map<String, dynamic> json) {
    var productList = json['product_sells'] as List;
    List<ProductSell> products =
        productList.map((i) => ProductSell.fromJson(i)).toList();

    return OrderRemote(
      id: json['id'],
      userId: json['user_id'],
      orderId: json['order_id'],
      orderDate: DateTime.parse(json['order_date']),
      productSells: products,
    );
  }
}
