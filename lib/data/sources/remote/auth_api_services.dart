import 'package:dr_oplawrence_bible/core/network/api_clients.dart';
import 'package:dr_oplawrence_bible/core/network/api_endpoints.dart';

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
  Future<dynamic> login({
    required String email,
    required String password,
  }) async {
    final body = {"email": email, "password": password};
    return await ApiClient.postRequest(
      endpoints: ApiEndpoints.login,
      body: body,
    );
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
