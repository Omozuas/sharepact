import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharepact_app/api/auth_service.dart';
import 'package:sharepact_app/api/model/general_respons_model.dart';

class AuthServiceProvider
    extends AutoDisposeNotifier<AuthServiceProviderStates> {
  @override
  AuthServiceProviderStates build() {
    return const AuthServiceProviderStates(
        generalrespond: AsyncData(null),
        otp: AsyncData(null),
        resendOtp: AsyncData(null),
        login: AsyncData(null),
        resetPassword: AsyncData(null),
        confirmReSetPassword: AsyncData(null),
        changePassword: AsyncData(null),
        logout: AsyncData(null),
        getToken: AsyncData(null),
        isTokenValid: AsyncData(null));
  }

  Future<void> createUser(
      {required String email, required String password}) async {
    final auth = ref.read(authServiceProvider);
    try {
      state = state.copyWith(generalrespond: const AsyncLoading());
      final response = await auth.signup(email: email, password: password);
      state = state.copyWith(generalrespond: AsyncData(response));
    } catch (e) {
      state = state.copyWith(generalrespond: AsyncError(e, StackTrace.current));
    }
  }

  Future<void> veryifyOtp({required String email, required String code}) async {
    final auth = ref.read(authServiceProvider);
    try {
      state = state.copyWith(otp: const AsyncLoading());
      final response = await auth.confirmOtp(email: email, code: code);
      state = state.copyWith(otp: AsyncData(response));
    } catch (e) {
      state = state.copyWith(otp: AsyncError(e, StackTrace.current));
    }
  }

  Future<void> resendOtp({required String email}) async {
    final auth = ref.read(authServiceProvider);
    try {
      state = state.copyWith(resendOtp: const AsyncLoading());
      final response = await auth.resendOtp(
        email: email,
      );
      state = state.copyWith(resendOtp: AsyncData(response));
    } catch (e) {
      state = state.copyWith(resendOtp: AsyncError(e, StackTrace.current));
    }
  }

  Future<void> loginUser(
      {required String email, required String password}) async {
    final auth = ref.read(authServiceProvider);
    try {
      state = state.copyWith(login: const AsyncLoading());
      final response = await auth.signin(email: email, password: password);
      state = state.copyWith(login: AsyncData(response));
    } catch (e) {
      state = state.copyWith(login: AsyncError(e, StackTrace.current));
    }
  }

  Future<void> reSetPasword({required String email}) async {
    final auth = ref.read(authServiceProvider);
    try {
      state = state.copyWith(resetPassword: const AsyncLoading());
      final response = await auth.reSetPassword(email: email);
      state = state.copyWith(resetPassword: AsyncData(response));
    } catch (e) {
      state = state.copyWith(resetPassword: AsyncError(e, StackTrace.current));
    }
  }

  Future<void> confirmReSetPassword(
      {required String email, required String code}) async {
    final auth = ref.read(authServiceProvider);
    try {
      state = state.copyWith(confirmReSetPassword: const AsyncLoading());
      final response =
          await auth.confirmReSetPassword(email: email, code: code);
      state = state.copyWith(confirmReSetPassword: AsyncData(response));
    } catch (e) {
      state = state.copyWith(
          confirmReSetPassword: AsyncError(e, StackTrace.current));
    }
  }

  Future<void> changePassword(
      {required String email,
      required String code,
      required String password}) async {
    final auth = ref.read(authServiceProvider);
    try {
      state = state.copyWith(changePassword: const AsyncLoading());
      final response = await auth.changePassword(
          email: email, code: code, password: password);
      state = state.copyWith(changePassword: AsyncData(response));
    } catch (e) {
      state = state.copyWith(changePassword: AsyncError(e, StackTrace.current));
    }
  }

  Future<bool> validateToken() async {
    final auth = ref.read(authServiceProvider);
    try {
      state = state.copyWith(isTokenValid: const AsyncLoading());
      final response = await auth.isTokenValid();
      state = state.copyWith(isTokenValid: AsyncData(response));
      return response;
    } catch (e) {
      state = state.copyWith(isTokenValid: AsyncError(e, StackTrace.current));
      return false;
    }
  }

  Future<void> logOut({required String token}) async {
    final auth = ref.read(authServiceProvider);
    try {
      state = state.copyWith(logout: const AsyncLoading());
      final response = await auth.logout(token: token);
      state = state.copyWith(logout: AsyncData(response));
    } catch (e) {
      state = state.copyWith(logout: AsyncError(e, StackTrace.current));
    }
  }

  Future<void> getToken() async {
    final auth = ref.read(authServiceProvider);
    try {
      state = state.copyWith(getToken: const AsyncLoading());
      final response = await auth.getToken();
      state = state.copyWith(getToken: AsyncData(response));
    } catch (e) {
      state = state.copyWith(getToken: AsyncError(e, StackTrace.current));
    }
  }
}

final profileProvider =
    AutoDisposeNotifierProvider<AuthServiceProvider, AuthServiceProviderStates>(
        AuthServiceProvider.new);

class AuthServiceProviderStates {
  // final AsyncValue<UserModel?> user;
  // final AsyncValue<UserProfile?> profileUpdater;
  final AsyncValue<GeneralResponseModel?> generalrespond;
  final AsyncValue<GeneralResponseModel?> otp;
  final AsyncValue<GeneralResponseModel?> resendOtp;
  final AsyncValue<GeneralResponseModel?> login;
  final AsyncValue<GeneralResponseModel?> resetPassword;
  final AsyncValue<GeneralResponseModel?> confirmReSetPassword;
  final AsyncValue<GeneralResponseModel?> changePassword;
  final AsyncValue<GeneralResponseModel?> logout;
  final AsyncValue<bool?> isTokenValid;
  // final AsyncValue<NotificationModel?> notificationUpdater;
  // final AsyncValue<NotificationModel?> notificationFetch;
  // final AsyncValue<SubscriptionModel?> fetchSubcription;
  // final AsyncValue<SubscriptionModel?> fetchSubcriptionbyUserId;
  // final AsyncValue<UpdatePasswordModel?> updatePassword;
  final AsyncValue<String?> getToken;
  // final AsyncValue<String?> initiateSubscription;

  const AuthServiceProviderStates({
    // required this.pickedImage,
    // required this.user,
    // required this.profileUpdater,
    required this.generalrespond,
    required this.otp,
    required this.resendOtp,
    required this.login,
    required this.resetPassword,
    required this.confirmReSetPassword,
    required this.changePassword,
    required this.isTokenValid,
    required this.logout,
    required this.getToken,
    // required this.notificationFetch,
    // required this.fetchSubcription,
    // required this.fetchSubcriptionbyUserId,
    // required this.updatePassword,
    // required this.inviteLink,
    // required this.initiateSubscription,
  });

  AuthServiceProviderStates copyWith({
    //   XFile? pickedImage,
    // AsyncValue<UserModel?>? user,
    // AsyncValue<UserProfile?>? profileUpdater,
    AsyncValue<GeneralResponseModel?>? generalrespond,
    AsyncValue<GeneralResponseModel?>? otp,
    AsyncValue<GeneralResponseModel?>? resendOtp,
    AsyncValue<GeneralResponseModel?>? login,
    AsyncValue<GeneralResponseModel?>? resetPassword,
    AsyncValue<GeneralResponseModel?>? confirmReSetPassword,
    AsyncValue<GeneralResponseModel?>? changePassword,
    AsyncValue<bool?>? isTokenValid,
    AsyncValue<GeneralResponseModel?>? logout,
    // AsyncValue<NotificationModel?>? notificationUpdater,
    // AsyncValue<NotificationModel?>? notificationFetch,
    // AsyncValue<SubscriptionModel?>? fetchSubcription,

    //   AsyncValue<SubscriptionModel?>? fetchSubcriptionbyUserId,

    AsyncValue<String?>? getToken,
    //   AsyncValue<String?>? initiateSubscription,

    // AsyncValue<UpdatePasswordModel?>? updatePassword
  }) {
    return AuthServiceProviderStates(
        // pickedImage: pickedImage ?? this.pickedImage,
        // user: user ?? this.user,
        // profileUpdater: profileUpdater ?? this.profileUpdater,
        generalrespond: generalrespond ?? this.generalrespond,
        otp: otp ?? this.otp,
        resendOtp: resendOtp ?? this.resendOtp,
        login: login ?? this.login,
        resetPassword: resetPassword ?? this.resetPassword,
        confirmReSetPassword: confirmReSetPassword ?? this.confirmReSetPassword,
        changePassword: changePassword ?? this.changePassword,
        isTokenValid: isTokenValid ?? this.isTokenValid,
        logout: logout ?? this.logout,
        getToken: getToken ?? this.getToken
        // notificationUpdater: notificationUpdater ?? this.notificationUpdater,
        // notificationFetch: notificationFetch ?? this.notificationFetch,
        // fetchSubcription: fetchSubcription ?? this.fetchSubcription,

        // fetchSubcriptionbyUserId: fetchSubcriptionbyUserId ?? this.fetchSubcriptionbyUserId,

        // inviteLink: inviteLink ?? this.inviteLink,
        // initiateSubscription: initiateSubscription ?? this.initiateSubscription,

        // updatePassword: updatePassword ?? this.updatePassword
        );
  }
}
