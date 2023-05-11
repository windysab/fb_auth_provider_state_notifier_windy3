import 'package:fb_auth_provider_state_notifier_windy/pages/profile_page.dart';
import 'package:fb_auth_provider_state_notifier_windy/providers/auth/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Home'),
          actions: [
            IconButton(
              onPressed: () {
                context.read<AuthProvider>().signOut();
              },
              icon: const Icon(
                Icons.exit_to_app,
              ),
            ),
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfilePage(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.account_circle,
                ))
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/flutter_favorite.png',
                    width: 100.0,
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  const Text(
                    'Provider',
                    style: TextStyle(
                      fontSize: 42.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                'Provider is an awesome\nsate management library\nfor flutter',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
