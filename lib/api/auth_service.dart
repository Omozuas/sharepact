import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharepact_app/api/api_service.dart';
import 'package:sharepact_app/api/model/general_respons_model.dart';
import '../config.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthService {
  ApiService apiService = ApiService(baseUrl: Config.baseUrl);

  AuthService(this.ref);
  final Ref ref;
  Future<GeneralResponseModel> signup(
      {required String email, required String password}) async {
    try {
      final response = await apiService.post(
        endpoint: Config.signupEndpoint,
        body: {'email': email, 'password': password},
      );

      return response!;
    } catch (e) {
      rethrow;
    }
  }

  Future<GeneralResponseModel> confirmOtp(
      {required String email, required String code}) async {
    try {
      final response = await apiService.post(
        endpoint: Config.verifyOtpEndpoint,
        body: {'email': email, 'code': code},
      );

      return response!;
    } catch (e) {
      rethrow;
    }
  }

  Future<GeneralResponseModel> resendOtp({required String email}) async {
    try {
      final response = await apiService.post(
        endpoint: Config.resendOtpEndpoint,
        body: {'email': email},
      );

      return response!;
    } catch (e) {
      rethrow;
    }
  }

  Future<GeneralResponseModel> signin(String email, String password) async {
    try {
      final response = await http
          .post(
            Uri.parse(Config.signinEndpoint),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'email': email, 'password': password}),
          )
          .timeout(Config.requestTimeout);

      if (response.statusCode == 200) {
        saveToken(response);
        return generalResponseModelFromJson(response.body);
      } else {
        final errorResponse = jsonDecode(response.body);
        throw Exception(errorResponse['error'] ?? 'Failed to sign in');
      }
    } catch (e) {
      throw Exception('Failed to sign in: $e');
    }
  }

  Future<GeneralResponseModel> getUser() async {
    try {
      bool valid = await isTokenValid();
      if (!valid) {
        // Return an error response or handle it accordingly
        throw Exception("Invalid or expired token. Please log in again.");
      }
      final token = await _getToken();
      final response = await http.get(
        Uri.parse(Config.signinEndpoint),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ).timeout(Config.requestTimeout);

      if (response.statusCode == 200) {
        return generalResponseModelFromJson(response.body);
      } else {
        final errorResponse = jsonDecode(response.body);
        throw Exception(errorResponse['error'] ?? 'Failed to sign in');
      }
    } catch (e) {
      throw Exception('Failed to sign in: $e');
    }
  }

  void saveToken(Response response) async {
    var jsonres = jsonDecode(response.body);
    final preferences = await SharedPreferences.getInstance();
    preferences.setString('token', jsonres["data"]["token"]);
    return;
  }

  Future<bool> isTokenValid() async {
    final preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('token');
    if (token == null) {
      return false; // No token stored
    }
    return !JwtDecoder.isExpired(preferences.getString('token')!);
  }

  Future<String> _getToken() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString('token') ?? '';
  }
}

final authServiceProvider = Provider<AuthService>((ref) => AuthService(ref));
