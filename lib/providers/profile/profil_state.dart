import 'package:equatable/equatable.dart';

import 'package:fb_auth_provider_state_notifier_windy/models/custom_error.dart';
import 'package:fb_auth_provider_state_notifier_windy/models/user_model.dart';

enum ProfileStatus {
  initial,
  loading,
  loaded,
  error,
}

class ProfileState extends Equatable {
  final CustomError error;
  final ProfileStatus profileStatus;
  final User user;
  const ProfileState({
    required this.error,
    required this.profileStatus,
    required this.user,
  });
  factory ProfileState.initial() {
    return ProfileState(
      profileStatus: ProfileStatus.initial,
      user: User.initialUser(),
      error: const CustomError(),
    );
  }

  @override
  List<Object> get props => [error, profileStatus, user];

  ProfileState copyWith({
    CustomError? error,
    ProfileStatus? profileStatus,
    User? user,
  }) {
    return ProfileState(
      error: error ?? this.error,
      profileStatus: profileStatus ?? this.profileStatus,
      user: user ?? this.user,
    );
  }

  @override
  String toString() => 
  'ProfileState(error: $error, profileStatus: $profileStatus, user: $user)';
}
