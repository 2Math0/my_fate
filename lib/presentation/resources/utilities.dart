import 'package:flutter/material.dart';
import 'package:my_fate/presentation/resources/colors_manager.dart';
import 'package:my_fate/presentation/resources/text_styles_manager.dart';

class Utilities {
  const Utilities();

  double getWidth(BuildContext context) => MediaQuery.of(context).size.width;

  double getHeight(BuildContext context) => MediaQuery.of(context).size.height;

  double height50(BuildContext context) => getHeight(context) * 0.5;
  double width50(BuildContext context) => getWidth(context) * 0.5;

  static void customSnackBar(
      {required BuildContext context, required String message}) {
    final snackBar = SnackBar(
      content: Text(message,
          style: const AppTextStyles()
              .captionLargeRegular
              .copyWith(color: AppColors.kWhite)),
      behavior: SnackBarBehavior.fixed,
      elevation: 0,
      backgroundColor: AppColors.kBlack,
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
