import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharepact_app/api/auth_service.dart';
import 'package:sharepact_app/api/model/general_respons_model.dart';
import 'package:sharepact_app/api/model/servicemodel/servicemodel.dart';
import 'package:sharepact_app/api/model/subscription/subscription_model.dart';
import 'package:sharepact_app/api/model/user/listOfAvaterUrl.dart';

class AuthServiceProvider
    extends AutoDisposeNotifier<AuthServiceProviderStates> {
  @override
  AuthServiceProviderStates build() {
    print('boyyyy');
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
        changeProfilePassword: AsyncData(null),
        getListInactiveSub: AsyncData(null),
        getAllAvater: AsyncData(null),
        getServiceById: AsyncData(null),
        motificationSettings: AsyncData(null),
        createGroup: AsyncData(null),
        contactService: AsyncData(null),
        postBankDetails: AsyncData(null),
        leaveGroup: AsyncData(null),
        acceptOrRejectInviteGroup: AsyncData(null),
        deleteAccount: AsyncData(null),
        getUserId: AsyncData(null),
        joinGroup: AsyncData(null),
        updateSubsriptionCost: AsyncData(null),
        updateConfirmStatus: AsyncData(null),
        updateActivateGroup: AsyncData(null),
        markGroupAsRead: AsyncData(null),
        getGroupbyCode: AsyncData(null));
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

  Future<void> getuserId() async {
    final auth = ref.read(authServiceProvider);
    try {
      state = state.copyWith(getUserId: const AsyncLoading());
      final response = await auth.getuserId();
      state = state.copyWith(getUserId: AsyncData(response));
    } catch (e) {
      state = state.copyWith(getUserId: AsyncError(e, StackTrace.current));
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

  Future<void> deleteAccount() async {
    final auth = ref.read(authServiceProvider);
    try {
      state = state.copyWith(deleteAccount: const AsyncLoading());
      final response = await auth.deletAccount();
      state = state.copyWith(deleteAccount: AsyncData(response));
    } catch (e) {
      state = state.copyWith(deleteAccount: AsyncError(e, StackTrace.current));
    }
  }
  //scub flow

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

//bank flow

  Future<void> postBankDetails(
      {required String accountName,
      required String bankName,
      required String accountNumber,
      required String sortCode}) async {
    final auth = ref.read(authServiceProvider);
    try {
      state = state.copyWith(
        postBankDetails: const AsyncLoading(),
      );
      final response = await auth.postBankDetails(
          accountName: accountName,
          accountNumber: accountNumber,
          sortCode: sortCode,
          bankName: bankName);
      state = state.copyWith(postBankDetails: AsyncData(response));
    } catch (e) {
      state =
          state.copyWith(postBankDetails: AsyncError(e, StackTrace.current));
    }
  }

//service flow
  Future<void> getServiceById({required String id}) async {
    final auth = ref.read(authServiceProvider);

    try {
      state = state.copyWith(getServiceById: const AsyncLoading());
      final response = await auth.getServiceById(id: id);
      // print(response.toList());
      state = state.copyWith(getServiceById: AsyncData(response));
    } catch (e) {
      state = state.copyWith(getServiceById: AsyncError(e, StackTrace.current));
    }
  }

  //group
  Future<void> createGroup(
      {required String serviceId,
      required String groupName,
      required int numberOfMembers,
      required bool existingGroup,
      required int subscriptionCost,
      required bool oneTimePayment}) async {
    final auth = ref.read(authServiceProvider);
    try {
      state = state.copyWith(
        createGroup: const AsyncLoading(),
      );
      final response = await auth.createGroup(
          serviceId: serviceId,
          groupName: groupName,
          numberOfMembers: numberOfMembers,
          oneTimePayment: oneTimePayment,
          subscriptionCost: subscriptionCost,
          existingGroup: existingGroup);
      state = state.copyWith(createGroup: AsyncData(response));
    } catch (e) {
      state = state.copyWith(createGroup: AsyncError(e, StackTrace.current));
    }
  }

  Future<void> leaveGroup({
    required String roomId,
  }) async {
    final auth = ref.read(authServiceProvider);
    try {
      state = state.copyWith(
        leaveGroup: const AsyncLoading(),
      );
      final response = await auth.leaveGroup(id: roomId);
      state = state.copyWith(leaveGroup: AsyncData(response));
    } catch (e) {
      state = state.copyWith(leaveGroup: AsyncError(e, StackTrace.current));
    }
  }

  Future<void> acceptOrRejectInviteGroup(
      {required String groupId,
      required String userId,
      required bool approve}) async {
    final auth = ref.read(authServiceProvider);
    try {
      state = state.copyWith(
        acceptOrRejectInviteGroup: const AsyncLoading(),
      );
      final response = await auth.acceptOrRejectInviteGroup(
          groupId: groupId, userId: userId, approve: approve);
      state = state.copyWith(acceptOrRejectInviteGroup: AsyncData(response));
    } catch (e) {
      state = state.copyWith(
          acceptOrRejectInviteGroup: AsyncError(e, StackTrace.current));
    }
  }

  Future<void> joinAGroup(
      {required String groupCode, required String message}) async {
    final auth = ref.read(authServiceProvider);
    try {
      state = state.copyWith(
        joinGroup: const AsyncLoading(),
      );
      final response =
          await auth.joinAGroup(groupCode: groupCode, message: message);
      state = state.copyWith(joinGroup: AsyncData(response));
    } catch (e) {
      state = state.copyWith(joinGroup: AsyncError(e, StackTrace.current));
    }
  }

  Future<void> getGroupByCode({
    required String groupId,
  }) async {
    final auth = ref.read(authServiceProvider);
    try {
      state = state.copyWith(
        getGroupbyCode: const AsyncLoading(),
      );
      final response = await auth.getGroupByCode(groupId: groupId);
      state = state.copyWith(getGroupbyCode: AsyncData(response));
    } catch (e) {
      state = state.copyWith(getGroupbyCode: AsyncError(e, StackTrace.current));
    }
  }

  Future<void> updatSubscriptioncost(
      {required int newSubscriptionCost, required String id}) async {
    final auth = ref.read(authServiceProvider);
    try {
      state = state.copyWith(
        updateSubsriptionCost: const AsyncLoading(),
      );
      final response = await auth.updateSubscriptionCost(
          newSubscriptionCost: newSubscriptionCost, id: id);

      state = state.copyWith(updateSubsriptionCost: AsyncData(response));
    } catch (e) {
      state = state.copyWith(
          updateSubsriptionCost: AsyncError(e, StackTrace.current));
    }
  }

  Future<void> updatActivateGroup({required String id}) async {
    final auth = ref.read(authServiceProvider);
    try {
      state = state.copyWith(
        updateActivateGroup: const AsyncLoading(),
      );
      final response = await auth.updateActivateGroup(id: id);

      state = state.copyWith(updateActivateGroup: AsyncData(response));
    } catch (e) {
      state = state.copyWith(
          updateActivateGroup: AsyncError(e, StackTrace.current));
    }
  }

  Future<void> updatConfirmStatus({required String id}) async {
    final auth = ref.read(authServiceProvider);
    try {
      state = state.copyWith(
        updateConfirmStatus: const AsyncLoading(),
      );
      final response = await auth.updateConfirmStatus(id: id);

      state = state.copyWith(updateConfirmStatus: AsyncData(response));
    } catch (e) {
      state = state.copyWith(
          updateConfirmStatus: AsyncError(e, StackTrace.current));
    }
  }

  Future<void> markGroupAsRead(
      {required String groupId, required List<String> messagesid}) async {
    final auth = ref.read(authServiceProvider);
    try {
      state = state.copyWith(
        markGroupAsRead: const AsyncLoading(),
      );
      final response =
          await auth.markGroupasRead(groupId: groupId, messagesid: messagesid);

      state = state.copyWith(markGroupAsRead: AsyncData(response));
    } catch (e) {
      state =
          state.copyWith(markGroupAsRead: AsyncError(e, StackTrace.current));
    }
  }

  //group
  Future<void> contactService({
    required String name,
    required String email,
    required String message,
  }) async {
    final auth = ref.read(authServiceProvider);
    try {
      state = state.copyWith(
        contactService: const AsyncLoading(),
      );
      final response =
          await auth.contactService(name: name, email: email, message: message);
      state = state.copyWith(contactService: AsyncData(response));
    } catch (e) {
      state = state.copyWith(contactService: AsyncError(e, StackTrace.current));
    }
  }

  Future<void> patchMotificationSettings({
    required bool loginAlert,
    required bool passwordChanges,
    required bool newGroupCreation,
    required bool groupInvitation,
    required bool groupMessages,
    required bool subscriptionUpdates,
    required bool paymentReminders,
    required bool renewalAlerts,
  }) async {
    final auth = ref.read(authServiceProvider);
    try {
      state = state.copyWith(
        motificationSettings: const AsyncLoading(),
      );
      final response = await auth.patchNotificationSettings(
          loginAlert: loginAlert,
          passwordChanges: passwordChanges,
          newGroupCreation: newGroupCreation,
          groupInvitation: groupInvitation,
          groupMessages: groupMessages,
          subscriptionUpdates: subscriptionUpdates,
          paymentReminders: paymentReminders,
          renewalAlerts: renewalAlerts);
      state = state.copyWith(motificationSettings: AsyncData(response));
    } catch (e) {
      state = state.copyWith(
          motificationSettings: AsyncError(e, StackTrace.current));
    }
  }
}

final profileProvider =
    AutoDisposeNotifierProvider<AuthServiceProvider, AuthServiceProviderStates>(
        AuthServiceProvider.new);

//  AutoDisposeNotifierProvider
class AuthServiceProviderStates {
  // final AsyncValue<UserModel?> user;
  // final AsyncValue<UserProfile?> profileUpdater;
  final AsyncValue<GeneralResponseModel?> generalrespond;
  final AsyncValue<GeneralResponseModel?> deleteAccount;
  final AsyncValue<GeneralResponseModel?> otp;
  final AsyncValue<GeneralResponseModel?> resendOtp;
  final AsyncValue<GeneralResponseModel?> login;
  final AsyncValue<GeneralResponseModel?> resetPassword;
  final AsyncValue<GeneralResponseModel?> confirmReSetPassword;
  final AsyncValue<GeneralResponseModel?> changePassword;
  final AsyncValue<GeneralResponseModel?> logout;
  final AsyncValue<GeneralResponseModel?> leaveGroup;
  final AsyncValue<GeneralResponseModel?> updateAvater;
  final AsyncValue<GeneralResponseModel?> updateUserNameAndEmail;
  final AsyncValue<GeneralResponseModel?> changeProfilePassword;
  final AsyncValue<GeneralResponseModel?> checkTokenstatus;
  final AsyncValue<GeneralResponseModel?> contactService;
  final AsyncValue<GeneralResponseModel?> motificationSettings;
  final AsyncValue<GeneralResponseModel?> joinGroup;
  final AsyncValue<GeneralResponseModel?> getGroupbyCode;
  final AsyncValue<bool?> isTokenValid;
  final AsyncValue<GeneralResponseModel?> createGroup;
  final AsyncValue<GeneralResponseModel?> postBankDetails;
  final AsyncValue<SingleServiceResponsModel?> getServiceById;
  final AsyncValue<SubscriptionResponseModel?> getListInactiveSub;
  final AsyncValue<AvaterResponseModel?> getAllAvater;
  final AsyncValue<String?> getToken;
  final AsyncValue<String?> getUserId;
  final AsyncValue<GeneralResponseModel?> acceptOrRejectInviteGroup;
  final AsyncValue<GeneralResponseModel?> updateSubsriptionCost;
  final AsyncValue<GeneralResponseModel?> updateActivateGroup;
  final AsyncValue<GeneralResponseModel?> updateConfirmStatus;
  final AsyncValue<GeneralResponseModel?> markGroupAsRead;

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
    required this.getListInactiveSub,
    required this.updateAvater,
    required this.updateUserNameAndEmail,
    required this.getAllAvater,
    required this.changeProfilePassword,
    required this.checkTokenstatus,
    required this.postBankDetails,
    required this.getServiceById,
    required this.createGroup,
    required this.contactService,
    required this.motificationSettings,
    required this.deleteAccount,
    required this.leaveGroup,
    required this.acceptOrRejectInviteGroup,
    required this.joinGroup,
    required this.getGroupbyCode,
    required this.getUserId,
    required this.updateSubsriptionCost,
    required this.updateActivateGroup,
    required this.updateConfirmStatus,
    required this.markGroupAsRead,

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
    AsyncValue<GeneralResponseModel?>? postBankDetails,
    AsyncValue<GeneralResponseModel?>? contactService,
    AsyncValue<GeneralResponseModel?>? acceptOrRejectInviteGroup,
    AsyncValue<GeneralResponseModel?>? createGroup,
    AsyncValue<SubscriptionResponseModel?>? getListInactiveSub,
    AsyncValue<AvaterResponseModel?>? getAllAvater,
    AsyncValue<SingleServiceResponsModel?>? getServiceById,
    AsyncValue<GeneralResponseModel?>? motificationSettings,
    AsyncValue<GeneralResponseModel?>? deleteAccount,
    AsyncValue<GeneralResponseModel?>? leaveGroup,
    AsyncValue<GeneralResponseModel?>? joinGroup,
    AsyncValue<GeneralResponseModel?>? getGroupbyCode,
    AsyncValue<GeneralResponseModel?>? updateSubsriptionCost,
    AsyncValue<GeneralResponseModel?>? updateActivateGroup,
    AsyncValue<GeneralResponseModel?>? updateConfirmStatus,
    AsyncValue<GeneralResponseModel?>? markGroupAsRead,
    // AsyncValue<NotificationModel?>? notificationFetch,
    // AsyncValue<SubscriptionModel?>? fetchSubcription,

    //   AsyncValue<SubscriptionModel?>? fetchSubcriptionbyUserId,

    AsyncValue<String?>? getToken,
    AsyncValue<String?>? getUserId,
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
      getListInactiveSub: getListInactiveSub ?? this.getListInactiveSub,
      updateAvater: updateAvater ?? this.updateAvater,
      updateUserNameAndEmail:
          updateUserNameAndEmail ?? this.updateUserNameAndEmail,
      getAllAvater: getAllAvater ?? this.getAllAvater,
      changeProfilePassword:
          changeProfilePassword ?? this.changeProfilePassword,
      checkTokenstatus: checkTokenstatus ?? this.checkTokenstatus,
      postBankDetails: postBankDetails ?? this.postBankDetails,
      getServiceById: getServiceById ?? this.getServiceById,
      createGroup: createGroup ?? this.createGroup,
      contactService: contactService ?? this.contactService,
      motificationSettings: motificationSettings ?? this.motificationSettings,
      deleteAccount: deleteAccount ?? this.deleteAccount,
      leaveGroup: leaveGroup ?? this.leaveGroup,
      acceptOrRejectInviteGroup:
          acceptOrRejectInviteGroup ?? this.acceptOrRejectInviteGroup,
      joinGroup: joinGroup ?? this.joinGroup,
      getGroupbyCode: getGroupbyCode ?? this.getGroupbyCode,
      getUserId: getUserId ?? this.getUserId,
      updateSubsriptionCost:
          updateSubsriptionCost ?? this.updateSubsriptionCost,
      updateActivateGroup: updateActivateGroup ?? this.updateActivateGroup,
      updateConfirmStatus: updateConfirmStatus ?? this.updateConfirmStatus,
      markGroupAsRead: markGroupAsRead ?? this.markGroupAsRead,

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
