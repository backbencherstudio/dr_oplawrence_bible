import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dr_oplawrence_bible/core/route/route_name.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../viewmodel/otp_riverpod.dart';

class OtpSignupScreen extends ConsumerStatefulWidget {
  final String email;

  const OtpSignupScreen({super.key, required this.email});

  @override
  ConsumerState<OtpSignupScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpSignupScreen> {
  late List<FocusNode> focusNodes;
  late List<TextEditingController> controllers;
  final int otpLength = 6;

  @override
  void initState() {
    super.initState();
    focusNodes = List.generate(otpLength, (_) => FocusNode());
    controllers = List.generate(otpLength, (_) => TextEditingController());

    // Initialize controllers from Riverpod state
    final otpState = ref.read(otpProvider);
    for (int i = 0; i < otpLength; i++) {
      controllers[i].text = otpState.otpValues[i];
    }
  }

  Widget otpBox(int index, OtpNotifier otpNotifier) {
    return SizedBox(
      width: 50.w,
      height: 50.h,
      child: TextField(
        controller: controllers[index],
        focusNode: focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          counterText: "",
          filled: true,
          fillColor: const Color(0xffB02626),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: Colors.white, width: 2),
          ),
        ),
        onChanged: (value) {
          otpNotifier.updateOtp(index, value);

          if (value.length == 1 && index < otpLength - 1) {
            focusNodes[index + 1].requestFocus();
          } else if (value.isEmpty && index > 0) {
            focusNodes[index - 1].requestFocus();
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    for (var c in controllers) {
      c.dispose();
    }
    for (var n in focusNodes) {
      n.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final otpState = ref.watch(otpProvider);
    final otpNotifier = ref.read(otpProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/icons/login_icons.png', scale: 3),
            SizedBox(height: 25.h),
            Text(
              'OTP Verification',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.w700,
                color: Color(0xff1A1A1A),
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              'Enter the verification code we just\nsent on your Phone Number.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xff343434),
              ),
            ),
            SizedBox(height: 30.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                otpLength,
                (index) => otpBox(index, otpNotifier),
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Resend code in",
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  " 00:${otpState.secondsRemaining.toString().padLeft(2, '0')}",
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xffB02626),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 150.w,
                  height: 50.h,
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Back",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: 150.w,
                  height: 50.h,
                  child: ElevatedButton(
                    onPressed: (otpState.isOtpComplete && !otpState.isLoading)
                        ? () async {
                            final res = await otpNotifier.submitOtp(
                              widget.email,
                            );
                            if (!mounted) return;

                            if (res != null &&
                                (res['success'] == true ||
                                    res['status'] == true ||
                                    res['message'] ==
                                        "Email verified successfully")) {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                RouteNames.loginScreen,
                                (route) => false,
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Invalid OTP")),
                              );
                            }
                          }
                        : null,
                    child: otpState.isLoading
                        ? SizedBox(
                            height: 20.h,
                            width: 20.w,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text("Submit"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
