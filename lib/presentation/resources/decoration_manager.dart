import 'package:flutter/material.dart';
import 'package:my_fate/presentation/resources/values_manager.dart';

class AppDecoration {
  const AppDecoration();

  static BoxDecoration defaultBoxDecoration(Color color) => BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(AppCircularRadius.cr24));

  static ButtonStyle transparentElevatedBtnStyle(Color color) =>
      ElevatedButton.styleFrom(
        shadowColor: color,
        elevation: 0,
        backgroundColor: color,
      );
}
