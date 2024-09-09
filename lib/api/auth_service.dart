import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharepact_app/api/api_service.dart';
import 'package:sharepact_app/api/model/bank/bank_model.dart';
import 'package:sharepact_app/api/model/bank/getBank_model.dart';
import 'package:sharepact_app/api/model/categories/categoryByid.dart';
import 'package:sharepact_app/api/model/categories/listOfCategories.dart';
import 'package:sharepact_app/api/model/general_respons_model.dart';
import 'package:sharepact_app/api/model/groupDetails/groupdetails.dart';
import 'package:sharepact_app/api/model/groupDetails/joinRequest.dart';
import 'package:sharepact_app/api/model/list_of_groups/list_of_groups.dart';
import 'package:sharepact_app/api/model/newmodel.dart';
import 'package:sharepact_app/api/model/notification-model/notification-moddel.dart';
import 'package:sharepact_app/api/model/notificationmodel.dart';
import 'package:sharepact_app/api/model/servicemodel/servicemodel.dart';
import 'package:sharepact_app/api/model/subscription/subscription_model.dart';
import 'package:sharepact_app/api/model/user/listOfAvaterUrl.dart';
import 'package:sharepact_app/api/model/user/user_model.dart';
import '../config.dart';

class AuthService {
  ApiService apiService = ApiService(baseUrl: Config.baseUrl);

  AuthService(this.ref);
  final Ref ref;
  //Authflow

  Future<GeneralResponseModel> signup(
      {required String email, required String password}) async {
    try {
      final response = await apiService.post(
        endpoint: Config.signupEndpoint,
        body: {'email': email, 'password': password},
      );

      return response!;
    } catch (e) {
      rethrow;
    }
  }

  Future<GeneralResponseModel> confirmOtp(
      {required String email, required String code}) async {
    try {
      final response = await apiService.post(
        endpoint: Config.verifyOtpEndpoint,
        body: {'email': email, 'code': code},
      );

      return response!;
    } catch (e) {
      rethrow;
    }
  }

  Future<GeneralResponseModel> resendOtp({required String email}) async {
    try {
      final response = await apiService.post(
        endpoint: Config.resendOtpEndpoint,
        body: {'email': email},
      );

      return response!;
    } catch (e) {
      rethrow;
    }
  }

  Future<GeneralResponseModel> signin(
      {required String email, required String password}) async {
    try {
      final response = await apiService.post(
        endpoint: Config.signinEndpoint,
        body: {'email': email, 'password': password},
      );
      saveToken(response);
      return response!;
    } catch (e) {
      rethrow;
    }
  }

  Future<GeneralResponseModel> reSetPassword({required String email}) async {
    try {
      final response = await apiService.post(
        endpoint: Config.reSetPasswordEndpoint,
        body: {'email': email},
      );
      return response!;
    } catch (e) {
      rethrow;
    }
  }

  Future<GeneralResponseModel> confirmReSetPassword(
      {required String email, required String code}) async {
    try {
      final response = await apiService.post(
        endpoint: Config.confirmreSetPasswordEndpoint,
        body: {'email': email, 'code': code},
      );
      return response!;
    } catch (e) {
      rethrow;
    }
  }

  Future<GeneralResponseModel> changePassword(
      {required String email,
      required String code,
      required String password}) async {
    try {
      final response = await apiService.patch(
        endpoint: Config.changePasswordEndpoint,
        body: {"email": email, "code": code, "password": password},
      );
      return response!;
    } catch (e) {
      rethrow;
    }
  }

  Future<GeneralResponseModel> logout({required String token}) async {
    try {
      final response = await apiService.post2(
        token: token,
        endpoint: Config.logoutEndpoint,
      );
      return response!;
    } catch (e) {
      rethrow;
    }
  }

  Future<GeneralResponseModel> changeProfilePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final token = await getToken();
    try {
      final response = await apiService.put(
        endpoint: Config.changeProfilePasswordEndpoint,
        token: token,
        body: {"currentPassword": currentPassword, "newPassword": newPassword},
      );
      return response!;
    } catch (e) {
      rethrow;
    }
  }

  Future<GeneralResponseModel> validateInterntToken(
      {required String token}) async {
    try {
      final response = await apiService.get(
        token: token,
        endpoint: Config.verifyTokenEndpoint,
      );
      return generalResponseModelFromJson(response.body);
    } on TimeoutException catch (_) {
      print('Request timeout');
      return GeneralResponseModel(
          code: 408, message: 'Request Timeout', data: null);
    } on SocketException catch (_) {
      print('No Internet connection');
      return GeneralResponseModel(
          code: 503, message: 'No Internet connection', data: null);
    } catch (e) {
      print('Error: $e');
      return GeneralResponseModel(
          code: 500, message: 'Something went wrong', data: null);
    }
  }

//user flow
  Future<UserModel> getUser() async {
    final token = await getToken();
    try {
      final response = await apiService.get(
        token: token,
        endpoint: Config.getUserEndpoint,
      );

      final body = jsonDecode(response.body);
      return UserModel.fromJson(body['data']);
    } on TimeoutException catch (_) {
      print('Request timeout');
      throw UserResponseModel(
          code: 408, message: 'Request Timeout', data: null);
    } on SocketException catch (_) {
      print('No Internet connection');
      throw UserResponseModel(
          code: 503, message: 'No Internet connection', data: null);
    } catch (e) {
      print('Error: $e');
      throw UserResponseModel(
          code: 500, message: 'Something went wrong', data: null);
    }
  }

  Future<GeneralResponseModel> updateAvater({required String avaterurl}) async {
    final token = await getToken();
    try {
      final response = await apiService.put(
          token: token,
          endpoint: Config.updateAvaterEndpoint,
          body: {"avatarUrl": avaterurl});

      return response!;
    } catch (e) {
      rethrow;
    }
  }

  Future<GeneralResponseModel> updateUserNameAndEmailr(
      {required String userName, required String email}) async {
    final token = await getToken();
    try {
      final response = await apiService.put(
          token: token,
          endpoint: Config.updateUserName,
          body: {"username": userName, "email": email});

      return response!;
    } catch (e) {
      rethrow;
    }
  }

  Future<AvaterResponseModel> getAllAvater() async {
    final token = await getToken();
    try {
      final response = await apiService.get(
        token: token,
        endpoint: Config.getAllAvaters,
      );

      return avaterResponseModelFromJson(response.body);
    } on TimeoutException catch (_) {
      print('Request timeout');
      return AvaterResponseModel(
          code: 408, message: 'Request Timeout', data: null);
    } on SocketException catch (_) {
      print('No Internet connection');
      return AvaterResponseModel(
          code: 503, message: 'No Internet connection', data: null);
    } catch (e) {
      print('Error: $e');
      return AvaterResponseModel(
          code: 500, message: 'Something went wrong', data: null);
    }
  }

  Future<GeneralResponseModel> deletAccount() async {
    final token = await getToken();
    try {
      final response = await apiService.delete(
        token: token,
        endpoint: Config.deleteAccount,
      );
      return response!;
    } on TimeoutException catch (_) {
      print('Request timeout');
      return GeneralResponseModel(
          code: 408, message: 'Request Timeout', data: null);
    } on SocketException catch (_) {
      print('No Internet connection');
      return GeneralResponseModel(
          code: 503, message: 'No Internet connection', data: null);
    } catch (e) {
      print('Error: $e');
      return GeneralResponseModel(
          code: 500, message: 'Something went wrong', data: null);
    }
  }

  ///category flow
  Future<List<CategoriesModel>> getListCategories() async {
    final token = await getToken();
    try {
      final response = await apiService.get(
        token: token,
        endpoint: Config.getCategoriesEndpoint,
      );
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        if (body != null) {
          final category = List<CategoriesModel>.from(
              body['data'].map((x) => CategoriesModel.fromJson(x)));
          return category;
        }

        return [];
      }
      throw CustomException(code: response.statusCode, message: 'err');
    } on TimeoutException catch (_) {
      print('Request timeout');
      throw CategoriesResponseModel(
          code: 408, message: 'Request Timeout', data: null);
    } on SocketException catch (_) {
      print('No Internet connection');
      throw CategoriesResponseModel(
          code: 503, message: 'No Internet connection', data: null);
    } catch (e) {
      print('Error: $e');
      throw CategoriesResponseModel(
          code: 500, message: 'Something went wrong', data: null);
    }
  }

  Future<CategorybyidResponsModel> getCategoriesById(
      {required String id}) async {
    final token = await getToken();
    try {
      final response = await apiService.get(
        token: token,
        endpoint: '${Config.getCategoriesByIdEndpoint}$id',
      );
      var message = jsonDecode(response.body);
      print(message['data']);
      if (response.statusCode == 200) {
        return categorybyidResponsModelFromJson(response.body);
      }

      return CategorybyidResponsModel(
          code: response.statusCode, message: message['message']);
    } on TimeoutException catch (_) {
      print('Request timeout');
      return CategorybyidResponsModel(
        code: 408,
        message: 'Request Timeout',
      );
    } on SocketException catch (_) {
      print('No Internet connection');
      return CategorybyidResponsModel(
        code: 503,
        message: 'No Internet connection',
      );
    } catch (e) {
      print('Error: $e');
      return CategorybyidResponsModel(
        code: 500,
        message: 'Something went wrong',
      );
    }
  }

  ///subscription flow
  Future<List<SubscriptionModel>> getListActiveSub(
      {String? page, String? limit}) async {
    final token = await getToken();
    try {
      final response = await apiService.get(
        token: token,
        endpoint:
            '${Config.getActiveSubscriptionsEndpoint}&page=$page&limit=$limit',
      );
      print(response.body);
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        if (body != null) {
          final sub = List<SubscriptionModel>.from(
              body['data'].map((x) => SubscriptionModel.fromJson(x)));
          return sub;
        }

        return [];
      }
      throw CustomException(code: response.statusCode, message: 'err');
    } on TimeoutException catch (_) {
      print('Request timeout');
      throw UserResponseModel(
          code: 408, message: 'Request Timeout', data: null);
    } on SocketException catch (_) {
      print('No Internet connection');
      throw UserResponseModel(
          code: 503, message: 'No Internet connection', data: null);
    } catch (e) {
      print('Error: $e');
      throw UserResponseModel(
          code: 500, message: 'Something went wrong', data: null);
    }
  }

  Future<SubscriptionResponseModel> getListInActiveSub() async {
    final token = await getToken();
    try {
      final response = await apiService.get(
        token: token,
        endpoint: Config.getCategoriesEndpoint,
      );
      return subscriptionResponseModelFromJson(response.body);
    } on TimeoutException catch (_) {
      print('Request timeout');
      return SubscriptionResponseModel(
          code: 408, message: 'Request Timeout', data: null);
    } on SocketException catch (_) {
      print('No Internet connection');
      return SubscriptionResponseModel(
          code: 503, message: 'No Internet connection', data: null);
    } catch (e) {
      print('Error: $e');
      return SubscriptionResponseModel(
          code: 500, message: 'Something went wrong', data: null);
    }
  }

  //bank flow
  Future<BankResponseModel> getBankById() async {
    final token = await getToken();
    final userId = await getuserId();
    try {
      final response = await apiService.get(
        token: token,
        endpoint: Config.getBankEndpoint + userId,
      );
      final body = jsonDecode(response.body);
      print({'auth': body});
      return bankResponseModelFromJson(response.body);
    } on TimeoutException catch (_) {
      print('Request timeout');
      return BankResponseModel(
          code: 408, message: 'Request Timeout', data: null);
    } on SocketException catch (_) {
      print('No Internet connection');
      final Map<String, dynamic> body = {
        "code": 503,
        "message": "No Internet connection",
        "data": null
      };
      return BankResponseModel.fromJson(body);
    } catch (e) {
      print('Error: $e');
      return BankResponseModel(
          code: 500, message: 'Something went wrong', data: null);
    }
  }

  Future<GeneralResponseModel> postBankDetails(
      {required String accountName,
      required String bankName,
      required String accountNumber,
      required String sortCode}) async {
    final token = await getToken();
    try {
      final response = await apiService.post(
          endpoint: Config.postBankEndpoint,
          body: {
            "accountName": accountName,
            "bankName": bankName,
            "accountNumber": accountNumber,
            "sortCode": sortCode
          },
          token: token);

      return response!;
    } catch (e) {
      rethrow;
    }
  }

  Future<GetAllBanks> getAllBanks() async {
    try {
      final response = await apiService.get(
        endpoint: Config.getAllBankEndpoint,
      );

      return getAllBanksFromJson(response.body);
    } on TimeoutException catch (_) {
      print('Request timeout');
      return GetAllBanks(code: 408, message: 'Request Timeout', data: null);
    } on SocketException catch (_) {
      print('No Internet connection');
      final Map<String, dynamic> body = {
        "code": 503,
        "message": "No Internet connection",
        "data": null
      };
      return GetAllBanks.fromJson(body);
    } catch (e) {
      print('Error: $e');
      return GetAllBanks(
          code: 500, message: 'Something went wrong', data: null);
    }
  }

  //service flow
  Future<SingleServiceResponsModel> getServiceById({required String id}) async {
    final token = await getToken();
    try {
      final response = await apiService.get(
        token: token,
        endpoint: '${Config.getServiceByIdEndpoint}$id',
      );
      var message = jsonDecode(response.body);
      print(message['data']);
      if (response.statusCode == 200) {
        return singleServiceResponsModelFromJson(response.body);
      }

      return SingleServiceResponsModel(
          code: response.statusCode, message: message['message']);
    } on TimeoutException catch (_) {
      print('Request timeout');
      return SingleServiceResponsModel(
        code: 408,
        message: 'Request Timeout',
      );
    } on SocketException catch (_) {
      print('No Internet connection');
      return SingleServiceResponsModel(
        code: 503,
        message: 'No Internet connection',
      );
    } catch (e) {
      print('Error: $e');
      return SingleServiceResponsModel(
        code: 500,
        message: 'Something went wrong',
      );
    }
  }

//group
  Future<GeneralResponseModel> createGroup(
      {required String serviceId,
      required String groupName,
      required int numberOfMembers,
      required bool existingGroup,
      required int subscriptionCost,
      required bool oneTimePayment}) async {
    final token = await getToken();
    try {
      final response = await apiService
          .post(token: token, endpoint: Config.createGroupEndpoint, body: {
        "serviceId": serviceId,
        "groupName": groupName,
        "subscriptionCost": subscriptionCost,
        "numberOfMembers": numberOfMembers,
        "existingGroup": existingGroup,
        "oneTimePayment": existingGroup
      });

      return response!;
    } catch (e) {
      rethrow;
    }
  }

  /// contact service
  Future<GeneralResponseModel> contactService({
    required String name,
    required String email,
    required String message,
  }) async {
    final token = await getToken();
    try {
      final response = await apiService.post(
          token: token,
          endpoint: Config.contactSupportEndpoint,
          body: {"name": name, "email": email, "message": message});

      return response!;
    } catch (e) {
      rethrow;
    }
  }

  //notification settings
  Future<GeneralResponseModel> patchNotificationSettings({
    required bool loginAlert,
    required bool passwordChanges,
    required bool newGroupCreation,
    required bool groupInvitation,
    required bool groupMessages,
    required bool subscriptionUpdates,
    required bool paymentReminders,
    required bool renewalAlerts,
  }) async {
    final token = await getToken();
    try {
      final response = await apiService.patch(
          token: token,
          endpoint: Config.patchNotificationSettingEndpoint,
          body: {
            "loginAlert": loginAlert,
            "passwordChanges": passwordChanges,
            "newGroupCreation": newGroupCreation,
            "groupInvitation": groupInvitation,
            "groupMessages": groupMessages,
            "subscriptionUpdates": subscriptionUpdates,
            "paymentReminders": paymentReminders,
            "renewalAlerts": renewalAlerts
          });

      return response!;
    } catch (e) {
      rethrow;
    }
  }

  Future<NotificationConfigResponse> getNotificationConfig() async {
    final token = await getToken();
    try {
      final response = await apiService.get(
        token: token,
        endpoint: Config.getNotificationSettingEndpoint,
      );
      final body = jsonDecode(response.body);
      print({'auth': body});
      return notificationConfigResponseFromJson(response.body);
    } on TimeoutException catch (_) {
      print('Request timeout');
      return NotificationConfigResponse(
          code: 408, message: 'Request Timeout', data: null);
    } on SocketException catch (_) {
      final Map<String, dynamic> body = {
        "code": 503,
        "message": "No Internet connection",
        "data": null
      };
      print('No Internet connection');
      return NotificationConfigResponse.fromJson(body);
    } catch (e) {
      print('Error: $e');
      return NotificationConfigResponse(
          code: 500, message: 'Something went wrong', data: null);
    }
  }

  Future<NotificationModdel> getNotifications({required int limit}) async {
    final token = await getToken();
    try {
      final response = await apiService.get(
        token: token,
        endpoint: '${Config.getNotificationsEndpoint}&page=1&limit=$limit',
      );
      final body = jsonDecode(response.body);
      print({'auth': body});
      return notificationModdelFromJson(response.body);
    } on TimeoutException catch (_) {
      print('Request timeout');
      return NotificationModdel(
          code: 408, message: 'Request Timeout', data: null);
    } on SocketException catch (_) {
      final Map<String, dynamic> body = {
        "code": 503,
        "message": "No Internet connection",
        "data": null
      };
      print('No Internet connection');
      return NotificationModdel.fromJson(body);
    } catch (e) {
      print('Error: $e');
      return NotificationModdel(
          code: 500, message: 'Something went wrong', data: null);
    }
  }

  Future<GeneralResponseModel> markNotifications(
      {required List<String> id}) async {
    final token = await getToken();
    try {
      final response = await apiService.patch(
          token: token,
          endpoint: Config.markNotificationsEndpoint,
          body: {"ids": id});

      return response!;
    } catch (e) {
      rethrow;
    }
  }

//groupdeails
  Future<GroupdetailsResponse> getGroupDetailsById({required String id}) async {
    final token = await getToken();
    try {
      final response = await apiService.get(
          endpoint: Config.getGroupDetailsEndpoint + id, token: token);

      return groupdetailsResponseFromJson(response.body);
    } on TimeoutException catch (_) {
      print('Request timeout');
      return GroupdetailsResponse(
          code: 408, message: 'Request Timeout', data: null);
    } on SocketException catch (_) {
      print('No Internet connection');
      final Map<String, dynamic> body = {
        "code": 503,
        "message": "No Internet connection",
        "data": null
      };
      return GroupdetailsResponse.fromJson(body);
    } catch (e) {
      print('Error: $e');
      return GroupdetailsResponse(
          code: 500, message: 'Something went wrong', data: null);
    }
  }

  Future<GroupJoinRequestResponse> getGroupJoinRequestById(
      {required String id}) async {
    final token = await getToken();
    try {
      final response = await apiService.get(
          endpoint: Config.getGroupJiinRequestsEndpoint + id, token: token);

      return groupJoinRequestResponseFromJson(response.body);
    } on TimeoutException catch (_) {
      print('Request timeout');
      return GroupJoinRequestResponse(
          code: 408, message: 'Request Timeout', data: null);
    } on SocketException catch (_) {
      print('No Internet connection');
      final Map<String, dynamic> body = {
        "code": 503,
        "message": "No Internet connection",
        "data": null
      };
      return GroupJoinRequestResponse.fromJson(body);
    } catch (e) {
      print('Error: $e');
      return GroupJoinRequestResponse(
          code: 500, message: 'Something went wrong', data: null);
    }
  }

  Future<GeneralResponseModel> leaveGroup({required String id}) async {
    final token = await getToken();
    try {
      final response = await apiService.post2(
        token: token,
        endpoint: Config.leaveeGroupEndpoint + id,
      );

      return response!;
    } catch (e) {
      rethrow;
    }
  }

  Future<GeneralResponseModel> acceptOrRejectInviteGroup(
      {required String groupId,
      required String userId,
      required bool approve}) async {
    final token = await getToken();

    try {
      final response = await apiService.post(
          token: token,
          endpoint: Config.acceptOrRejectGroupEndpoint,
          body: {"groupId": groupId, "userId": userId, "approve": approve});

      return response!;
    } catch (e) {
      rethrow;
    }
  }

  Future<GeneralResponseModel> joinAGroup(
      {required String groupCode, required String message}) async {
    final token = await getToken();

    try {
      final response = await apiService.post(
          token: token,
          endpoint: Config.joinGroupEndpoint,
          body: {"groupCode": groupCode, "message": message});

      return response!;
    } catch (e) {
      rethrow;
    }
  }

  Future<GeneralResponseModel> getGroupByCode({
    required String groupId,
  }) async {
    final token = await getToken();

    try {
      final response = await apiService.get2(
        token: token,
        endpoint: Config.getGroupByCodeEndpoint + groupId,
      );

      return response!;
    } catch (e) {
      rethrow;
    }
  }

  Future<GroupResponseList> getGroupList({String? page, String? limit}) async {
    final token = await getToken();
    try {
      final response = await apiService.get(
          endpoint: '${Config.groupListEndpoint}?&page=$page&limit=$limit',
          token: token);
      var body = jsonDecode(response.body);
      print(body['data']['groups']);
      return GroupResponseList.fromJson(body);
    } on TimeoutException catch (_) {
      print('Request timeout');
      return GroupResponseList(
          code: 408, message: 'Request Timeout', data: null);
    } on SocketException catch (_) {
      print('No Internet connection');
      final Map<String, dynamic> body = {
        "code": 503,
        "message": "No Internet connection",
        "data": null
      };
      return GroupResponseList.fromJson(body);
    } catch (e, stackTrace) {
      print('Error: $e');
      print('Stack trace: $stackTrace');
      return GroupResponseList(
          code: 500, message: 'Something went wrong', data: null);
    }
  }

  Future<GeneralResponseModel> updateSubscriptionCost(
      {required int newSubscriptionCost, required String id}) async {
    final token = await getToken();

    try {
      final response = await apiService.patch(
          token: token,
          endpoint: Config.updateSubscriptionCostEndpoint + id,
          body: {"newSubscriptionCost": newSubscriptionCost});

      return response!;
    } catch (e) {
      rethrow;
    }
  }

  Future<GeneralResponseModel> updateConfirmStatus({required String id}) async {
    final token = await getToken();

    try {
      final response = await apiService.post2(
        token: token,
        endpoint: '${Config.confirmStatusEndpoint}$id/confirm',
      );

      return response!;
    } catch (e) {
      rethrow;
    }
  }

  Future<GeneralResponseModel> updateActivateGroup({required String id}) async {
    final token = await getToken();

    try {
      final response = await apiService.post2(
        token: token,
        endpoint: Config.activateGroupEndpoint + id,
      );

      return response!;
    } catch (e) {
      rethrow;
    }
  }

  Future<GeneralResponseModel> markGroupasRead(
      {required String groupId, required List<String> messagesid}) async {
    final token = await getToken();

    try {
      final response = await apiService.patch(
          token: token,
          endpoint: Config.markGroupMesagesEndpoint,
          body: {"messageIds": messagesid, "groupId": groupId});

      return response!;
    } catch (e) {
      rethrow;
    }
  }

  void saveToken(GeneralResponseModel? response) async {
    if (response!.data == null) return;
    final preferences = await SharedPreferences.getInstance();
    preferences.setString('token', response.data!["token"]);
    preferences.setString('userID', response.data!['user']['_id']);
    return;
  }

  Future<bool> isTokenValid() async {
    final preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('token');
    if (token == null) {
      return false; // No token stored
    } else {
      return true;
    }
  }

  Future<String> getToken() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString('token') ?? '';
  }

  Future<String> getuserId() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString('userID') ?? '';
  }
}

final authServiceProvider = Provider<AuthService>((ref) => AuthService(ref));
