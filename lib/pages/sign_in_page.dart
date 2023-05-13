import 'package:fb_auth_provider_state_notifier_windy/models/custom_error.dart';
import 'package:fb_auth_provider_state_notifier_windy/pages/sign_up_page.dart';
import 'package:fb_auth_provider_state_notifier_windy/providers/sign_in/sign_in_provider.dart';
import 'package:fb_auth_provider_state_notifier_windy/providers/sign_in/sign_in_state.dart';
import 'package:fb_auth_provider_state_notifier_windy/utils/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});
  static const routeName = '/signIn';

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  String? email, password;

  void _submit() async {
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });

    final form = _formKey.currentState;

    if (form == null || !form.validate()) return;
    form.save();

    try {
      await context
          .read<SignInProvider>()
          .signIn(email: email!, password: password!);
    } on CustomError catch (e) {
      errorDialog(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final signInState = context.watch<SignInState>();

    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Image.asset(
                      'assets/images/flutter_logo.png',
                      width: 250.0,
                      height: 250.0,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Email required';
                        }

                        if (!isEmail(value.trim())) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        email = newValue;
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Password required';
                        }
                        if (value.trim().length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        password = newValue;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed:
                            signInState.signInStatus == SignInStatus.submitting
                                ? null
                                : _submit,
                        style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                        ),
                        child: Text(
                            signInState.signInStatus == SignInStatus.submitting
                                ? 'Loading...'
                                : 'Sign in'),),

                                SizedBox(height: 10.0,),
                                TextButton(onPressed:
                          signInState.signInStatus == SignInStatus.submitting
                              ? null
                              : () {
                                  Navigator.pushNamed(
                                      context, SignUpPage.routeName);
                                },
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(
                          fontSize: 20.0,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      child: const Text('Not a member? Sign up!'),)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
