import 'package:flutter_riverpod/legacy.dart';

// Loading state for sending reset link
final isLoadingProvider = StateProvider<bool>((ref) => false);