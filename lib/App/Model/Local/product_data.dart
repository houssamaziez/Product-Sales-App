import 'package:hive/hive.dart';

part 'Generated/product_data.g.dart';

class ProductRespons {
  final String message;
  final ProductData data;
  final String state;

  ProductRespons({
    required this.message,
    required this.data,
    required this.state,
  });

  factory ProductRespons.fromJson(Map<String, dynamic> json) {
    return ProductRespons(
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

@HiveType(typeId: 1)
class ProductData {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final double price;

  @HiveField(4)
  final int quantity;

  @HiveField(5)
  final int userId;

  @HiveField(6)
  final DateTime? createdAt;

  @HiveField(7)
  final DateTime? updatedAt;

  ProductData({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.userId,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      price: double.parse(json['price'] as String),
      quantity: int.parse(json['quantity'] as String),
      userId: int.parse(json['user_id'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
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
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  ProductData copyWith({
    int? id,
    String? name,
    String? description,
    double? price,
    int? quantity,
    int? userId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProductData(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
