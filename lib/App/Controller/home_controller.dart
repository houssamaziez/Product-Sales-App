import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Model/product_model.dart';

class ProductController extends GetxController {
  // Reactive state
  var isLoading = false;
  var product = Rxn<Product>();

  Future<void> addProduct({
    required String name,
    required String description,
    required int quantity,
    required double price,
    required int userId,
  }) async {
    isLoading = true; // Set loading to true
    update();
    final url = Uri.parse('http://192.168.1.17:8000/api/products/add');
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

          Get.snackbar("Success",
              product.value?.message ?? "Product created successfully");
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
      isLoading = false; // Set loading to false
      update();
    }
  }
}
