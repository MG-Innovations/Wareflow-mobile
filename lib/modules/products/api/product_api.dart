import 'dart:convert';
import 'dart:developer';
import 'package:wareflow_mobile/modules/products/models/model_product.dart';
import 'package:wareflow_mobile/utils/dio.dart';
import 'package:http/http.dart' as http;
import 'package:wareflow_mobile/widgets/common_textfield.dart';

class InventoryAPI {
  static Future<List<ModelProduct>> getProducts({
    required String query,
  }) async {
    List<ModelProduct> products = [];
    try {
      // final response = await dioClient.get('/product?search=$query');
      final response = await http.get(
        Uri.parse('http://15.207.99.128:8000/api/v1/product?search=$query'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3MjQ5NDEwNzYsInVzZXJfaWQiOiI5NWRkNTIwMi1kZGQxLTRiYzItYTg4Ny02MTQwNGFkYTczMDkiLCJ0ZW5hbnRfaWQiOiIxMzVmN2JjYi03YjA4LTRkNjMtODEzMS1lNzVhMjVjYmFjYWQifQ.FG51YoO_wDsg1TLP2rDlvL4zbeVChR5cSuHIka32LCY"
        },
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
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
      List<ModelDropdown> companies = [];

      // final response = await dioClient.get('/company');
      final response = await http.get(
        Uri.parse('http://15.207.99.128:8000/api/v1/company/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3MjQ5NDEwNzYsInVzZXJfaWQiOiI5NWRkNTIwMi1kZGQxLTRiYzItYTg4Ny02MTQwNGFkYTczMDkiLCJ0ZW5hbnRfaWQiOiIxMzVmN2JjYi03YjA4LTRkNjMtODEzMS1lNzVhMjVjYmFjYWQifQ.FG51YoO_wDsg1TLP2rDlvL4zbeVChR5cSuHIka32LCY"
        },
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        for (var item in data["data"]) {
          companies.add(ModelDropdown.fromJson(item));
        }
      }
      return companies;
    } catch (error) {
      rethrow;
    }
  }

  static Future<List<ModelDropdown>> getAllProductType() async {
    try {
      List<ModelDropdown> productTypes = [];

      // final response = await dioClient.get('/product_type/');
      final response = await http.get(
        Uri.parse('http://15.207.99.128:8000/api/v1/product_type/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3MjQ5NDEwNzYsInVzZXJfaWQiOiI5NWRkNTIwMi1kZGQxLTRiYzItYTg4Ny02MTQwNGFkYTczMDkiLCJ0ZW5hbnRfaWQiOiIxMzVmN2JjYi03YjA4LTRkNjMtODEzMS1lNzVhMjVjYmFjYWQifQ.FG51YoO_wDsg1TLP2rDlvL4zbeVChR5cSuHIka32LCY"
        },
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        for (var item in data["data"]) {
          productTypes.add(ModelDropdown.fromJson(item));
        }
      }
      return productTypes;
    } catch (error) {
      rethrow;
    }
  }
}
