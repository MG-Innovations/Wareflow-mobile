import 'dart:convert';
import 'dart:developer';

import '../../../utils/dio.dart';
import '../../../widgets/common_textfield.dart';
import '../models/model_product.dart';

class InventoryAPI {
  static Future<List<ModelProduct>> getProducts({
    required String query,
  }) async {
    List<ModelProduct> products = [];
    try {
      final response = await dioClient.get('/product?search=$query');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        for (var item in data["data"]) {
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

  static Future<List<ModelDropdown>> getProductsAsDropdown({
    required String query,
  }) async {
    List<ModelDropdown> products = [];
    try {
      final response = await dioClient.get('/product/?search=$query');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        log(data.toString());
        for (var item in data["data"]) {
          products.add(ModelDropdown(
            id: item["id"],
            name: item["name"],
          ));
        }
        return products;
      } else {
        return [];
      }
    } catch (error) {
      rethrow;
    }
  }

  static Future<bool> submitProduct(
      {required String producName,
      required String productDescription,
      required String productTypeId,
      required String productCompanyNameId,
      required String sellingPrice,
      required String buyingPrice,
      required String initialStock}) async {
    try {
      final productData = {
        "name": producName,
        "description": productDescription,
        "buying_price": double.parse(buyingPrice),
        "selling_price": double.parse(sellingPrice),
        "stock": double.parse(initialStock),
        "image": "",
        "company_id": productCompanyNameId,
        "product_type_id": productTypeId
      };

      log(productData.toString());
      final response = await dioClient.post('/product', data: productData);

      log(response.toString());

      if (response.statusCode == 201) {
        return true;
      }
      return false;
    } catch (error) {
      rethrow;
    }
  }

  static Future<List<ModelDropdown>> getAllCompany() async {
    try {
      List<ModelDropdown> productTypes = [];

      final response = await dioClient.get('/company');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        for (var item in data["data"]) {
          productTypes.add(ModelDropdown.fromJson(item));
        }
      }
      return productTypes;
    } catch (error) {
      rethrow;
    }
  }

  static Future<List<ModelDropdown>> getAllProductType() async {
    try {
      List<ModelDropdown> companies = [];

      final response = await dioClient.get('/product_type');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        for (var item in data["data"]) {
          companies.add(ModelDropdown.fromJson(item));
        }
      }
      return companies;
    } catch (error) {
      rethrow;
    }
  }
}
