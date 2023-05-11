import 'package:fb_auth_provider_state_notifier_windy/providers/auth/auth_state.dart';
import 'package:fb_auth_provider_state_notifier_windy/repositorie/auth_repository.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;

class AuthProvider extends StateNotifier<AuthState> with LocatorMixin {
  AuthProvider() : super(AuthState.unknown());

  @override
  void update(Locator watch) {
    final userStrem = watch<fb_auth.User?>();
    if (userStrem != null) {
      state =
          state.copyWith(authStatus: AuthStatus.authenticated, user: userStrem);
    } else {
      state = state.copyWith(
        authStatus: AuthStatus.unauthenticated,
      );
    }
    super.update(watch);
  }

  void signOut() async {
    await read<AuthRepository>().signOut();
  }
}
