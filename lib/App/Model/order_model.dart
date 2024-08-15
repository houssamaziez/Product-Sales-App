import 'package:hive/hive.dart';
import 'product_model.dart';

part 'order_model.g.dart';

@HiveType(typeId: 1)
class Order extends HiveObject {
  @HiveField(0)
  final List<Product> products;

  @HiveField(1)
  final DateTime orderDate;

  Order({
    required this.products,
    required this.orderDate,
  });
}
