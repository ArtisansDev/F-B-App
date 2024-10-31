import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
///poppins
///   TEXT STYLES
TextStyle getText100(
    {Color colors = Colors.white, size = 14.0, heights = 1.2}) {
  return GoogleFonts.poppins(
      color: colors,
      fontSize: size,
      fontWeight: FontWeight.w100,
      letterSpacing: -0.2,
      height: heights);
}

TextStyle getText200(
    {Color colors = Colors.white, size = 14.0, heights = 1.2}) {
  return GoogleFonts.poppins(
      color: colors,
      fontSize: size,
      fontWeight: FontWeight.w200,
      letterSpacing: -0.2,
      height: heights);
}

TextStyle getText300(
    {Color colors = Colors.white, size = 14.0, heights = 1.2}) {
  return GoogleFonts.poppins(
      color: colors,
      fontSize: size,
      fontWeight: FontWeight.w200,
      letterSpacing: -0.2,
      height: heights);
}

TextStyle getTextRegularNoHeights(
    {Color colors = Colors.white, size = 14.0}) {
  return GoogleFonts.poppins(
      color: colors,
      fontSize: size,
      fontWeight: FontWeight.normal,
      letterSpacing: -0.2,
  );
}

TextStyle getTextRegular(
    {Color colors = Colors.white, size = 14.0, heights = 1.2}) {
  return GoogleFonts.poppins(
    color: colors,
    fontSize: size,
    fontWeight: FontWeight.normal,
    letterSpacing: -0.2,
    height: heights
  );
}

TextStyle getTextRegularUnderline(
    {Color colors = Colors.white, size = 14.0, heights = 1.2}) {
  return GoogleFonts.poppins(
    decoration: TextDecoration.underline,
    decorationColor: colors,
    decorationThickness: 1,
    color: colors,
    fontSize: size,
    fontWeight: FontWeight.normal,
    letterSpacing: -0.2,
    height: heights,
  );
}


TextStyle getText500(
    {Color colors = Colors.white,
    size = 14.0,
    heights = 1.2,
    letterSpacing = -0.2}) {
  return GoogleFonts.poppins(
    color: colors,
    fontSize: size,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.2,
    height: heights,
  );
}

TextStyle getText500UnderLine(
    {Color colors = Colors.white, size = 14.0, heights = 1.2}) {
  return GoogleFonts.poppins(
    decoration: TextDecoration.underline,
    color: colors,
    fontSize: size,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.2,
    height: heights,
  );
}



TextStyle getText600(
    {Color colors = Colors.white, size = 14.0, heights = 1.2}) {
  return GoogleFonts.poppins(
    color: colors,
    fontSize: size,
    fontWeight: FontWeight.w600,
    wordSpacing: -0.5,
    letterSpacing: -0.2,
    height: heights,
  );
}

TextStyle getTextBold(
    {Color colors = Colors.white, size = 14.0, heights = 1.2}) {
  return GoogleFonts.poppins(
    color: colors,
    fontSize: size,
    fontWeight: FontWeight.bold,
    wordSpacing: -0.5,
    letterSpacing: -0.2,
    height: heights,
  );
}

TextStyle getText800(
    {Color colors = Colors.white, size = 14.0, heights = 1.2}) {
  return GoogleFonts.poppins(
    color: colors,
    fontSize: size,
    fontWeight: FontWeight.w800,
    wordSpacing: -0.5,
    letterSpacing: -0.2,
    height: heights,
  );
}

TextStyle getText900(
    {Color colors = Colors.white, size = 14.0, heights = 1.2}) {
  return GoogleFonts.poppins(
    color: colors,
    fontSize: size,
    fontWeight: FontWeight.w900,
    wordSpacing: -0.5,
    letterSpacing: -0.2,
    height: heights,
  );
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1)}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}


///Praise
///   TEXT STYLES
TextStyle getTextPraise100(
    {Color colors = Colors.white, size = 14.0, heights = 1.2}) {
  return GoogleFonts.praise(
      color: colors,
      fontSize: size,
      fontWeight: FontWeight.w100,
      letterSpacing: -0.2,
      height: heights);
}

TextStyle getTextPraise200(
    {Color colors = Colors.white, size = 14.0, heights = 1.2}) {
  return GoogleFonts.praise(
      color: colors,
      fontSize: size,
      fontWeight: FontWeight.w200,
      letterSpacing: -0.2,
      height: heights);
}

TextStyle getTextPraise300(
    {Color colors = Colors.white, size = 14.0, heights = 1.2}) {
  return GoogleFonts.praise(
      color: colors,
      fontSize: size,
      fontWeight: FontWeight.w200,
      letterSpacing: -0.2,
      height: heights);
}


TextStyle getTextPraiseRegular(
    {Color colors = Colors.white, size = 14.0, heights = 1.2}) {
  return GoogleFonts.praise(
    color: colors,
    fontSize: size,
    fontWeight: FontWeight.normal,
    letterSpacing: -0.2,

  );
}

TextStyle getTextPraiseRegularUnderline(
    {Color colors = Colors.white, size = 14.0, heights = 1.2}) {
  return GoogleFonts.praise(
    decoration: TextDecoration.underline,
    decorationColor: colors,
    decorationThickness: 1,
    color: colors,
    fontSize: size,
    fontWeight: FontWeight.normal,
    letterSpacing: -0.2,
    height: heights,
  );
}


TextStyle getTextPraise500(
    {Color colors = Colors.white,
      size = 14.0,
      heights = 1.2,
      letterSpacing = -0.2}) {
  return GoogleFonts.praise(
    color: colors,
    fontSize: size,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.2,
    height: heights,
  );
}

TextStyle getTextPraise500UnderLine(
    {Color colors = Colors.white, size = 14.0, heights = 1.2}) {
  return GoogleFonts.praise(
    decoration: TextDecoration.underline,
    color: colors,
    fontSize: size,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.2,
    height: heights,
  );
}

TextStyle getTextPraise600(
    {Color colors = Colors.white, size = 14.0, heights = 1.2}) {
  return GoogleFonts.praise(
    color: colors,
    fontSize: size,
    fontWeight: FontWeight.w600,
    wordSpacing: -0.5,
    letterSpacing: -0.2,
    height: heights,
  );
}

TextStyle getTextPraiseBold(
    {Color colors = Colors.white, size = 14.0, heights = 1.2}) {
  return GoogleFonts.praise(
    color: colors,
    fontSize: size,
    fontWeight: FontWeight.bold,
    wordSpacing: -0.5,
    letterSpacing: -0.2,
    height: heights,
  );
}

TextStyle getTextPraise800(
    {Color colors = Colors.white, size = 14.0, heights = 1.2}) {
  return GoogleFonts.praise(
    color: colors,
    fontSize: size,
    fontWeight: FontWeight.w800,
    wordSpacing: -0.5,
    letterSpacing: -0.2,
    height: heights,
  );
}

TextStyle getTextPraise900(
    {Color colors = Colors.white, size = 14.0, heights = 1.2}) {
  return GoogleFonts.praise(
    color: colors,
    fontSize: size,
    fontWeight: FontWeight.w900,
    wordSpacing: -0.5,
    letterSpacing: -0.2,
    height: heights,
  );
}

getTextSpan({String word = "", size = 14.0, bool bStare = true}) {
  return RichText(
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
    text: TextSpan(
      style: getTextRegular(colors: Colors.black, size: size),
      children: <TextSpan>[
        TextSpan(text: word),
        TextSpan(
            text: bStare ? "*" : "",
            style: getTextRegular(colors: Colors.red.shade900, size: size)),
      ],
    ),
  );
}
