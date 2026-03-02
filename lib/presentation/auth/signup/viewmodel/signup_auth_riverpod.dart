import 'package:dr_oplawrence_bible/core/network/api_clients.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../../data/sources/remote/auth_api_services.dart';

/// Controls password visibility
final passwordVisibilityProvider = StateProvider<bool>((ref) => false);
final authRepositoryProvider = Provider<AuthApiServices>((ref) {
  return AuthApiServices(apiClient: ApiClient());
});
final signupLoadingProvider = StateProvider<bool>((ref) => false);

// ApiClient provider
final apiClientProvider = Provider<ApiClient>((ref) => ApiClient());

class SignUpState {
  final bool isLoading;

  SignUpState({this.isLoading = false});

  SignUpState copyWith({bool? isLoading}) {
    return SignUpState(isLoading: isLoading ?? this.isLoading);
  }
}

final signUpStateProvider = StateNotifierProvider<SignUpNotifier, SignUpState>((
  ref,
) {
  return SignUpNotifier();
});

class SignUpNotifier extends StateNotifier<SignUpState> {
  SignUpNotifier() : super(SignUpState());

  void setLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }
}
