
import 'package:flutter_riverpod/legacy.dart';

// Password visibility provider
final obscureTextProvider = StateProvider<bool>((ref) => true);

// Remember me checkbox provider
final rememberMeProvider = StateProvider<bool>((ref) => true);

// Loading state provider
final isLoadingProvider = StateProvider<bool>((ref) => false);