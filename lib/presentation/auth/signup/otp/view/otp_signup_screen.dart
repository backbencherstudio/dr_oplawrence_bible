import 'dart:async';
import 'package:dr_oplawrence_bible/core/network/api_clients.dart';
import 'package:dr_oplawrence_bible/core/route/route_name.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../data/sources/remote/auth_api_services.dart';

class OtpSignupScreen extends StatefulWidget {
  final String email;

  const OtpSignupScreen({super.key, required this.email});

  @override
  State<OtpSignupScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpSignupScreen> {
  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;

  final authService = AuthApiServices(apiClient: ApiClient());

  Timer? _timer;
  int secondsRemaining = 59;
  bool canResend = false;
  final int otpLength = 6;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(otpLength, (_) => TextEditingController());
    focusNodes = List.generate(otpLength, (_) => FocusNode());
    startTimer();
  }

  void startTimer() {
    canResend = false;
    secondsRemaining = 59;
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      if (secondsRemaining > 0) {
        setState(() => secondsRemaining--);
      } else {
        setState(() => canResend = true);
        timer.cancel();
      }
    });
  }

  String getOtp() {
    return controllers.map((c) => c.text).join();
  }

  bool isOtpComplete() {
    return controllers.every((c) => c.text.trim().isNotEmpty);
  }

  Future<void> submitOtp() async {
    if (!isOtpComplete()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter complete OTP")),
      );
      return;
    }

    setState(() => isLoading = true);

    final otp = getOtp();

    if (kDebugMode) {
      print("EMAIL: ${widget.email}");
      print("OTP: $otp");
    }

    try {
      final res = await authService.verifyOtp(email: widget.email, token: otp);

      if (kDebugMode) {
        print("VERIFY RESPONSE: $res");
      }

      if (!mounted) return;

      if (res != null &&
          (res['success'] == true ||
              res['status'] == true ||
              res['message'] == "Email verified successfully")) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          RouteNames.loginScreen,
          (route) => false,
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Invalid OTP")));
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Verification failed: $e")));
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  Widget otpBox(int index) {
    return SizedBox(
      width: 50,
      height: 50,
      child: TextField(
        controller: controllers[index],
        focusNode: focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        maxLength: 1,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          counterText: "",
          filled: true,
          fillColor: const Color(0xffB02626),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.white, width: 2),
          ),
        ),
        onChanged: (value) {
          if (value.length == 1 && index < otpLength - 1) {
            focusNodes[index + 1].requestFocus();
          } else if (value.isEmpty && index > 0) {
            focusNodes[index - 1].requestFocus();
          }
          setState(() {});
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
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// LOGO
            Image.asset('assets/icons/login_icons.png', scale: 3),
            const SizedBox(height: 25),

            /// TITLE
            const Text(
              'OTP Verification',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Color(0xff1A1A1A),
              ),
            ),

            const SizedBox(height: 10),

            /// SUBTITLE
            const Text(
              'Enter the verification code we just\nsent on your Phone Number.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xff343434),
              ),
            ),

            const SizedBox(height: 30),

            /// OTP BOXES
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(otpLength, otpBox),
            ),

            const SizedBox(height: 20),

            /// TIMER
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Resend code in",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                Text(
                  " 00:${secondsRemaining.toString().padLeft(2, '0')}",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Color(0xffB02626),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            /// BUTTONS
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// BACK
                SizedBox(
                  width: 150,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Back"),
                  ),
                ),

                const SizedBox(width: 20),

                /// SUBMIT
                SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: (isOtpComplete() && !isLoading)
                        ? submitOtp
                        : null,
                    child: isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
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
