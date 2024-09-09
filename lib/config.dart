class Config {
  static const String baseUrl =
      'https://improved-endlessly-midge.ngrok-free.app';
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
  static const String verifyTokenEndpoint = '/auth/verify-token';
  static const String changeProfilePasswordEndpoint =
      '/api/profile/change-password';

  //user Endpoint
  static const String getUserEndpoint = '/auth/user';
  static const String updateAvaterEndpoint = '/api/profile/update-avatar';
  static const String updateUserName = '/api/profile/update-username-email';
  static const String getAllAvaters = '/api/profile/avatars';
  static const String deleteAccount = '/api/profile/delete-user';

  //categories Endpoint
  static const String getCategoriesEndpoint = '/api/categories';
  static const String getCategoriesByIdEndpoint = '/api/categories/';

  //subscription Endpoint
  static const String getActiveSubscriptionsEndpoint =
      '/api/groups?subscription_status=inactive';
  // '/api/groups?subscription_status=active';
  static const String getInActiveSubscriptionsEndpoint =
      '/api/groups?subscription_status=inactive';
  static const String updateSubscriptionCostEndpoint =
      '/api/groups/update-subscription-cost/';

  //bank Endpoint
  static const String getBankEndpoint = '/api/bank-details/';
  static const String getAllBankEndpoint = '/api/banks';
  static const String postBankEndpoint = '/api/bank-details';

  ///service end point
  static const String getServiceByIdEndpoint = '/api/services/';

  //group
  static const String createGroupEndpoint = '/api/groups/create';
  static const String leaveeGroupEndpoint = '/api/groups/leave/';
  static const String acceptOrRejectGroupEndpoint =
      '/api/groups/handle-join-request';
  static const String getGroupDetailsEndpoint = '/api/groups/';
  static const String getGroupJiinRequestsEndpoint =
      '/api/groups/join-requests/';
  static const String getGroupByCodeEndpoint = '/api/groups/by-code/';
  static const String joinGroupEndpoint = '/api/groups/join';
  static const String groupListEndpoint = '/api/groups/grouplist';
  static const String confirmStatusEndpoint = '/api/groups/confirm-status/';
  static const String activateGroupEndpoint = '/api/groups/activate/';
  static const String markGroupMesagesEndpoint =
      '/api/chat/messages/mark-as-read';
//support
  static const String contactSupportEndpoint = '/api/support/contact-support';

  //Notification
  static const String patchNotificationSettingEndpoint =
      '/api/profile/notification-config';
  static const String getNotificationSettingEndpoint =
      '/api/profile/notification-config';
  static const String getNotificationsEndpoint = '/api/profile/notifications?';
}
