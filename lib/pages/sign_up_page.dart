import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';

import '../models/custom_error.dart';
import '../providers/providers.dart';
import '../utils/error_dialog.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  static const routeName = '/signUp';

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  String? name, email, password;
  final _passwordController = TextEditingController();

  void _submit() async {
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });

    final form = _formKey.currentState;

    if (form == null || !form.validate()) return;

    form.save();

    try {
      await context.read<SignUpProvider>().signUp(
            name: name!,
            email: email!,
            password: password!,
          );
    } on CustomError catch (e) {
      errorDialog(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final signUpState = context.watch<SignUpState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Form(
              key: _formKey,
              autovalidateMode: _autovalidateMode,
              child: ListView(
                reverse: true,
                shrinkWrap: true,
                children: [
                  Image.asset(
                    'assets/images/flutter_logo.png',
                    width: 250.0,
                    height: 250.0,
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    autocorrect: false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      labelText: 'Name',
                      prefixIcon: Icon(Icons.account_box),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Name required';
                      }

                      if (value.trim().length < 2) {
                        return 'Name must be at least 2 characters long';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      name = newValue;
                    },
                  ),
                  const SizedBox(height: 20.0),
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
                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: _passwordController,
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
                  const SizedBox(height: 20),
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      labelText: 'Confirm Password',
                      prefixIcon: Icon(Icons.lock),
                    ),
                    validator: (value) {
                      if (_passwordController.text != value) {
                        return 'Password not match';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed:
                        signUpState.signUpStatus == SignInStatus.submitting
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
                        signUpState.signUpStatus == SignInStatus.submitting
                            ? 'Loading...'
                            : 'Sign Up'),
                  ),
                  const SizedBox(height: 10.0),
                  TextButton(
                    onPressed:
                        signUpState.signUpStatus == SignInStatus.submitting
                            ? null
                            : () {
                                Navigator.pop(context);
                              },
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(
                        fontSize: 20.0,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    child: const Text('Already a member? Sign In!'),
                  ),
                ].reversed.toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
