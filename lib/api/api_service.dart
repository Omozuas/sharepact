import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sharepact_app/config.dart';

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<http.Response> get(String endpoint) {
    return http.get(Uri.parse('$baseUrl$endpoint')).timeout(Config.requestTimeout);
  }

  Future<http.Response> post(String endpoint, Map<String, dynamic> body) {
    return http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    ).timeout(Config.requestTimeout);
  }

  // Add other HTTP methods as needed (put, delete, etc.)
}
