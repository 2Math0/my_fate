import 'package:flutter/material.dart';
import 'package:my_fate/presentation/resources/text_styles_manager.dart';
import 'package:my_fate/presentation/resources/values_manager.dart';

import 'colors_manager.dart';

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

  static InputDecoration formFieldDecoration(
          {required String hintText, bool isEnabled = true}) =>
      InputDecoration(
          contentPadding: const EdgeInsets.all(AppPadding.p12),
          hintText: hintText,
          hintStyle: const AppTextStyles()
              .bodyTextNormalRegular
              .copyWith(color: AppColors.inactiveGrey),
          border: defaultOutlineBorder(),
          errorStyle: const AppTextStyles()
              .bodyTextNormalBold
              .copyWith(color: AppColors.red.dark),
          errorMaxLines: 8,
          filled: !isEnabled,
          enabled: isEnabled,
          fillColor: AppColors.inactiveGrey,
          enabledBorder: defaultOutlineBorder(),
          focusedBorder: defaultOutlineBorder(color: AppColors.primaryBlue),
          errorBorder: defaultOutlineBorder(color: AppColors.red.dark),
          focusedErrorBorder: defaultOutlineBorder(
              color: AppColors.red.dark, borderWidth: AppSize.s2));

  static OutlineInputBorder defaultOutlineBorder(
          {Color color = AppColors.inactiveGrey,
          double borderWidth = AppSize.s1}) =>
      OutlineInputBorder(
          borderSide: BorderSide(color: color, width: borderWidth),
          borderRadius: BorderRadius.circular(AppCircularRadius.cr5));
}
