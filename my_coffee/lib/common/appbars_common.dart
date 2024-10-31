import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:my_coffee/common/custom_image.dart';
import 'package:my_coffee/constants/text_styles_constants.dart';
import '../constants/color_constants.dart';
import '../constants/image_assets_constants.dart';
import '../lang/translation_service_key.dart';
import '../routes/route_constants.dart';

class AppBarsCommon {
  AppBarsCommon._();

  static PreferredSizeWidget appNoBar() {
    return PreferredSize(
        preferredSize: Size.fromHeight(1.sp),
        child: AppBar(
          backgroundColor: ColorConstants.primaryBackgroundColor,
        ));
  }

  static PreferredSizeWidget appBar({
    double dTitleSpacing = 0.0,
    Color backgroundColor = ColorConstants.cAppColors,
    Color iconColor = Colors.black,
    String title = "",
    Function? onClick,
  }) {
    return PreferredSize(
      preferredSize: Size.fromHeight(26.sp),
      child: AppBar(
        toolbarHeight: 26.sp,
        titleSpacing: dTitleSpacing,
        bottomOpacity: 0.6,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 20.sp,
            ),
            Image.asset(
              ImageAssetsConstants.appLogo,
              fit: BoxFit.fitWidth,
              height: 25.5.sp,
              width: 25.5.sp,
            ),
            SizedBox(
              width: 13.sp,
            ),
            Text(
              title,
              style: getText600(colors: Colors.black, size: 18.5.sp),
            ),
            Container(
              width: 50.sp,
            )
          ],
        ),
        centerTitle: false,
        iconTheme: const IconThemeData(
          color: Colors.black, //// change your color here
        ),
        backgroundColor: ColorConstants.primaryBackgroundColor,
      ),
    );
  }

  static PreferredSizeWidget appBarNoBack({
    double dTitleSpacing = 0.0,
    Color backgroundColor = ColorConstants.cAppColors,
    Color iconColor = Colors.black,
    String title = "",
    Function? onClick,
  }) {
    return PreferredSize(
      preferredSize: Size.fromHeight(40.sp),
      child: Container(
        padding: EdgeInsets.only(top: 5.h),
        height: 40.sp,
        decoration: const BoxDecoration(
            color: ColorConstants.primaryBackgroundColor,
            boxShadow: [
              BoxShadow(
                  color: Color(0x33000000),
                  offset: Offset(0, 2),
                  blurRadius: 4),
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 13.sp,
            ),
            GestureDetector(
              onTap: () {
                Get.back(result: '');
              },
              child: const Icon(Icons.arrow_back_ios_new),
            ),
            SizedBox(
              width: 10.sp,
            ),
            Image.asset(
              ImageAssetsConstants.appLogoT,
              fit: BoxFit.fitWidth,
              height: 25.5.sp,
              width: 25.5.sp,
            ),
            SizedBox(
              width: 13.sp,
            ),
            Text(
              title,
              style: getText600(colors: Colors.black, size: 18.sp),
            ),
            Container(
              width: 50.sp,
            )
          ],
        ),
      ),
    );
  }

  static PreferredSizeWidget appBarBack({
    double dTitleSpacing = 0.0,
    Color backgroundColor = ColorConstants.cAppColors,
    Color iconColor = Colors.black,
    String title = "",
    Function? onClick,
  }) {
    return PreferredSize(
      preferredSize: Size.fromHeight(40.sp),
      child: Container(
        padding: EdgeInsets.only(top: 5.h),
        height: 40.sp,
        decoration: const BoxDecoration(
            color: ColorConstants.primaryBackgroundColor,
            boxShadow: [
              BoxShadow(
                  color: Color(0x33000000),
                  offset: Offset(0, 2),
                  blurRadius: 4),
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 13.sp,
            ),
            GestureDetector(
              onTap: () {
                Get.back(result: '');
              },
              child: const Icon(Icons.arrow_back_ios_new),
            ),
            SizedBox(
              width: 10.sp,
            ),
            Image.asset(
              ImageAssetsConstants.appLogoT,
              fit: BoxFit.fitWidth,
              height: 25.5.sp,
              width: 25.5.sp,
            ),
            SizedBox(
              width: 13.sp,
            ),
            Text(
              title,
              style: getText500(colors: ColorConstants.buttonBar, size: 16.sp),
            ),
            Container(
              width: 50.sp,
            )
          ],
        ),
      ),
    );
  }

  static PreferredSizeWidget appBarLocation({
    double dTitleSpacing = 0.0,
    Color backgroundColor = ColorConstants.cAppColors,
    Color iconColor = Colors.black,
    String title = "",
    Function? onClick,
  }) {
    return PreferredSize(
      preferredSize: Size.fromHeight(40.sp),
      child: Container(
        padding: EdgeInsets.only(top: 5.h),
        height: 40.sp,
        decoration: const BoxDecoration(
            color: ColorConstants.primaryBackgroundColor,
            boxShadow: [
              BoxShadow(
                  color: Color(0x33000000),
                  offset: Offset(0, 2),
                  blurRadius: 4),
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 13.sp,
            ),
            GestureDetector(
              onTap: () {
                Get.back(result: '');
              },
              child: const Icon(Icons.arrow_back_ios_new),
            ),
            SizedBox(
              width: 10.sp,
            ),
            Image.asset(
              ImageAssetsConstants.appLogoT,
              fit: BoxFit.fitWidth,
              height: 25.5.sp,
              width: 25.5.sp,
            ),
            SizedBox(
              width: 13.sp,
            ),
            Expanded(child: Text(
              title,
              style: getText500(colors: ColorConstants.buttonBar, size: 16.sp),
            ),),
            Image.asset(
              ImageAssetsConstants.homeLocation,
              fit: BoxFit.fitWidth,
              height: 22.sp,
              width: 22.sp,
            ),
            Container(
              width: 15.sp,
            )
          ],
        ),
      ),
    );
  }

  static  appBarNotification({
    double dTitleSpacing = 0.0,
    Color backgroundColor = ColorConstants.primaryBackgroundColor,
    Color iconColor = Colors.black,
    String title = "",
    Function? onClick,
  }) {
    return Container(
          padding: EdgeInsets.only(top: 5.h),
          height: 40.sp,
          decoration: const BoxDecoration(
              color: ColorConstants.primaryBackgroundColor,
              boxShadow: [
                BoxShadow(
                    color: Color(0x33000000),
                    offset: Offset(0, 2),
                    blurRadius: 4),
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 18.sp,
              ),
              ColorFiltered(
                  colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.modulate),
                  child: Image.asset(
                    ImageAssetsConstants.appLogoT,
                    fit: BoxFit.fitWidth,
                    height: 25.5.sp,
                    width: 25.5.sp,
                  )),
              SizedBox(
                width: 13.sp,
              ),
              Expanded(
                child: Text(
                  title,
                  style: getText600(colors: Colors.black, size: 18.sp),
                ),
              ),
              GestureDetector(
                onTap: () {
                  onClick!("notification");
                },
                child: Image.asset(
                  ImageAssetsConstants.notification,
                  fit: BoxFit.fitWidth,
                  height: 25.5.sp,
                  width: 25.5.sp,
                ),
              ),
              SizedBox(
                width: 13.sp,
              ),
            ],
          ),
        );
  }
}
