import 'package:equatable/equatable.dart';

import 'package:fb_auth_provider_state_notifier_windy/models/custom_error.dart';

enum SignInStatus {
  initial,
  submitting,
  success,
  error,
}

class SignInState extends Equatable {
  const SignInState({
    required this.error,
    required this.signInStatus,
  });

  factory SignInState.initial() {
    return const SignInState(error: CustomError(), signInStatus: SignInStatus.initial);
  }

  final CustomError error;
  final SignInStatus signInStatus;

  @override
  List<Object> get props => [error, signInStatus];

  @override
  bool get stringify => true;

  

  SignInState copyWith({
    CustomError? error,
    SignInStatus? signInStatus,
  }) {
    return SignInState(
      error: error ?? this.error,
      signInStatus: signInStatus ?? this.signInStatus,
    );
  }
}
