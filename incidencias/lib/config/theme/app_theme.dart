import 'package:flutter/material.dart';

const Color _customColor = Color.fromRGBO(29, 21, 52, 1);

List<Color> _colorThemes = [
  _customColor,
  Colors.blue,
  Colors.teal,
  Colors.green,
  Colors.yellow,
  Colors.orange,
  Colors.pink
];

class AppTheme {
  final int selectedColor;
  final Color colorAppTheme;

  AppTheme({
    this.selectedColor = 0,
  })  : assert(selectedColor >= 0 && selectedColor < _colorThemes.length,
            'Color must be between 0 and ${_colorThemes.length - 1}'),
        colorAppTheme = _colorThemes[selectedColor]; // Inicialización aquí

  ThemeData theme() {
    return ThemeData(
      useMaterial3: false,
      colorSchemeSeed: colorAppTheme,
    );
  }
}
