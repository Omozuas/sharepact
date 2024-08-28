class Config {
  static const String baseUrl = 'https://a8c4-51-6-13-158.ngrok-free.app';
  static const Duration requestTimeout = Duration(seconds: 30);
  static const String appName = 'SharePact';
  static const String appVersion = '1.0.0';
  static const bool enableLogging = true;

  // Auth Endpoints
  static const String signupEndpoint = '/auth/signup';
  static const String signinEndpoint = '/auth/signin';
  static const String verifyOtpEndpoint = '/auth/email-verification/verify-otp';
  static const String resendOtpEndpoint = '/auth/email-verification/resend-otp';
  static const String reSetPasswordEndpoint = '/auth/password-reset';
  static const String confirmreSetPasswordEndpoint =
      '/auth/password-reset/verify-otp';
  static const String changePasswordEndpoint = '/auth/change-password';
  static const String logoutEndpoint = '/auth/logout';

  //user Endpoint
  static const String getUserEndpoint = '/auth/user';
  static const String updateAvaterEndpoint = '/api/profile/update-avatar';
  static const String updateUserName = '/api/profile/update-username-email';
  static const String getAllAvaters = '/api/profile/avatars';

  //categories Endpoint
  static const String getCategoriesEndpoint = '/api/categories';

  //subscription Endpoint
  static const String getActiveSubscriptionsEndpoint =
      '/api/groups?subscriptionStatus=active';
  static const String getInActiveSubscriptionsEndpoint =
      '/api/groups?subscriptionStatus=inactive';
}
