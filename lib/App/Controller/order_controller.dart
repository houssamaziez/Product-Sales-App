import 'package:hive/hive.dart';
import '../Model/order_model.dart';

class OrderController {
  final Box<Order> _orderBox = Hive.box<Order>('ordersBox');

  void init() {
    // Initialization code if needed
  }

  void addOrder(Order order) {
    _orderBox.add(order);
  }

  List<Order> getOrders() {
    return _orderBox.values.toList();
  }
}
