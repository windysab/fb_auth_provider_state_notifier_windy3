import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb_auth_provider_state_notifier_windy/pages/home_page.dart';
import 'package:fb_auth_provider_state_notifier_windy/pages/sign_in_page.dart';
import 'package:fb_auth_provider_state_notifier_windy/pages/sign_up_page.dart';
import 'package:fb_auth_provider_state_notifier_windy/pages/splas_page.dart';
import 'package:fb_auth_provider_state_notifier_windy/providers/providers.dart';
import 'package:fb_auth_provider_state_notifier_windy/repositorie/auth_repository.dart';
import 'package:fb_auth_provider_state_notifier_windy/repositorie/profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthRepository>(
          create: (context) => AuthRepository(
              firebaseAuth: fb_auth.FirebaseAuth.instance,
              firebaseFirestore: FirebaseFirestore.instance),
        ),
        Provider<ProfileRepository>(
          create: (context) =>
              ProfileRepository(firebaseFirestore: FirebaseFirestore.instance),
        ),
        StreamProvider<fb_auth.User?>(
          create: (context) => context.read<AuthRepository>().user,
          initialData: null,
        ),
        StateNotifierProvider<AuthProvider, AuthState>(
          create: (context) => AuthProvider(),
        ),
        StateNotifierProvider<SignInProvider, SignInState>(
          create: (context) => SignInProvider(),
        ),
        StateNotifierProvider<SignUpProvider, SignUpState>(
          create: (context) => SignUpProvider(),
        ),
        StateNotifierProvider<ProfileProvider, ProfileState>(
          create: (context) => ProfileProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'fb auth provider',
        routes: {
          SplashPage.routeName: (context) => const SplashPage(),
          SignUpPage.routeName: (context) => const SignUpPage(),
          SignInPage.routeName: (context) => const SignInPage(),
          HomePage.routeName: (context) => const HomePage(),
        },
      ),
    );
  }
}
