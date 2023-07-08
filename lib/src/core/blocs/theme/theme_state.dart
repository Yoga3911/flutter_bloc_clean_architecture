part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  final bool isDarkMode;

  const ThemeState(this.isDarkMode);

  @override
  List<Object> get props => [isDarkMode];

  factory ThemeState.fromMap(Map<String, dynamic> map) {
    return ThemeState(
      map["isDarkMode"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "isDarkMode": isDarkMode,
    };
  }
}
