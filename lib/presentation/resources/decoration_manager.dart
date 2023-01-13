import 'package:flutter/material.dart';
import 'package:my_fate/presentation/resources/text_styles_manager.dart';

import 'colors_manager.dart';
import 'values_manager.dart';

class AppDecoration {
  const AppDecoration();

  static BoxDecoration lightRoundedBorder = BoxDecoration(
      borderRadius: BorderRadius.circular(AppCircularRadius.cr5),
      border: Border.all(color: AppColors.neutralLight));

  static InputDecoration formFieldDecoration(String hintText) =>
      InputDecoration(
          contentPadding: const EdgeInsets.all(AppPadding.p12),
          hintText: hintText,
          border: defaultOutlineBorder(),
          errorStyle: const AppTextStyles()
              .bodyTextNormalBold
              .copyWith(color: AppColors.primaryRed),
          errorMaxLines: 8,
          enabledBorder: defaultOutlineBorder(),
          focusedBorder: defaultOutlineBorder(color: AppColors.primaryBlue),
          errorBorder: defaultOutlineBorder(color: AppColors.primaryRed),
          focusedErrorBorder: defaultOutlineBorder(
              color: AppColors.primaryRed, borderWidth: AppSize.s2));

  static OutlineInputBorder defaultOutlineBorder(
          {Color color = AppColors.neutralLight,
          double borderWidth = AppSize.s1}) =>
      OutlineInputBorder(
          borderSide: BorderSide(color: color, width: borderWidth),
          borderRadius: BorderRadius.circular(AppCircularRadius.cr5));

  static BoxDecoration defaultBoxDecoration = BoxDecoration(
      border: Border.all(color: AppColors.neutralLight),
      borderRadius: BorderRadius.circular(AppCircularRadius.cr5));
}
