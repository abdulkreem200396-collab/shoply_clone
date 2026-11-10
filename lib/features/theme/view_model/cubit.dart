import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_clone/core/local/local_storage.dart';
import 'package:shoply_clone/features/theme/view_model/state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(mode: LocalStorage.instance.themeMode));

  Future<void> setMode(ThemeMode mode) async {
    if (state.mode == mode) return;

    emit(ThemeState(mode: mode));
    await LocalStorage.instance.setThemeMode(mode);
  }
}
