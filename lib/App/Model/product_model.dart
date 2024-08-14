class Product {
  final String message;
  final ProductData data;
  final String state;

  Product({
    required this.message,
    required this.data,
    required this.state,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      message: json['message'] as String,
      data: ProductData.fromJson(json['data'] as Map<String, dynamic>),
      state: json['state'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data.toJson(),
      'state': state,
    };
  }
}

class ProductData {
  final int id;
  final String name;
  final String description;
  final double price;
  final int quantity;
  final int userId;

  ProductData({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.userId,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      price: double.parse(json['price'] as String),
      quantity: int.parse(json['quantity'] as String),
      userId: int.parse(json['user_id'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price.toString(),
      'quantity': quantity.toString(),
      'user_id': userId.toString(),
    };
  }
}
