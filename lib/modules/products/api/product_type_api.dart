import 'dart:convert';
import 'dart:developer';

import '../../../utils/dio.dart';
import '../models/model_product.dart';

class ProductTypeApi {
  static Future<List<ProductType>> getProductsType({
    required String query,
  }) async {
    List<ProductType> products = [];
    try {
      final response = await dioClient.get('/product_type/');

      log('Response in product type: $response');

      final data = jsonDecode(response.body);

      log('data: $data');

      if (response.statusCode == 200) {
        for (var item in data["data"]) {
          products.add(ProductType.fromJson(item));
        }
        return products;
      } else {
        return [];
      }

      // return [];
    } catch (error) {
      // log('Error in product type: $error');
      rethrow;
    }
  }

  static Future<bool> submitProductType({
    required String productTypeName,
    required String productTypeDescription,
  }) async {
    try {
      final productTypeData = {
        "name": productTypeName,
        "description": productTypeDescription,
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
