// lib/config.dart

class Config {
  static const String baseUrl = 'https://3dbf-51-6-13-185.ngrok-free.app';
  static const Duration requestTimeout = Duration(seconds: 30);
  static const String appName = 'SharePact';
  static const String appVersion = '1.0.0';
  static const bool enableLogging = true;

  // Auth Endpoints
  static const String signupEndpoint = '/auth';
  static const String signinEndpoint = '/auth';
}
