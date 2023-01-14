import 'package:flutter/cupertino.dart';
import 'package:my_fate/presentation/resources/values_manager.dart';

class AppDecoration {
  const AppDecoration();

  static BoxDecoration defaultBoxDecoration(Color color) => BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(AppCircularRadius.cr24));
}
