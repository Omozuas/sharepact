import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config.dart';

class AuthService {
  final String baseUrl;

  AuthService() : baseUrl = Config.baseUrl;

  Future<Map<String, dynamic>> signup(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl + Config.signupEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      ).timeout(Config.requestTimeout);

      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        final errorResponse = jsonDecode(response.body);
        throw Exception(errorResponse['error'] ?? 'Failed to sign up');
      }
    } catch (e) {
      throw Exception('Failed to sign up: $e');
    }
  }

  Future<Map<String, dynamic>> signin(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl + Config.signinEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      ).timeout(Config.requestTimeout);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        final errorResponse = jsonDecode(response.body);
        throw Exception(errorResponse['error'] ?? 'Failed to sign in');
      }
    } catch (e) {
      throw Exception('Failed to sign in: $e');
    }
  }
}
