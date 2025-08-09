import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ThemeState extends Equatable {
  final ThemeMode themeMode;

  const ThemeState(this.themeMode);

  bool get isDarkMode => themeMode == ThemeMode.dark;

  @override
  List<Object> get props => [themeMode];
}
