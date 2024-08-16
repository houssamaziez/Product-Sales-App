// ignore_for_file: non_constant_identifier_names

import '../Util/Const/url.dart';

class Endpoint {
  static String apiproductsadd = "${ApiUrl.urlHost}/products/add";
  static String apiproductsedite = "${ApiUrl.urlHost}/products/update";
  static String apiproductsDelete = "${ApiUrl.urlHost}/products/delete";

  static String apiproductsgetAll = "${ApiUrl.urlHost}/products/all";
// Order
  static String apiOrderadd = "${ApiUrl.urlHost}/orders/add";
  static String apiOrdergetAll = "${ApiUrl.urlHost}/orders";
}
