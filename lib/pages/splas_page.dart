import 'package:fb_auth_provider_state_notifier_windy/pages/home_page.dart';
import 'package:fb_auth_provider_state_notifier_windy/pages/sign_in_page.dart';
import 'package:fb_auth_provider_state_notifier_windy/providers/auth/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthState>();

    if (authState.authStatus == AuthStatus.authenticated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamed(context, HomePage.routeName);
      });
    } else if (authState.authStatus == AuthStatus.unauthenticated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamed(context, SignInPage.routeName);
      });
    }
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
