import 'package:fb_auth_provider_state_notifier_windy/models/custom_error.dart';
import 'package:fb_auth_provider_state_notifier_windy/models/user_model.dart';
import 'package:fb_auth_provider_state_notifier_windy/providers/profile/profil_state.dart';
import 'package:fb_auth_provider_state_notifier_windy/repositorie/profile_repository.dart';
import 'package:state_notifier/state_notifier.dart';

class ProfileProvider extends StateNotifier<ProfileState> with LocatorMixin {
  ProfileProvider() : super(ProfileState.initial());

  Future<void> getProfile({required String uid}) async {
    state = state.copyWith(profileStatus: ProfileStatus.loading);

    try {
      final User user = await read<ProfileRepository>().getProfile(uid: uid);
      state = state.copyWith(
        profileStatus: ProfileStatus.loaded,
        user: user,
      );
    } on CustomError catch (e) {
      state = state.copyWith(profileStatus: ProfileStatus.error, error: e);
    }
  }
}
