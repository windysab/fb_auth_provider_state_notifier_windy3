import 'package:fb_auth_provider_state_notifier_windy/providers/providers.dart';
import 'package:fb_auth_provider_state_notifier_windy/utils/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final ProfileProvider profileProv;
  late final void Function() removeListener;

  @override
  void initState() {
    super.initState();
    profileProv = context.read<ProfileProvider>();
    removeListener = profileProv.addListener((state) {});
    _getProfile();
  }

  void _getProfile() {
    final String uid = context.read<fb_auth.User?>()!.uid;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileProvider>().getProfile(uid: uid);
    });
  }

  void errorDialogListener(ProfileState state) {
    if (state.profileStatus == ProfileStatus.error) {}
    errorDialog(context, state.error);
  }

  @override
  void dispose() {
    removeListener();
    super.dispose();
  }

  Widget _buidProfile() {
    final profileState = context.watch<ProfileState>();
    if (profileState.profileStatus == ProfileStatus.initial) {
      return Container();
    } else if (profileState.profileStatus == ProfileStatus.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (profileState.profileStatus == ProfileStatus.error) {
      return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/error.png',
              width: 75.0,
              height: 75.0,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              width: 20.0,
            ),
            const Text(
              'Ooops!\nTry Again',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.0, color: Colors.red),
            )
          ],
        ),
      );
    }

    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: _buidProfile(),
    );
  }
}
