// ignore_for_file: non_constant_identifier_names

import '../Util/Const/url.dart';

class Endpoint {
  static String apiProductsadd = "${ApiUrl.urlHost}/products/add";
  static String apiProductsedite = "${ApiUrl.urlHost}/products/update";
  static String apiProductsDelete = "${ApiUrl.urlHost}/products/delete";

  static String apiProductsgetAll = "${ApiUrl.urlHost}/products/all";
// Order
  static String apiOrderadd = "${ApiUrl.urlHost}/orders/add";
  static String apiOrdergetAll = "${ApiUrl.urlHost}/orders";
}
