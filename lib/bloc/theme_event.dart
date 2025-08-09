import 'package:equatable/equatable.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class ToggleThemeEvent extends ThemeEvent {
  final bool isDark;

  const ToggleThemeEvent(this.isDark);

  @override
  List<Object?> get props => [isDark];
}