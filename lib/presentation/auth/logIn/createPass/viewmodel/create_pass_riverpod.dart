import 'package:flutter_riverpod/legacy.dart';

// Password visibility
final isPasswordVisibleProvider1 = StateProvider<bool>((ref) => false);
final isPasswordVisibleProvider2 = StateProvider<bool>((ref) => false);

// Loading state
final isLoadingProvider = StateProvider<bool>((ref) => false);
