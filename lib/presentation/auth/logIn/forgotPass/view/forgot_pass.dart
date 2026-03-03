import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/icons/login_icons.png', scale: 3),
              const SizedBox(height: 25),
              Text(
                'Forgot Password',
                textAlign: TextAlign.center,
                style: GoogleFonts.merriweather(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff1A1A1A),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Enter your login email details below',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff343434),
                ),
              ),
              const SizedBox(height: 40),
              Align(
                alignment: Alignment.topLeft,
                child: const Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'example@gmail.com',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back Button
                  SizedBox(
                    width: 155,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          side: const BorderSide(
                            color: Color(0xFF1E3A8A),
                            width: 1,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text(
                        'Back',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF1E3A8A),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  // Next Button (Send Reset Link)
                  SizedBox(
                    width: 155,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : sendResetLink,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E3A8A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.5,
                              ),
                            )
                          : const Text(
                              'Next',
                              style: TextStyle(
                                fontSize: 18,
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
