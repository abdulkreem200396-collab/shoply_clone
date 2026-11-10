import 'package:shoply_clone/core/model/profile/response_profile.dart';

abstract class ProfileState {}

class ProfileInitState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  ProfileLoadedState({required this.profile});

  final ResponseProfile profile;
}

class ProfileErrorState extends ProfileState {
  ProfileErrorState({required this.message});

  final String message;
}

class ProfileLoggedOutState extends ProfileState {}
