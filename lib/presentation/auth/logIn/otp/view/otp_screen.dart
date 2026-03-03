import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/network/api_clients.dart';
import '../../../../../core/route/route_name.dart';
import '../../../../../data/sources/remote/auth_api_services.dart'
    show AuthApiServices;
import '../viewmodel/forget_otp_riverpod.dart';

class OtpScreen extends ConsumerStatefulWidget {
  final String email; // receive email from previous page
  const OtpScreen({super.key, required this.email});

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;

  Timer? _timer;

  final AuthApiServices authService = AuthApiServices(apiClient: ApiClient());

  @override
  void initState() {
    super.initState();
    controllers = List.generate(6, (_) => TextEditingController());
    focusNodes = List.generate(6, (_) => FocusNode());
    startTimer();
  }

  void startTimer() {
    ref.read(canResendProvider.notifier).state = false;
    ref.read(secondsRemainingProvider.notifier).state = 59;

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final seconds = ref.read(secondsRemainingProvider);
      if (seconds > 0) {
        ref.read(secondsRemainingProvider.notifier).state = seconds - 1;
      } else {
        ref.read(canResendProvider.notifier).state = true;
        timer.cancel();
      }
    });
  }

  String getOtp() => controllers.map((c) => c.text).join();

  bool isOtpComplete() => controllers.every((c) => c.text.trim().isNotEmpty);

  void resendCode() {
    if (ref.read(canResendProvider)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("New OTP sent!")));
      startTimer();
    }
  }

  Future<void> submitOtp() async {
    if (!isOtpComplete()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter complete OTP")),
      );
      return;
    }

    final otp = getOtp();
    ref.read(isLoadingProvider.notifier).state = true;

    try {
      final res = await authService.verifyOtp(email: widget.email, token: otp);

      if (res != null && res['success'] == true) {
        Navigator.pushNamed(
          context,
          RouteNames.createPass,
          arguments: {
            "email": widget.email,
            "token": getOtp(), // pass the OTP as token
          },
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(res?['message'] ?? 'OTP verification failed')),
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

  Widget otpBox(int index, double boxWidth) {
    return SizedBox(
      width: boxWidth,
      height: boxWidth,
      child: TextField(
        controller: controllers[index],
        focusNode: focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        maxLength: 1,
        style: const TextStyle(
          fontSize: 28,
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
          if (value.length == 1 && index < 5) {
            focusNodes[index + 1].requestFocus();
          } else if (value.isEmpty && index > 0) {
            focusNodes[index - 1].requestFocus();
          }
          // no UI state, but can force rebuild if needed
          setState(() {});
        },
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final secondsRemaining = ref.watch(secondsRemainingProvider);
    final canResend = ref.watch(canResendProvider);
    final isLoading = ref.watch(isLoadingProvider);

    double screenWidth = MediaQuery.of(context).size.width;
    double horizontalPadding = 30;
    double spacingBetweenBoxes = 10;
    double boxWidth =
        (screenWidth - horizontalPadding * 2 - (5 * spacingBetweenBoxes)) / 6;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/icons/login_icons.png', scale: 3),
            const SizedBox(height: 25),
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
            const Text(
              'Enter the verification code we just\nsent to your Email.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xff343434),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(6, (index) => otpBox(index, boxWidth)),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Resend code in",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  " 00:${secondsRemaining.toString().padLeft(2, '0')}",
                  style: const TextStyle(
                    color: Color(0xffB02626),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: canResend ? resendCode : null,
              child: Text(
                "or Receive code via call",
                style: TextStyle(
                  color: canResend ? const Color(0xffB02626) : Colors.grey,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 150,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.blue.shade900, width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Back",
                      style: TextStyle(
                        color: Colors.blue.shade900,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : submitOtp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade900,
                      disabledBackgroundColor: Colors.grey.shade400,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "Submit",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
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
