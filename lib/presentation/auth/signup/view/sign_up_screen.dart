import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/route/route_name.dart';
import '../viewmodel/signup_auth_riverpod.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    numberController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isPasswordVisible = ref.watch(passwordVisibilityProvider);
    final signUpState = ref.watch(signUpStateProvider);
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding:  EdgeInsets.all(32.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               SizedBox(height: 60.h),
              Image.asset('assets/images/sign_up_icon.png', scale: 4),
               SizedBox(height: 25.h),

              /// NAME
              TextFormField(
                controller: nameController,
                decoration: _inputDecoration('enter your name'),
                keyboardType: TextInputType.name,
              ),

               SizedBox(height: 12.h),

              /// EMAIL
              TextFormField(
                controller: emailController,
                decoration: _inputDecoration('example@gmail.com'),
                keyboardType: TextInputType.emailAddress,
              ),

               SizedBox(height: 12.h),

              /// PHONE
              TextFormField(
                controller: numberController,
                decoration: _inputDecoration('enter your phone number'),
                keyboardType: TextInputType.phone,
              ),

               SizedBox(height: 12.h),

              /// PASSWORD
              TextFormField(
                controller: passwordController,
                obscureText: !isPasswordVisible,
                decoration: _inputDecoration(
                  'enter your password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      final notifier = ref.read(
                        passwordVisibilityProvider.notifier,
                      );
                      notifier.state = !notifier.state;
                    },
                  ),
                ),
              ),

               SizedBox(height: 30.h),

              /// SIGN UP BUTTON
              ElevatedButton(
                onPressed: signUpState.isLoading
                    ? null
                    : () async {
                        final authRepo = ref.read(authRepositoryProvider);

                        // Start loading
                        ref.read(signUpStateProvider.notifier).setLoading(true);

                        try {
                          final result = await authRepo.signup(
                            name: nameController.text.trim(),
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                            type: "user",
                          );

                          print("Signup result: $result"); // for debugging

                          //  Check 'success' key instead of 'statusCode'
                          if (result['success'] == true) {
                            if (!context.mounted) return;

                            Navigator.pushNamed(
                              context,
                              RouteNames.signupOtpScreen,
                              arguments: emailController.text.trim(),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  result['message'] ?? "Signup failed",
                                ),
                              ),
                            );
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text("Error: $e")));
                        } finally {
                          // Stop loading
                          ref
                              .read(signUpStateProvider.notifier)
                              .setLoading(false);
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E3A8A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0.r),
                  ),
                  padding:  EdgeInsets.symmetric(vertical: 16.h),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: signUpState.isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    :  Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
              SizedBox(height: 100.h),

              /// LOGIN NAVIGATION
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(fontSize: 16.sp, color: Colors.black54),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RouteNames.loginScreen);
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: const Color(0xff0D5593),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///  reusable decoration (clean code)
  InputDecoration _inputDecoration(String hint, {Widget? suffixIcon}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(fontSize: 15.sp, color: Colors.grey.shade500),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0.r),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0.r),
        borderSide: const BorderSide(color: Colors.blue, width: 2.0),
      ),
      contentPadding:  EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      fillColor: Colors.white,
      filled: true,
      suffixIcon: suffixIcon,
    );
  }
}
