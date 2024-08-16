// product_sell.dart
class ProductSell {
  final int id;
  final String productId;
  final String name;
  final String description;
  final double price;
  final int quantity;

  ProductSell({
    required this.id,
    required this.productId,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
  });

  factory ProductSell.fromJson(Map<String, dynamic> json) {
    return ProductSell(
      id: json['id'],
      productId: json['product_id'],
      name: json['name'],
      description: json['description'],
      price: double.parse(json['price']),
      quantity: int.parse(json['quantity']),
    );
  }
}
