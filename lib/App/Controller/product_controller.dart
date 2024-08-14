import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:product_sales_app/App/Util/Go.dart';
import 'package:product_sales_app/App/View/Widgets/Messages/snack_bar.dart';
import 'dart:convert';
import '../Model/product_model.dart';
import '../RouteEndPoint/EndPoint.dart';

class ProductController extends GetxController {
  // Reactive state
  var isLoadingadd = false;
  var isLoading = false;
  var product = Rxn<Product>();
  List<ProductData> listProduct = [];
// http://192.168.1.17:8000/api/products/update/5?name=edzefe&description=dze&price=11&quantity
  Future<void> addProduct(
    context, {
    required String name,
    required String description,
    required int quantity,
    required double price,
    required int userId,
  }) async {
    isLoadingadd = true; // Set loading to true
    update();
    final url = Uri.parse(Endpoint.apiproductsadd);
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final Map<String, dynamic> body = {
      'name': name,
      'description': description,
      'quantity': quantity.toString(),
      'price': price.toString(),
      'user_id': userId.toString(),
    };

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        product.value = Product.fromJson(responseData);
        if (product.value?.state.toString() == '105') {
          print(product.value!.state);
          fetchProduct(context);
          Go.back(context);
          Get.snackbar("Success",
              product.value?.message ?? "Product created successfully");
        } else {
          Get.snackbar("Error", product.value?.message ?? "An error occurred",
              backgroundColor: Colors.green[200]);
        }
      } else if (response.statusCode == 422) {
        final Map<String, dynamic> errorData = json.decode(response.body);
        if (errorData.containsKey('errors')) {
          String errorMessages = "";
          errorData['errors'].forEach((key, value) {
            errorMessages += "${value.join(", ")}\n";
          });
          Get.snackbar("Validation Error", errorMessages.trim());
        } else {
          Get.snackbar(
            "Error",
            "Failed to create product: ${response.reasonPhrase}",
          );
        }
      } else {
        Get.snackbar(
          "Error",
          "Failed to create product: ${response.reasonPhrase}",
        );
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      isLoadingadd = false; // Set loading to false
      update();
    }
  }

  Future<void> editeProduct(
    context, {
    required String name,
    required String description,
    required int quantity,
    required double price,
    required int id,
  }) async {
    isLoadingadd = true; // Set loading to true
    update();
    final url = Uri.parse(Endpoint.apiproductsedite +
        '/$id?name=$name&description=$description&price=$price&quantity=$quantity');
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    try {
      final response = await http.put(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        product.value = Product.fromJson(responseData);
        if (product.value?.state.toString() == '105') {
          print(product.value!.state);
          fetchProduct(context);
          Get.snackbar("Success",
              product.value?.message ?? "Product created successfully",
              backgroundColor: Colors.green[200]);
          Go.back(context);
        } else {
          Get.snackbar("Error", product.value?.message ?? "An error occurred");
        }
      } else if (response.statusCode == 422) {
        final Map<String, dynamic> errorData = json.decode(response.body);
        if (errorData.containsKey('errors')) {
          String errorMessages = "";
          errorData['errors'].forEach((key, value) {
            errorMessages += "${value.join(", ")}\n";
          });
          Get.snackbar("Validation Error", errorMessages.trim());
        } else {
          Get.snackbar(
            "Error",
            "Failed to create product: ${response.reasonPhrase}",
          );
        }
      } else {
        Get.snackbar(
          "Error",
          "Failed to create product: ${response.reasonPhrase}",
        );
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      isLoadingadd = false; // Set loading to false
      update();
    }
  }

  Future<void> fetchProduct(context) async {
    try {
      isLoading = true;
      update();
      final response = await http.get(
        Uri.parse(Endpoint.apiproductsgetAll),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> _productList = data['data'];
        print(_productList);
        listProduct =
            _productList.map((item) => ProductData.fromJson(item)).toList();
        print(listProduct.first.name);

        update();
      } else {
        print('Failed to load products: ${response.statusCode}');
        showMessage(context, title: "حدث خطأ");
      }
    } catch (e) {
      print(e);
      showMessage(context, title: "حدث خطأ");
    } finally {
      isLoading = false;
      update();
    }
  }
}
