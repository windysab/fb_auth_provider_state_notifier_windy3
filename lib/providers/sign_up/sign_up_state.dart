import 'package:equatable/equatable.dart';

import 'package:fb_auth_provider_state_notifier_windy/models/custom_error.dart';
import 'package:fb_auth_provider_state_notifier_windy/repositorie/auth_repository.dart';
import 'package:state_notifier/state_notifier.dart';

enum SignUpStatus {
  inital,
  submiting,
  success,
  error,
}

class SignUpState extends Equatable {
  const SignUpState({
    required this.error,
    required this.signUpStatus,
  });
  factory SignUpState.initial() {
    return const SignUpState(
        error: CustomError(), signUpStatus: SignUpStatus.inital);
  }

  final CustomError error;
  final SignUpStatus signUpStatus;

  @override
  List<Object> get props => [error, signUpStatus];

  @override
  bool get stringify => true;

  SignUpState copyWith({
    CustomError? error,
    SignUpStatus? signUpStatus,
  }) {
    return SignUpState(
      error: error ?? this.error,
      signUpStatus: signUpStatus ?? this.signUpStatus,
    );
  }
}

class SignUpProvider extends StateNotifier<SignUpState> with LocatorMixin {
  SignUpProvider() : super(SignUpState.initial());

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    state = state.copyWith(signUpStatus: SignUpStatus.submiting);
    try {
      await read<AuthRepository>()
          .signUp(name: name, email: email, password: password);
      state = state.copyWith(signUpStatus: SignUpStatus.success);
    } on CustomError catch (e) {
      state = state.copyWith(
        signUpStatus: SignUpStatus.error,
        error: e,
      );
      rethrow;
    }
  }
}
