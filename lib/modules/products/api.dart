import 'package:wareflow_mobile/modules/products/model.dart';
import 'package:wareflow_mobile/utils/dio.dart';

class InventoryAPI {
  static Future<List<ModelProduct>> getProducts() async {
    List<ModelProduct> products = [];
    try {
      final response = await dioClient.get('/product/product');
      if (response.statusCode == 200) {
        for (var item in response.data["data"]) {
          products.add(ModelProduct.fromJson(item));
        }
        return products;
      } else {
        return [];
      }
    } catch (error) {
      rethrow;
    }
  }
}
