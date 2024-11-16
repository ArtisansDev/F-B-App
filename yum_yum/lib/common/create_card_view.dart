import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

getCardView(Widget view,{double? paddingLeftRight,Color? mColor,double?margin,double?paddingTopBottom}) {
  return Container(
      decoration: BoxDecoration(
        color: mColor??Colors.white,
        borderRadius: BorderRadius.circular(14.sp),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.22),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 0), // changes position of shadow
          ),
        ], // use instead of BorderRadius.all(Radius.circular(20))
      ),
      margin: EdgeInsets.all(margin??14.sp),
      padding:
          EdgeInsets.only(left: paddingLeftRight??15.sp, right: paddingLeftRight??15.sp, top: paddingTopBottom??16.sp, bottom: paddingTopBottom??16.sp),
      child: view);
}
