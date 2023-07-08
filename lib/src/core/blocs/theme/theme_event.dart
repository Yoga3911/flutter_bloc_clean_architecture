part of 'theme_bloc.dart';

sealed class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class LightThemeEvent extends ThemeEvent {}

class DarkThemeEvent extends ThemeEvent {}
