import 'package:dr_oplawrence_bible/data/sources/local/shared_preference/shared_preference.dart';
import '../sources/remote/auth_api_services.dart';

class AuthRepository {
  final AuthApiServices apiService;
  AuthRepository({required this.apiService});

  // ================= Signup =================
  Future<dynamic> signup({
    required String name,
    required String email,
    required String password,
    String type = "user",
  }) async {
    return await apiService.signup(
      name: name,
      email: email,
      password: password,
      type: type,
    );
  }

  // ================= Verify OTP =================
  Future<dynamic> verifyOtp({
    required String email,
    required String token,
  }) async {
    return await apiService.verifyOtp(email: email, token: token);
  }

  // ================= Login =================
  Future<dynamic> login({
    required String email,
    required String password,
    bool rememberMe = false,
  }) async {
    final res = await apiService.login(email: email, password: password);

    // Only save token/email if rememberMe is true
    if (res != null && res['success'] == true && rememberMe) {
      final token = res['token'];
      await SharedPreferenceData().setToken(token);
      await SharedPreferenceData().setEmailId(email);
    }

    return res;
  }

  // ================= Forgot Password =================
  Future<dynamic> forgotPassword({required String email}) async {
    return await apiService.forgotPassword(email: email);
  }

  // ================= Reset Password =================
  Future<dynamic> resetPassword({
    required String email,
    required String token,
    required String password,
  }) async {
    return await apiService.resetPassword(
      email: email,
      token: token,
      password: password,
    );
  }
}