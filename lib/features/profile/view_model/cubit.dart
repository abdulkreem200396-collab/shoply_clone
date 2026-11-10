import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_clone/core/model/profile/response_profile.dart';
import 'package:shoply_clone/features/profile/repo/profile_repo.dart';
import 'package:shoply_clone/features/profile/view_model/state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitState());

  final _profileRepo = ProfileRepo();
  ResponseProfile? profile;

  Future<void> load() async {
    emit(ProfileLoadingState());

    final result = await _profileRepo.getProfile();
    if (isClosed) return;

    result.fold((message) => emit(ProfileErrorState(message: message)), (data) {
      profile = data;
      emit(ProfileLoadedState(profile: data));
    });
  }

  Future<void> logout() async {
    await _profileRepo.logout();
    if (isClosed) return;
    emit(ProfileLoggedOutState());
  }
}
