import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharepact_app/api/auth_service.dart';
import 'package:sharepact_app/api/model/categories/listOfCategories.dart';
import 'package:sharepact_app/api/model/general_respons_model.dart';
import 'package:sharepact_app/api/model/subscription/subscription_model.dart';
import 'package:sharepact_app/api/model/user/listOfAvaterUrl.dart';
import 'package:sharepact_app/api/model/user/user_model.dart';

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
        updateAvater: AsyncData(null),
        updateUserNameAndEmail: AsyncData(null),
        checkTokenstatus: AsyncData(null),
        isTokenValid: AsyncData(null),
        getListCategories: AsyncData(null),
        changeProfilePassword: AsyncData(null),
        getUser: AsyncData(null),
        getListActiveSub: AsyncData(null),
        getListInactiveSub: AsyncData(null),
        getAllAvater: AsyncData(null));
  }

//auth flow
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

  Future<void> changeProfilePassword(
      {required String currentPassword, required String newPassword}) async {
    final auth = ref.read(authServiceProvider);
    try {
      state = state.copyWith(changeProfilePassword: const AsyncLoading());
      final response = await auth.changeProfilePassword(
          currentPassword: currentPassword, newPassword: newPassword);
      state = state.copyWith(changeProfilePassword: AsyncData(response));
    } catch (e) {
      state = state.copyWith(
          changeProfilePassword: AsyncError(e, StackTrace.current));
    }
  }

  Future<void> checkTokenStatus({
    required String token,
  }) async {
    final auth = ref.read(authServiceProvider);
    try {
      state = state.copyWith(checkTokenstatus: const AsyncLoading());
      final response = await auth.validateInterntToken(token: token);
      state = state.copyWith(checkTokenstatus: AsyncData(response));
    } catch (e) {
      state =
          state.copyWith(checkTokenstatus: AsyncError(e, StackTrace.current));
    }
  }

//user flow
  Future<void> getUserDetails() async {
    final auth = ref.read(authServiceProvider);
    try {
      state = state.copyWith(
        getUser: const AsyncLoading(),
      );
      final response = await auth.getUser();
      print(response.data?.email);
      state = state.copyWith(getUser: AsyncData(response));
    } catch (e) {
      state = state.copyWith(getUser: AsyncError(e, StackTrace.current));
    }
  }

  Future<void> updatAvater({required String avaterUrl}) async {
    final auth = ref.read(authServiceProvider);
    try {
      state = state.copyWith(
        updateAvater: const AsyncLoading(),
      );
      final response = await auth.updateAvater(avaterurl: avaterUrl);

      state = state.copyWith(updateAvater: AsyncData(response));
    } catch (e) {
      state = state.copyWith(updateAvater: AsyncError(e, StackTrace.current));
    }
  }

  Future<void> updatUserNameAndEmail(
      {required String userName, required String email}) async {
    final auth = ref.read(authServiceProvider);
    try {
      state = state.copyWith(
        updateUserNameAndEmail: const AsyncLoading(),
      );
      final response =
          await auth.updateUserNameAndEmailr(userName: userName, email: email);

      state = state.copyWith(updateUserNameAndEmail: AsyncData(response));
    } catch (e) {
      state = state.copyWith(
          updateUserNameAndEmail: AsyncError(e, StackTrace.current));
    }
  }

  Future<void> getAllAvater() async {
    final auth = ref.read(authServiceProvider);
    try {
      state = state.copyWith(
        getAllAvater: const AsyncLoading(),
      );
      final response = await auth.getAllAvater();
      state = state.copyWith(getAllAvater: AsyncData(response));
    } catch (e) {
      state = state.copyWith(getAllAvater: AsyncError(e, StackTrace.current));
    }
  }

//category flow
  Future<void> getListCategories() async {
    final auth = ref.read(authServiceProvider);
    try {
      state = state.copyWith(getListCategories: const AsyncLoading());
      final response = await auth.getListCategories();

      state = state.copyWith(getListCategories: AsyncData(response));
    } catch (e) {
      state =
          state.copyWith(getListCategories: AsyncError(e, StackTrace.current));
    }
  }

  //cub flow
  Future<void> getListActiveSub() async {
    final auth = ref.read(authServiceProvider);
    try {
      state = state.copyWith(getListActiveSub: const AsyncLoading());
      final response = await auth.getListActiveSub();
      // Check if the response is null or empty and handle it accordingly

      state = state.copyWith(getListActiveSub: AsyncData(response));
    } catch (e) {
      state =
          state.copyWith(getListActiveSub: AsyncError(e, StackTrace.current));
    }
  }

  Future<void> getListInActiveSub() async {
    final auth = ref.read(authServiceProvider);
    try {
      state = state.copyWith(getListInactiveSub: const AsyncLoading());
      final response = await auth.getListInActiveSub();
      state = state.copyWith(getListInactiveSub: AsyncData(response));
    } catch (e) {
      state =
          state.copyWith(getListInactiveSub: AsyncError(e, StackTrace.current));
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
  final AsyncValue<GeneralResponseModel?> updateAvater;
  final AsyncValue<GeneralResponseModel?> updateUserNameAndEmail;
  final AsyncValue<GeneralResponseModel?> changeProfilePassword;
  final AsyncValue<GeneralResponseModel?> checkTokenstatus;
  final AsyncValue<bool?> isTokenValid;
  final AsyncValue<UserResponseModel?> getUser;
  final AsyncValue<CategoriesResponseModel?> getListCategories;
  final AsyncValue<SubscriptionResponseModel?> getListActiveSub;
  final AsyncValue<SubscriptionResponseModel?> getListInactiveSub;
  final AsyncValue<AvaterResponseModel?> getAllAvater;

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
    required this.getUser,
    required this.getListCategories,
    required this.getListActiveSub,
    required this.getListInactiveSub,
    required this.updateAvater,
    required this.updateUserNameAndEmail,
    required this.getAllAvater,
    required this.changeProfilePassword,
    required this.checkTokenstatus,
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
    AsyncValue<GeneralResponseModel?>? updateAvater,
    AsyncValue<GeneralResponseModel?>? updateUserNameAndEmail,
    AsyncValue<GeneralResponseModel?>? changeProfilePassword,
    AsyncValue<GeneralResponseModel?>? checkTokenstatus,
    AsyncValue<UserResponseModel?>? getUser,
    AsyncValue<CategoriesResponseModel?>? getListCategories,
    AsyncValue<SubscriptionResponseModel?>? getListActiveSub,
    AsyncValue<SubscriptionResponseModel?>? getListInactiveSub,
    AsyncValue<AvaterResponseModel?>? getAllAvater,

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
        getToken: getToken ?? this.getToken,
        getUser: getUser ?? this.getUser,
        getListCategories: getListCategories ?? this.getListCategories,
        getListActiveSub: getListActiveSub ?? this.getListActiveSub,
        getListInactiveSub: getListInactiveSub ?? this.getListInactiveSub,
        updateAvater: updateAvater ?? this.updateAvater,
        updateUserNameAndEmail:
            updateUserNameAndEmail ?? this.updateUserNameAndEmail,
        getAllAvater: getAllAvater ?? this.getAllAvater,
        changeProfilePassword:
            changeProfilePassword ?? this.changeProfilePassword,
        checkTokenstatus: checkTokenstatus ?? this.checkTokenstatus

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
