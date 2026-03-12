import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dr_oplawrence_bible/core/route/route_name.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../data/sources/remote/auth_api_services.dart';
import '../../../../../core/network/api_clients.dart';
import '../viewmodel/login_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final AuthApiServices authService = AuthApiServices(apiClient: ApiClient());

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter email and password")),
      );
      return;
    }

    ref.read(isLoadingProvider.notifier).state = false;

    try {
      final res = await authService.login(email: email, password: password);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(res.message)),
        );
        if(res.isSuccess){
           Navigator.pushNamedAndRemoveUntil(
          context,
          RouteNames.parentScreen,
          (route) => false,
        );

        }

    
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      ref.read(isLoadingProvider.notifier).state = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final _obscureText = ref.watch(obscureTextProvider);
    final _isLoading = ref.watch(isLoadingProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F2),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding:  EdgeInsets.symmetric(horizontal: 24.0.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    'assets/icons/login_icons.png',
                    height: 120.h,
                    errorBuilder: (context, error, stackTrace) =>  Icon(
                      Icons.menu_book,
                      size: 100,
                      color: Colors.orange,
                    ),
                  ),
                ),
                 SizedBox(height: 20.h),
                 Center(
                  child: Text(
                    'Hi, Welcome Back!',
                    style: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Serif',
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                ),
                 SizedBox(height: 40.h),
                 Text(
                  "Email",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
                ),
                 SizedBox(height: 8.h),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "example@gmail.com",
                    hintStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.transparent,
                    contentPadding:  EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 16.h,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                 SizedBox(height: 20.h),
                 Text(
                  "Password",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
                ),
                 SizedBox(height: 8.h),
                TextFormField(
                  controller: passwordController,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    hintText: "enter your password",
                    hintStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.transparent,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                      onPressed: () {
                        ref.read(obscureTextProvider.notifier).state =
                            !_obscureText;
                      },
                    ),
                    contentPadding:  EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 16.h,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                 SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 24.h,
                          width: 24.w,
                          child: Checkbox(
                            // Watch the current value of the checkbox
                            value: ref.watch(rememberMeProvider),
                            activeColor: const Color(0xFF1E3A8A),
                            onChanged: (value) {
                              if (value != null) {
                                // Update the provider state when tapped
                                ref.read(rememberMeProvider.notifier).state =
                                    value;
                              }
                            },
                          ),
                        ),
                         SizedBox(width: 8.w),
                        const Text(
                          "Remember Me",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, RouteNames.forgotPass),
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: Color(0xFFF43F5E),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                 SizedBox(height: 30.h),
                ElevatedButton(
                  onPressed: _isLoading ? null : login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E3A8A),
                    foregroundColor: Colors.white,
                    minimumSize:  Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    elevation: 0,
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      :  Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
                 SizedBox(height: 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Text(
                      "Don’t have an account? ",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushNamedAndRemoveUntil(
                        context,
                        RouteNames.signUpScreen,
                        (route) => false,
                      ),
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Color(0xFF1E3A8A),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                 SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
