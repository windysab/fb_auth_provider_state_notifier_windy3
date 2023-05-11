import 'package:fb_auth_provider_state_notifier_windy/models/custom_error.dart';
import 'package:fb_auth_provider_state_notifier_windy/providers/sign_in/sign_in_state.dart';
import 'package:fb_auth_provider_state_notifier_windy/repositorie/auth_repository.dart';
import 'package:state_notifier/state_notifier.dart';

class SignInProvider extends StateNotifier<SignInState> with LocatorMixin {
  SignInProvider() : super(SignInState.initial());

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(signInStatus: SignInStatus.submitting);

    try {
      await read<AuthRepository>().signIn(email: email, password: password);
    } on CustomError catch (e) {
      state = state.copyWith(
        signInStatus: SignInStatus.error,
        error: e,
      );
      rethrow;
    }
  }
}
