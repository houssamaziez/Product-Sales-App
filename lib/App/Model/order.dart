import 'package:hive/hive.dart';
import 'product_data.dart';

part 'order.g.dart';

@HiveType(typeId: 2)
class Order {
  @HiveField(0)
  final int orderId;

  @HiveField(1)
  final List<ProductData> products;

  @HiveField(2)
  final DateTime orderDate;

  Order({
    required this.orderId,
    required this.products,
    required this.orderDate,
  });
}
