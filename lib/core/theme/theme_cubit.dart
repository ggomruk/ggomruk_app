import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'custom/custom_theme.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(CustomTheme.getLightTheme());

  void toggleTheme() {
    emit(state.brightness == Brightness.light
        ? CustomTheme.getDarkTheme()
        : CustomTheme.getLightTheme());
  }
}