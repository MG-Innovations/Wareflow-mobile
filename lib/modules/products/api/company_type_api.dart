import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:wareflow_mobile/modules/products/models/model_product.dart';
import 'package:wareflow_mobile/utils/dio.dart';
import 'package:http/http.dart' as http;

class CompanyTypeApi {
  static Future<List<CompanyType>> getCompanysType({
    required String query,
  }) async {
    List<CompanyType> company = [];
    try {
      final response = await http.get(
        Uri.parse('http://15.207.99.128:8000/api/v1/company/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3MjQ5NDEwNzYsInVzZXJfaWQiOiI5NWRkNTIwMi1kZGQxLTRiYzItYTg4Ny02MTQwNGFkYTczMDkiLCJ0ZW5hbnRfaWQiOiIxMzVmN2JjYi03YjA4LTRkNjMtODEzMS1lNzVhMjVjYmFjYWQifQ.FG51YoO_wDsg1TLP2rDlvL4zbeVChR5cSuHIka32LCY"
        },
      );

      log('Response in Company type: $response');

      final data = jsonDecode(response.body);

      log('data: $data');

      if (response.statusCode == 200) {
        for (var item in data["data"]) {
          company.add(CompanyType.fromJson(item));
        }
        return company;
      } else {
        return [];
      }
    } catch (error) {
      rethrow;
    }
  }

  static Future<bool> submitCompanyType({
    required String companyName,
    required String companyEmail,
    required String companyPhonenumber,
  }) async {
    try {
      final companyTypeData = {
        "name": companyName,
        "email": companyEmail,
        "phone_number": companyPhonenumber,
      };

      print("Request Data: $companyTypeData");

      final response = await dioClient.post(
        '/company/',
        data: companyTypeData,
      );

      print("Response: ${response.toString()}");

      if (response.statusCode == 201) {
        return true;
      } else {
        print("Unexpected status code: ${response.statusCode}");
      }
      return false;
    } catch (error) {
      if (error is DioError) {
        print("DioError: ${error.message}");
        if (error.response != null) {
          print("DioError Response data: ${error.response!.data}");
          print("DioError Status code: ${error.response!.statusCode}");
        }
      } else {
        print("Error: $error");
      }
      return false;
    }
  }

  // static Future<bool> submitCompanyType({
  //   required String companyName,
  //   required String companyEmail,
  //   required String companyPhonenumber,
  // }) async {
  //   try {
  //     final companyTypeData = {
  //       "name": companyName,
  //       "Email": companyEmail,
  //       "Phone_number": companyPhonenumber,
  //     };

  //     print(companyTypeData.toString());
  //     final response = await dioClient.post(
  //         'http://15.207.99.128:8000/api/v1/company/',
  //         data: companyTypeData);

  //     print(response.toString());

  //     if (response.statusCode == 201) {
  //       return true;
  //     }
  //     return false;
  //   } catch (error) {
  //     rethrow;
  //   }
  // }
}
