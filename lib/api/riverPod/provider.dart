import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharepact_app/api/auth_service.dart';
import 'package:sharepact_app/api/model/general_respons_model.dart';

class AuthServiceProvider
    extends AutoDisposeNotifier<AuthServiceProviderStates> {
  @override
  AuthServiceProviderStates build() {
    return AuthServiceProviderStates(
      generalrespond: AsyncData(null),
      otp: AsyncData(null),
      resendOtp: AsyncData(null),
    );
  }

  Future<void> createUser(
      {required String email, required String password}) async {
    print({email, password});
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
    print({email, code});
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
    print({email});
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
  // final AsyncValue<NotificationModel?> notificationUpdater;
  // final AsyncValue<NotificationModel?> notificationFetch;
  // final AsyncValue<SubscriptionModel?> fetchSubcription;
  // final AsyncValue<SubscriptionModel?> fetchSubcriptionbyUserId;
  // final AsyncValue<UpdatePasswordModel?> updatePassword;
  // final AsyncValue<String?> inviteLink;
  // final AsyncValue<String?> initiateSubscription;

  const AuthServiceProviderStates(
      {
      // required this.pickedImage,
      // required this.user,
      // required this.profileUpdater,
      required this.generalrespond,
      required this.otp,
      required this.resendOtp
      // required this.notificationUpdater,
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
    // AsyncValue<NotificationModel?>? notificationUpdater,
    // AsyncValue<NotificationModel?>? notificationFetch,
    // AsyncValue<SubscriptionModel?>? fetchSubcription,

    //   AsyncValue<SubscriptionModel?>? fetchSubcriptionbyUserId,

    //   AsyncValue<String?>? inviteLink,
    //   AsyncValue<String?>? initiateSubscription,

    // AsyncValue<UpdatePasswordModel?>? updatePassword
  }) {
    return AuthServiceProviderStates(
        // pickedImage: pickedImage ?? this.pickedImage,
        // user: user ?? this.user,
        // profileUpdater: profileUpdater ?? this.profileUpdater,
        generalrespond: generalrespond ?? this.generalrespond,
        otp: otp ?? this.otp,
        resendOtp: resendOtp ?? this.resendOtp
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
