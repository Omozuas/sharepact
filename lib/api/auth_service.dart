import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharepact_app/api/api_service.dart';
import 'package:sharepact_app/api/model/categories/listOfCategories.dart';
import 'package:sharepact_app/api/model/general_respons_model.dart';
import 'package:sharepact_app/api/model/subscription/subscription_model.dart';
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
  Future<UserModel> getUser() async {
    final token = await getToken();
    try {
      final response = await apiService.get(
        token: token,
        endpoint: Config.getUserEndpoint,
      );

      return UserModel.fromJson(response?.data);
    } catch (e) {
      rethrow;
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
      if (response?.data != null && response?.data.isNotEmpty) {
        List<dynamic> usersJson = response!.data;
        List<CategoriesModel> categories =
            usersJson.map((e) => CategoriesModel.fromJson(e)).toList();
        return categories;
      } else {
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }

  ///subscription flow
  Future<List<SubscriptionModel>> getListActiveSub() async {
    final token = await getToken();
    try {
      final response = await apiService.get(
        token: token,
        endpoint: Config.getActiveSubscriptionsEndpoint,
      );

      // Check if data is not null and is not empty
      if (response?.data != null && response?.data.isNotEmpty) {
        List<dynamic> usersJson = response?.data;
        List<SubscriptionModel> subscription =
            usersJson.map((json) => SubscriptionModel.fromJson(json)).toList();
        return subscription;
      } else {
        // Handle empty or null response data
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<SubscriptionModel>> getListInActiveSub() async {
    final token = await getToken();
    try {
      final response = await apiService.get(
        token: token,
        endpoint: Config.getCategoriesEndpoint,
      );
      List<dynamic> usersJson = response!.data;
      List<SubscriptionModel> subscription =
          usersJson.map((e) => SubscriptionModel.fromJson(e)).toList();
      return subscription;
    } catch (e) {
      rethrow;
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
      return !JwtDecoder.isExpired(token);
    }
  }

  Future<String> getToken() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString('token') ?? '';
  }
}

final authServiceProvider = Provider<AuthService>((ref) => AuthService(ref));
