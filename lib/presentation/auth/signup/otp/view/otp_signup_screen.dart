import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dr_oplawrence_bible/core/route/route_name.dart';
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
      width: 50,
      height: 50,
      child: TextField(
        controller: controllers[index],
        focusNode: focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
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
        padding: const EdgeInsets.symmetric(horizontal: 30),
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
              'Enter the verification code we just\nsent on your Phone Number.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xff343434),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                otpLength,
                (index) => otpBox(index, otpNotifier),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Resend code in",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                Text(
                  " 00:${otpState.secondsRemaining.toString().padLeft(2, '0')}",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Color(0xffB02626),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 150,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Back"),
                  ),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  width: 150,
                  height: 50,
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
