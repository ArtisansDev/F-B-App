import 'package:flutter/material.dart';

class ColorConstants {

  static const Color primaryBackgroundColor = Color(0xFFF5F5F5);
  static const Color appEditText = Color(0xFFCACACA);
  static const Color appEditTextHint = Color(0xFFB5B5B5);
  static const Color appVersion = Color(0xFF808080);
  static const Color appEditProfile = Color(0xFF4E4E4E);
  static const Color appBarBelow = Color(0xFFDF4251);
  static const Color appProgress = Color(0xFFD9D9D9);
  static const Color black = Color(0xFF000000);
  static const Color buttonBar = Color(0xFF0B2232);
  static const Color textColour = Color(0xFF18A937);
  // static const Color buttonBar = Color(0xFF222D65);


  ///app Colour
  static const Color cAppColorsBlue = Color(0xFFF09636);

  static const int _cAppColorsBlueValue = 0xFFF09636;

  static const MaterialColor cAppColors = MaterialColor(
    _cAppColorsBlueValue,
    <int, Color>{
      50: Color(0xFFFF9664),
      100: Color(0xFFFF905C),
      200: Color(0xFFFD8851),
      300: Color(0xFFFC8148),
      400: Color(0xFFF6793E),
      500: Color(_cAppColorsBlueValue),
      600: Color(0xFFEF6E31),
      700: Color(0xFFEA682A),
      800: Color(0xFFE76223),
      900: Color(0xFFE15A1A),
    },
  );

  static const Color yourKeySkillsColor = Color(0xFFFF617B);
  static const Color yourKeySkillsColor1 = Color(0xFF32C861);
  static const Color yourKeySkillsColor2 = Color(0xFF4489E4);
  static const Color yourKeySkillsColor3 = Color(0xFFF09636);
  static const Color yourKeySkillsColor4 = Color(0xFF2E3A59);

  static List<Color> yourKeySkillsListColour = [
    yourKeySkillsColor,
    yourKeySkillsColor1,
    yourKeySkillsColor2,
    yourKeySkillsColor3
  ];
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
