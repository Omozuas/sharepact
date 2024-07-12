class Config {
  static const String baseUrl = 'https://6659-78-18-216-210.ngrok-free.app';
  static const Duration requestTimeout = Duration(seconds: 30);
  static const String appName = 'SharePact';
  static const String appVersion = '1.0.0';
  static const bool enableLogging = true;

  // Auth Endpoints
  static const String signupEndpoint = '/auth/signup';
  static const String signinEndpoint = '/auth/signin';
}
