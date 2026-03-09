import 'package:dr_oplawrence_bible/core/network/api_clients.dart';
import 'package:dr_oplawrence_bible/core/network/api_endpoints.dart';

import '../../models/response_model.dart';
import '../local/shared_preference/shared_preference.dart';

class AuthApiServices {
  final ApiClient apiClient;
  AuthApiServices({required this.apiClient});

  // ================= Signup =================
  Future<dynamic> signup({
    required String name,
    required String email,
    required String password,
    String type = "user",
  }) async {
    final body = {
      "name": name,
      "email": email,
      "password": password,
      "type": type,
    };
    return await ApiClient.postRequest(
      endpoints: ApiEndpoints.users,
      body: body,
    );
  }

  // ================= Verify OTP =================
  Future<dynamic> verifyOtp({
    required String email,
    required String token,
  }) async {
    final body = {"email": email, "token": token};
    return await ApiClient.postRequest(
      endpoints: ApiEndpoints.verifyemail,
      body: body,
    );
  }

  // ================= Login =================
  Future<ResponseModel> login({
    required String email,
    required String password,
  }) async {
    final body = {"email": email, "password": password};
    var response = await ApiClient.postRequest(
      endpoints: ApiEndpoints.login,
      body: body,
    );
    if (response['success']) {
      var token = response['authorization']['access_token'];

      await SharedPreferenceData().setToken(token);
      ApiClient.headerSet(token);
      return ResponseModel(isSuccess: true, message:response['message'] );
    }else{
       return ResponseModel(isSuccess: false, message:response['message'] );

    }
  }

  // ================= Forgot Password =================
  Future<dynamic> forgotPassword({required String email}) async {
    final body = {"email": email};
    return await ApiClient.postRequest(
      endpoints: ApiEndpoints.forgetPassword,
      body: body,
    );
  }

  // ================= Reset Password =================
  Future<dynamic> resetPassword({
    required String email,
    required String token,
    required String password,
  }) async {
    final body = {"email": email, "token": token, "password": password};
    return await ApiClient.postRequest(
      endpoints: ApiEndpoints.resetPassword,
      body: body,
    );
  }
}
