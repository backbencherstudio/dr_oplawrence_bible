import 'dart:async';
import 'package:flutter_riverpod/legacy.dart';
import '../../../../../data/sources/remote/auth_api_services.dart';
import 'package:dr_oplawrence_bible/core/network/api_clients.dart';

class OtpState {
  final List<String> otpValues;
  final int secondsRemaining;
  final bool canResend;
  final bool isLoading;

  OtpState({
    required this.otpValues,
    this.secondsRemaining = 59,
    this.canResend = false,
    this.isLoading = false,
  });

  // Derived property
  bool get isOtpComplete => otpValues.every((e) => e.trim().isNotEmpty);

  OtpState copyWith({
    List<String>? otpValues,
    int? secondsRemaining,
    bool? canResend,
    bool? isLoading,
  }) {
    return OtpState(
      otpValues: otpValues ?? this.otpValues,
      secondsRemaining: secondsRemaining ?? this.secondsRemaining,
      canResend: canResend ?? this.canResend,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class OtpNotifier extends StateNotifier<OtpState> {
  final AuthApiServices authService;
  Timer? _timer;
  final int otpLength;

  OtpNotifier({required this.authService, this.otpLength = 6})
      : super(OtpState(otpValues: List.generate(6, (_) => ""))) {
    startTimer();
  }

  void updateOtp(int index, String value) {
    final newOtp = [...state.otpValues];
    newOtp[index] = value;
    state = state.copyWith(otpValues: newOtp);
  }

  String get otp => state.otpValues.join();

  void startTimer() {
    state = state.copyWith(canResend: false, secondsRemaining: 59);
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.secondsRemaining > 0) {
        state = state.copyWith(secondsRemaining: state.secondsRemaining - 1);
      } else {
        state = state.copyWith(canResend: true);
        timer.cancel();
      }
    });
  }

  Future<Map<String, dynamic>?> submitOtp(String email) async {
    if (!state.isOtpComplete) return null;
    state = state.copyWith(isLoading: true);
    try {
      final res = await authService.verifyOtp(email: email, token: otp);
      return res;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

// Riverpod provider
final otpProvider =
    StateNotifierProvider<OtpNotifier, OtpState>((ref) => OtpNotifier(
          authService: AuthApiServices(apiClient: ApiClient()),
        ));