import 'package:flutter/material.dart';
import 'package:my_coffee/common/custom_image.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:my_coffee/constants/text_styles_constants.dart';

import '../constants/color_constants.dart';

/// Button -> rectangle rounded corner

rectangleRoundedCornerButton(
  String sTitle,
  Function onClick, {
  Color bgColor = ColorConstants.cAppColorsBlue,
  Color textColor = ColorConstants.cAppColorsBlue,
      double? size,
      double? height,
}) {
  return GestureDetector(
    onTap: () {
      onClick();
    },
    child: Container(
      alignment: Alignment.center,
      height:height?? 27.sp,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35.sp), color: bgColor),
      child: Text(
        sTitle,
        style: getTextRegular(size: size ?? 15.5.sp, colors: textColor),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

rectangleRoundedCornerButtonMedium(
  String sTitle,
  Function onClick, {
  Color bgColor = ColorConstants.cAppColorsBlue,
  Color textColor = ColorConstants.cAppColorsBlue,
      double? size,
      double? height,
}) {
  return GestureDetector(
    onTap: () {
      onClick();
    },
    child: Container(
      height:height?? 27.sp,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35.sp),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 0), // changes position of shadow
            ),
          ],
          color: bgColor),
      child: Text(
        sTitle,
        style: getText500(size: size ?? 15.5.sp, colors: textColor),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

rectangleRoundedCornerButtonBold(
    String sTitle,
    Function onClick, {
      Color bgColor = ColorConstants.cAppColorsBlue,
      Color textColor = Colors.white,
      double? size,
      double? height,
      String? mIconData,
      double? mIconSize,
    }) {
  return GestureDetector(
    onTap: () {
      onClick();
    },
    child: Container(
        alignment: Alignment.center,
        height:height?? 27.sp,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35.sp),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 0), // changes position of shadow
              ),
            ],
            color: bgColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(visible:mIconData!=null,child: Container(
              height: mIconSize??22.sp,
              child: setImage(mIconData??'',fit: BoxFit.fill),
            )),
            Visibility(visible:mIconData!=null,child: SizedBox(width: 10.sp,)),
            Text(
              sTitle,
              style: getTextBold(size: size?? 15.5.sp, colors: textColor),
              textAlign: TextAlign.center,
            ),
          ],
        )

    ),
  );
}

rectangleCornerButton(
    String sTitle,
    Function onClick, {
      Color bgColor = ColorConstants.cAppColorsBlue,
      Color textColor = Colors.white,
      double? size,
      double? height,

    }) {
  return GestureDetector(
    onTap: () {
      onClick();
    },
    child: Container(
      alignment: Alignment.center,
      height:height?? 27.sp,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.sp),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 0), // changes position of shadow
            ),
          ],
          color: bgColor),
      child: Text(
        sTitle,
        style: getText600(size: size?? 15.5.sp, colors: textColor),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

rectangleCornerButtonBold(
    String sTitle,
    Function onClick, {
      Color bgColor = ColorConstants.cAppColorsBlue,
      Color textColor = Colors.white,
      double? size,
      double? height,
      IconData? mIconData,
    }) {
  return GestureDetector(
    onTap: () {
      onClick();
    },
    child: Container(
      alignment: Alignment.center,
      height:height?? 27.sp,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.sp),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 0), // changes position of shadow
            ),
          ],
          color: bgColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Visibility(visible:mIconData!=null,child: Icon(mIconData,color: textColor,size: 19.sp,)),
          Visibility(visible:mIconData!=null,child: SizedBox(width: 10.sp,)),
          Text(
            sTitle,
            style: getTextBold(size: size?? 15.5.sp, colors: textColor),
            textAlign: TextAlign.center,
          ),
        ],
      )

    ),
  );
}

