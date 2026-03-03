
import 'package:flutter_riverpod/legacy.dart';

// Loading state
final isLoadingProvider = StateProvider<bool>((ref) => false);

// Timer seconds remaining
final secondsRemainingProvider = StateProvider<int>((ref) => 59);

// Can resend OTP
final canResendProvider = StateProvider<bool>((ref) => false);