import 'dart:async';
import 'package:dr_oplawrence_bible/core/route/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;

  Timer? _timer;
  int secondsRemaining = 59;
  bool canResend = false;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(4, (_) => TextEditingController());
    focusNodes = List.generate(4, (_) => FocusNode());
    startTimer();
  }

  void startTimer() {
    canResend = false;
    secondsRemaining = 59;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
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

  void resendCode() {
    if (canResend) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("New OTP sent!")),
      );
      startTimer();
    }
  }

  void submitOtp() {
    if (isOtpComplete()) {
      String otp = getOtp();
      print("Submitted OTP: $otp");
      Navigator.pushNamed(context, RouteNames.createPass);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter complete OTP")),
      );
    }
  }

  Widget otpBox(int index) {
    return SizedBox(
      width: 75,
      height: 75,
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
          if (value.length == 1 && index < 3) {
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/icons/login_icons.png',scale: 3,),
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
              children: List.generate(4, (index) => otpBox(index)),
            ),

            const SizedBox(height: 20),

            Row(crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Resend code in",
                  style:  TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 15,
                      fontWeight: FontWeight.w500
                  ),
                ),
                Text(
                  " 00:${secondsRemaining.toString().padLeft(2, '0')}",
                  style: const TextStyle(
                    color: Color(0xffB02626),
                    fontSize: 15,
                      fontWeight: FontWeight.w500
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
                  color: canResend ? Color(0xffB02626) : Colors.grey,
                  fontSize: 15,
                  fontWeight: FontWeight.w500
                ),
              ),
            ),

            const SizedBox(height: 20),

            Row(crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 20,
              children: [
                SizedBox(
                  width: 150,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: (){ Navigator.pop(context);},
                    style: OutlinedButton.styleFrom(
                      side:  BorderSide(color:Colors.blue.shade900, width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child:  Text(
                      "Back",
                      style: TextStyle(color: Colors.blue.shade900, fontSize: 16),
                    ),
                  ),
                ),


                SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: isOtpComplete() ? submitOtp : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade900,
                      disabledBackgroundColor: Colors.grey.shade400,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
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