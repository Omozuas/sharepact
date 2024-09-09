import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:sharepact_app/api/model/general_respons_model.dart';
import 'package:sharepact_app/config.dart';

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<Response> get({required String endpoint, String? token}) async {
    var response = await http.get(Uri.parse('$baseUrl$endpoint'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    }).timeout(Config.requestTimeout);

    return response;
  }

  Future<GeneralResponseModel?> get2(
      {required String endpoint, String? token}) async {
    try {
      var response = await http.get(Uri.parse('$baseUrl$endpoint'), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      }).timeout(Config.requestTimeout);

      return generalResponseModelFromJson(response.body);
    } on TimeoutException catch (_) {
      return GeneralResponseModel(
          code: 408, message: 'Request Timeout', data: null);
    } on SocketException catch (_) {
      return GeneralResponseModel(
          code: 503, message: 'No Internet connection', data: null);
    } catch (e) {
      return GeneralResponseModel(
          code: 500, message: 'Something went wrong', data: null);
    }
  }

  Future<GeneralResponseModel?> post(
      {required String endpoint,
      Map<String, dynamic>? body,
      String? token}) async {
    try {
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
    } on TimeoutException catch (_) {
      return GeneralResponseModel(
        code: 408,
        message: 'Request Timeout',
      );
    } on SocketException catch (_) {
      return GeneralResponseModel(
        code: 503,
        message: 'No Internet connection',
      );
    } catch (e) {
      final err = e as Map;
      final code = err['code'];
      final message = err['message'];
      final requestErr = err['error'];
      return GeneralResponseModel(
        code: code ?? 500,
        message: message ?? requestErr ?? 'Something went wrong $e',
      );
    }
  }

  Future<GeneralResponseModel?> post2(
      {required String endpoint,
      Map<String, dynamic>? body,
      String? token}) async {
    try {
      var response = await http
          .post(
            Uri.parse('$baseUrl$endpoint'),
            headers: {
              'Authorization': 'Bearer $token',
            },
            body: jsonEncode(body),
          )
          .timeout(Config.requestTimeout);

      return generalResponseModelFromJson(response.body);
    } on TimeoutException catch (_) {
      return GeneralResponseModel(
          code: 408, message: 'Request Timeout', data: null);
    } on SocketException catch (_) {
      return GeneralResponseModel(
          code: 503, message: 'No Internet connection', data: null);
    } catch (e) {
      return GeneralResponseModel(
          code: 500, message: 'Something went wrong', data: null);
    }
  }

  Future<GeneralResponseModel?> delete(
      {required String endpoint,
      Map<String, dynamic>? body,
      String? token}) async {
    try {
      var response = await http
          .delete(
            Uri.parse('$baseUrl$endpoint'),
            headers: {
              // 'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
            body: jsonEncode(body),
          )
          .timeout(Config.requestTimeout);
      return generalResponseModelFromJson(response.body);
    } on TimeoutException catch (_) {
      throw GeneralResponseModel(
          code: 408, message: 'Request Timeout', data: null);
    } on SocketException catch (_) {
      return GeneralResponseModel(
          code: 503, message: 'No Internet connection', data: null);
    } catch (e) {
      return GeneralResponseModel(
          code: 500, message: 'Something went wrong', data: null);
    }
  }

  Future<GeneralResponseModel?> put(
      {required String endpoint,
      required Map<String, dynamic> body,
      String? token}) async {
    try {
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
    } on TimeoutException catch (_) {
      return GeneralResponseModel(
          code: 408, message: 'Request Timeout', data: null);
    } on SocketException catch (_) {
      return GeneralResponseModel(
          code: 503, message: 'No Internet connection', data: null);
    } catch (e) {
      return GeneralResponseModel(
          code: 500, message: 'Something went wrong', data: null);
    }
  }

  Future<GeneralResponseModel?> patch(
      {required String endpoint,
      required Map<String, dynamic> body,
      String? token}) async {
    try {
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
    } on TimeoutException catch (_) {
      return GeneralResponseModel(
          code: 408, message: 'Request Timeout', data: null);
    } on SocketException catch (_) {
      return GeneralResponseModel(
          code: 503, message: 'No Internet connection', data: null);
    } catch (e) {
      return GeneralResponseModel(
          code: 500, message: 'Something went wrong', data: null);
    }
  }
  // Add other HTTP methods as needed (put, delete, etc.)
}
