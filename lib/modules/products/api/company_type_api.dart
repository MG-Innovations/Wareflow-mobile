import 'dart:convert';
import '../../../utils/dio.dart';
import '../models/model_product.dart';

class CompanyTypeApi {
  static Future<List<CompanyType>> getCompanysType({
    required String query,
  }) async {
    List<CompanyType> company = [];
    try {
      final response = await dioClient.get('/company/');

      final data = jsonDecode(response.body);

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
