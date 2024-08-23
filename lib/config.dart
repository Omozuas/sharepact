class Config {
  static const String baseUrl = 'https://6bc6-51-6-13-158.ngrok-free.app';
  static const Duration requestTimeout = Duration(seconds: 30);
  static const String appName = 'SharePact';
  static const String appVersion = '1.0.0';
  static const bool enableLogging = true;

  // Auth Endpoints
  static const String signupEndpoint = '/auth/signup';
  static const String signinEndpoint = '/auth/signin';
  static const String verifyOtpEndpoint = '/auth/email-verification/verify-otp';
  static const String resendOtpEndpoint = '/auth/email-verification/resend-otp';
}
