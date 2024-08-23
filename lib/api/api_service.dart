import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sharepact_app/api/model/general_respons_model.dart';
import 'package:sharepact_app/config.dart';

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<GeneralResponseModel?> get(String endpoint, String? token) async {
    var response = await http.get(Uri.parse('$baseUrl $endpoint'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    }).timeout(Config.requestTimeout);
    return generalResponseModelFromJson(response.body);
  }

  Future<GeneralResponseModel?> post(
      {required String endpoint,
      required Map<String, dynamic> body,
      String? token}) async {
    var response = await http
        .post(
          Uri.parse('$baseUrl$endpoint'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(body),
        )
        .timeout(Config.requestTimeout);

    return generalResponseModelFromJson(response.body);
  }

  Future<GeneralResponseModel?> delete(
      String endpoint, Map<String, dynamic> body, String? token) async {
    var response = await http
        .delete(
          Uri.parse('$baseUrl$endpoint'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(body),
        )
        .timeout(Config.requestTimeout);
    return generalResponseModelFromJson(response.body);
  }

  Future<GeneralResponseModel?> put(
      String endpoint, Map<String, dynamic> body, String? token) async {
    var response = await http
        .put(
          Uri.parse('$baseUrl$endpoint'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(body),
        )
        .timeout(Config.requestTimeout);
    return generalResponseModelFromJson(response.body);
  }

  Future<GeneralResponseModel?> patch(
      String endpoint, Map<String, dynamic> body, String? token) async {
    var response = await http
        .patch(
          Uri.parse('$baseUrl$endpoint'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(body),
        )
        .timeout(Config.requestTimeout);
    return generalResponseModelFromJson(response.body);
  }
  // Add other HTTP methods as needed (put, delete, etc.)
}
