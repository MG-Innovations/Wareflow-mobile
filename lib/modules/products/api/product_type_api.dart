import 'package:wareflow_mobile/modules/products/models/model_product.dart';
import 'package:wareflow_mobile/utils/dio.dart';

class ProductTypeApi {
  static Future<List<ProductType>> getProductsType({
    required String query,
  }) async {
    List<ProductType> products = [];
    try {
      final response = await dioClient.get('/product_type/');
      if (response.statusCode == 200) {
        for (var item in response.data["data"]) {
          products.add(ProductType.fromJson(item));
        }
        return products;
      } else {
        return [];
      }
    } catch (error) {
      rethrow;
    }
  }

  static Future<bool> submitProductType({
    required String producName,
    required String productDescription,
  }) async {
    try {
      final productTypeData = {
        "name": producName,
        "description": productDescription,
      };

      print(productTypeData.toString());
      final response =
          await dioClient.post('/product_type/', data: productTypeData);

      print(response.toString());

      if (response.statusCode == 201) {
        return true;
      }
      return false;
    } catch (error) {
      rethrow;
    }
  }

  final String name;
  final String description;

  ProductTypeApi({
    required this.name,
    required this.description,
  });

  factory ProductTypeApi.fromJson(Map<String, dynamic> json) {
    return ProductTypeApi(
      name: json['name'] as String,
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
    };
  }
}
