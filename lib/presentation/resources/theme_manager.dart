import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_fate/presentation/resources/colors_manager.dart';
import 'package:my_fate/presentation/resources/text_styles_manager.dart';

ThemeData getApplicationTheme(BuildContext context) {
  String? familyFont =
      GoogleFonts.kanit().fontFamily; // secularOne, pay-toneOne are great fonts

  return ThemeData(
    // main colors of the app
    // primaryColor: AppColors.primaryBlue,
    // disabledColor: AppColors.neutralGrey,
    // colorScheme: const ColorScheme(
    //     brightness: Brightness.light,
    //     primary: AppColors.primaryBlue,
    //     // color the selected number in calender
    //     onPrimary: AppColors.backgroundWhite,
    //     secondary: AppColors.neutralDark,
    //     onSecondary: AppColors.neutralDark,
    //     error: AppColors.primaryRed,
    //     onError: AppColors.primaryRed,
    //     background: AppColors.backgroundWhite,
    //     onBackground: AppColors.backgroundWhite,
    //     surface: AppColors.primaryBlue,
    //     // colors the numbers in calender
    //     onSurface: AppColors.neutralGrey),

    // ripple color
    // splashColor:
    // will be used in case of disabled button for example
    // accentColor: AppColors.neutralDark, // deprecated
    // card view theme
    // cardTheme: const CardTheme(
    //     color: AppColors.backgroundWhite,
    //     shadowColor: AppColors.neutralGrey,
    //     elevation: AppSize.s4),
    // App bar theme
    appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: AppColors.kWhite),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.dark, // For iOS: (dark icons)
          statusBarIconBrightness:
              Brightness.dark, // For Android(M and greater): (dark icons)
        ),
        titleTextStyle:
            const AppTextStyles().headingH2.copyWith(fontFamily: familyFont)),
    // Button theme
    // buttonTheme: const ButtonThemeData(
    //   shape: StadiumBorder(),
    //   disabledColor: AppColors.neutralGrey,
    //   buttonColor: AppColors.primaryBlue,
    //   // splashColor:
    // ),

    // elevated button theme
    // elevatedButtonTheme: ElevatedButtonThemeData(
    //     style: ElevatedButton.styleFrom(
    //         textStyle: const AppTextStyles()
    //             .buttonText
    //             .copyWith(color: AppColors.backgroundWhite),
    //         // primary: AppColors.primaryBlue, // deprecated
    //         shape: RoundedRectangleBorder(
    //             borderRadius: BorderRadius.circular(AppSize.s12)))),

    // default font family
    fontFamily: familyFont,

    // Text theme
    textTheme: TextTheme(
        headline1:
            const AppTextStyles().headingH1.copyWith(color: AppColors.kBlack),
        headline2:
            const AppTextStyles().headingH2.copyWith(color: AppColors.kBlack),
        headline3:
            const AppTextStyles().headingH3.copyWith(color: AppColors.kBlack),
        headline4:
            const AppTextStyles().headingH4.copyWith(color: AppColors.kBlack),
        subtitle1:
            const AppTextStyles().linkSmall.copyWith(color: AppColors.kBlack),
        subtitle2:
            const AppTextStyles().linkSmall.copyWith(color: AppColors.kBlack),
        bodyText2: const AppTextStyles()
            .bodyTextMediumRegular
            .copyWith(color: AppColors.kBlack),
        // it affects the style of calender number
        caption: const AppTextStyles()
            .captionNormalRegular
            .copyWith(fontWeight: FontWeight.w900, color: AppColors.kBlack),
        bodyText1: const AppTextStyles()
            .bodyTextNormalRegular
            .copyWith(color: AppColors.kBlack)),
    // input decoration theme (text form field)

    // inputDecorationTheme: InputDecorationTheme(
    //   contentPadding: const EdgeInsets.all(AppPadding.p8),
    //   // hint style
    //   hintStyle: const AppTextStyles()
    //       .bodyTextNormalRegular
    //       .copyWith(color: AppColors.neutralGrey),
    //
    //   // label style
    //   labelStyle: const AppTextStyles()
    //       .bodyTextMediumRegular
    //       .copyWith(color: AppColors.neutralDark),
    //   // error style
    //   errorStyle: const AppTextStyles()
    //       .bodyTextNormalRegular
    //       .copyWith(color: AppColors.primaryRed),
    //
    //   // enabled border
    //   enabledBorder: const OutlineInputBorder(
    //       borderSide:
    //           BorderSide(color: AppColors.neutralGrey, width: AppSize.s1_5),
    //       borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),
    //
    //   // focused border
    //   focusedBorder: const OutlineInputBorder(
    //       borderSide:
    //           BorderSide(color: AppColors.primaryBlue, width: AppSize.s1_5),
    //       borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),
    //
    //   // error border
    //   errorBorder: const OutlineInputBorder(
    //       borderSide:
    //           BorderSide(color: AppColors.primaryRed, width: AppSize.s1_5),
    //       borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),
    //   // focused error border
    //   focusedErrorBorder: const OutlineInputBorder(
    //       borderSide:
    //           BorderSide(color: AppColors.primaryBlue, width: AppSize.s1_5),
    //       borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),
    // )
  );
}
