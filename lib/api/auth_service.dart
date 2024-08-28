import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharepact_app/api/api_service.dart';
import 'package:sharepact_app/api/model/categories/listOfCategories.dart';
import 'package:sharepact_app/api/model/general_respons_model.dart';
import 'package:sharepact_app/api/model/subscription/subscription_model.dart';
import 'package:sharepact_app/api/model/user/listOfAvaterUrl.dart';
import 'package:sharepact_app/api/model/user/user_model.dart';
import '../config.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

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

//user flow
  Future<UserResponseModel> getUser() async {
    final token = await getToken();
    try {
      final response = await apiService.get(
        token: token,
        endpoint: Config.getUserEndpoint,
      );

      return userResponseModelFromJson(response.body);
    } on TimeoutException catch (_) {
      print('Request timeout');
      return UserResponseModel(
          code: 408, message: 'Request Timeout', data: null);
    } on SocketException catch (_) {
      print('No Internet connection');
      return UserResponseModel(
          code: 503, message: 'No Internet connection', data: null);
    } catch (e) {
      print('Error: $e');
      return UserResponseModel(
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

  ///category flow
  Future<CategoriesResponseModel> getListCategories() async {
    final token = await getToken();
    try {
      final response = await apiService.get(
        token: token,
        endpoint: Config.getCategoriesEndpoint,
      );
      return categoriesResponseModelFromJson(response.body);
    } on TimeoutException catch (_) {
      print('Request timeout');
      return CategoriesResponseModel(
          code: 408, message: 'Request Timeout', data: null);
    } on SocketException catch (_) {
      print('No Internet connection');
      return CategoriesResponseModel(
          code: 503, message: 'No Internet connection', data: null);
    } catch (e) {
      print('Error: $e');
      return CategoriesResponseModel(
          code: 500, message: 'Something went wrong', data: null);
    }
  }

  ///subscription flow
  Future<SubscriptionResponseModel> getListActiveSub() async {
    final token = await getToken();
    try {
      final response = await apiService.get(
        token: token,
        endpoint: Config.getActiveSubscriptionsEndpoint,
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
  // Future<GeneralResponseModel> getUser() async {
  //   try {
  //     bool valid = await isTokenValid();
  //     if (!valid) {
  //       // Return an error response or handle it accordingly
  //       throw Exception("Invalid or expired token. Please log in again.");
  //     }
  //     final token = await getToken();
  //     final response = await http.get(
  //       Uri.parse(Config.signinEndpoint),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //     ).timeout(Config.requestTimeout);

  //     if (response.statusCode == 200) {
  //       return generalResponseModelFromJson(response.body);
  //     } else {
  //       final errorResponse = jsonDecode(response.body);
  //       throw Exception(errorResponse['error'] ?? 'Failed to sign in');
  //     }
  //   } catch (e) {
  //     throw Exception('Failed to sign in: $e');
  //   }
  // }

  void saveToken(GeneralResponseModel? response) async {
    if (response!.data == null) return;
    final preferences = await SharedPreferences.getInstance();
    preferences.setString('token', response.data!["token"]);
    return;
  }

  Future<bool> isTokenValid() async {
    final preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('token');

    if (token == null) {
      return false; // No token stored
    } else {
      bool isExpired = JwtDecoder.isExpired(token);
      if (isExpired == true) {
        return false;
      } else {
        return true;
      }
    }
  }

  Future<String> getToken() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString('token') ?? '';
  }
}

final authServiceProvider = Provider<AuthService>((ref) => AuthService(ref));
