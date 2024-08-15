import 'product_data.dart';

class BasketItem {
  final ProductData product;
  int quantity;

  BasketItem({required this.product, this.quantity = 1});
}
