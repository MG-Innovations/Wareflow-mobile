import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../../utils/dio.dart';
import '../models/model_product.dart';

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

      final response = await dioClient.post(
        '/company/',
        data: companyTypeData,
      );

      if (response.statusCode == 201) {
        return true;
      }
      return false;
    } catch (error) {
      rethrow;
    }
  }
}
