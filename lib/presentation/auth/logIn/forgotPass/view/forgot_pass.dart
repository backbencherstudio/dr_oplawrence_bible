import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dr_oplawrence_bible/core/route/route_name.dart';
import '../../../../../../core/network/api_clients.dart';
import '../../../../../../data/sources/remote/auth_api_services.dart';
import '../../viewmodel/login_riverpod.dart';

class ForgotPass extends ConsumerStatefulWidget {
  const ForgotPass({super.key});

  @override
  ConsumerState<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends ConsumerState<ForgotPass> {
  final TextEditingController emailController = TextEditingController();
  final AuthApiServices authService = AuthApiServices(apiClient: ApiClient());

  Future<void> sendResetLink() async {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please enter your email")));
      return;
    }

    ref.read(isLoadingProvider.notifier).state = true;

    try {
      final res = await authService.forgotPassword(email: email);

      if (res != null && res['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Reset link sent to your email")),
        );

        Navigator.pushNamed(
          context,
          RouteNames.otpScreen,
          arguments: {'email': email},
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(res['message'] ?? "Failed to send link")),
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
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _isLoading = ref.watch(isLoadingProvider);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding:  EdgeInsets.all(32.0.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/icons/login_icons.png', scale: 3),
               SizedBox(height: 25.h),
              Text(
                'Forgot Password',
                textAlign: TextAlign.center,
                style: GoogleFonts.merriweather(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff1A1A1A),
                ),
              ),
               SizedBox(height: 8.h),
               Text(
                'Enter your login email details below',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff343434),
                ),
              ),
               SizedBox(height: 40.h),
              Align(
                alignment: Alignment.topLeft,
                child:  Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
               SizedBox(height: 8.h),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'example@gmail.com',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0.r),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0.r),
                    borderSide:  BorderSide(
                      color: Colors.blue,
                      width: 2.0.w,
                    ),
                  ),
                  contentPadding:  EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
                keyboardType: TextInputType.emailAddress,
              ),
               SizedBox(height: 20.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back Button
                  SizedBox(
                    width: 155.w,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0.r),
                          side: const BorderSide(
                            color: Color(0xFF1E3A8A),
                            width: 1,
                          ),
                        ),
                        padding:  EdgeInsets.symmetric(vertical: 16.h),
                        minimumSize:  Size(double.infinity, 50),
                      ),
                      child:  Text(
                        'Back',
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: Color(0xFF1E3A8A),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  // Next Button (Send Reset Link)
                  SizedBox(
                    width: 155.w,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : sendResetLink,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E3A8A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        padding:  EdgeInsets.symmetric(vertical: 16),
                        minimumSize:  Size(double.infinity, 50),
                      ),
                      child: _isLoading
                          ?  SizedBox(
                              width: 24.w,
                              height: 24.h,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.5,
                              ),
                            )
                          :  Text(
                              'Next',
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
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
}
