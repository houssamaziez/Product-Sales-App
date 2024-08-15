import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../Model/BasketItem.dart';
import '../../../Model/order.dart';
import '../../../Model/product_data.dart';

class BasketSaleScreen extends StatefulWidget {
  @override
  _BasketSaleScreenState createState() => _BasketSaleScreenState();
}

class _BasketSaleScreenState extends State<BasketSaleScreen> {
  final List<BasketItem> _basketItems = [];

  void _addToBasket(ProductData product) {
    setState(() {
      // تحقق مما إذا كان المنتج موجودًا بالفعل في السلة
      var existingItem = _basketItems.firstWhere(
          (item) => item.product.id == product.id,
          orElse: () => BasketItem(product: product));
      if (existingItem.product.id == product.id) {
        // إذا كان المنتج موجودًا، زيادة الكمية
        existingItem.quantity += 1;
      } else {
        // إذا لم يكن موجودًا، أضفه إلى السلة
        _basketItems.add(BasketItem(product: product));
      }
    });
  }

  void _checkout() async {
    if (_basketItems.isNotEmpty) {
      var ordersBox = Hive.box<Order>('ordersBox');

      // تحويل عناصر السلة إلى قائمة من المنتجات
      List<ProductData> products = _basketItems.map((item) {
        return ProductData(
          id: item.product.id,
          name: item.product.name,
          description: item.product.description,
          price: item.product.price,
          quantity: item.quantity,
          userId: item.product.userId,
          createdAt: item.product.createdAt,
          updatedAt: item.product.updatedAt,
        );
      }).toList();

      Order newOrder = Order(
        orderId: DateTime.now()
            .millisecondsSinceEpoch, // يمكن استبدالها بمعرف الطلب الصحيح
        products: products,
        orderDate: DateTime.now(),
      );

      await ordersBox.add(newOrder);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Order placed successfully!")),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Your basket is empty")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Basket Sale"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _basketItems.length,
              itemBuilder: (context, index) {
                final basketItem = _basketItems[index];
                return ListTile(
                  title: Text(basketItem.product.name),
                  subtitle: Text(
                      "${basketItem.quantity} x \$${basketItem.product.price.toStringAsFixed(2)}"),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_circle),
                    onPressed: () {
                      setState(() {
                        if (basketItem.quantity > 1) {
                          basketItem.quantity -= 1;
                        } else {
                          _basketItems.removeAt(index);
                        }
                      });
                    },
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: _checkout,
            child: Text("Checkout"),
          ),
        ],
      ),
    );
  }
}
