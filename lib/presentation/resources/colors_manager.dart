import 'package:flutter/material.dart';

class AppColors {
  const AppColors();

  static const Color primaryBlue = Color(0xFF5f94f7);

  static const Color inactiveGrey = Color(0xFFd8d9d8);

  static const Color kWhite = Color(0xFFffffff);
  static const Color kBlack = Color(0xFF1c1d21);

  static ColorRed red = ColorRed();
  static ColorYellow yellow = ColorYellow();
  static ColorBlue blue = ColorBlue();
}

class ColorRed implements ColorShades {
  @override
  Color dark = const Color(0xFFF08A8E);

  @override
  Color light = const Color(0xFFFCF0F0);

  @override
  Color normal = const Color(0xFFFBE4E6);

  // static const Color light = Color(0xFFFCF0F0);
  // static const Color normal = Color(0xFFFBE4E6);
  // static const Color dark = Color(0xFFF08A8E);
}

class ColorYellow implements ColorShades {
  @override
  Color dark = const Color(0xFFEBBB7F);

  @override
  Color light = const Color(0xFFFFF7EC);

  @override
  Color normal = const Color(0xFFFAF0DA);

  // static const Color light = Color(0xFFFFF7EC);
  // static const Color normal = Color(0xFFFAF0DA);
  // static const Color dark = Color(0xFFEBBB7F);
}

class ColorBlue implements ColorShades {
  @override
  Color dark = const Color(0xFFC0D3F8);

  @override
  Color light = const Color(0xFFEDF4FE);

  @override
  Color normal = const Color(0xFFE1EDFC);

  // static const Color light = Color(0xFFEDF4FE);
  // static const Color normal = Color(0xFFE1EDFC);
  // static const Color dark = Color(0xFFC0D3F8);
}

abstract class ColorShades {
  late Color light;
  late Color dark;
  late Color normal;
}
