import 'package:dr_oplawrence_bible/core/network/api_clients.dart';
import 'package:dr_oplawrence_bible/core/network/api_endpoints.dart';

class AuthApiServices {
  final ApiClient apiClient;
  AuthApiServices({required this.apiClient});

  // ============ Sign up ===================
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

  // ========== OTP verfity signup ======
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

  Future<dynamic> forgotPassword({required String email}) async {
    return await ApiClient.postRequest(
      endpoints: ApiEndpoints.forgetPassword,
      body: {'email': email},
    );
  }
}
