import 'package:hive/hive.dart';

part 'product_model.g.dart';

@HiveType(typeId: 0)
class Product extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final double price;

  @HiveField(3)
  final int quantity;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
  });
}
