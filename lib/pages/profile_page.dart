import 'package:fb_auth_provider_state_notifier_windy/providers/providers.dart';
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
  }

  void _getProfile() {
    final String uid = context.read<fb_auth.User?>()!.uid;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileProvider>().getProfile(uid: uid);
    });
  }

  void errorDialogListener(ProfileState state) {
    if (state.profileStatus == ProfileStatus.error) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
    );
  }
}
