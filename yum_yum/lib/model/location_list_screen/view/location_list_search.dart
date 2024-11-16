/*
 * Project      : my_coffee
 * File         : dashboard_navigation.dart
 * Description  : 
 * Author       : parthapaul
 * Date         : 2024-09-21
 * Version      : 1.0
 * Ticket       : 
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../common/create_card_view.dart';
import '../../../common/custom_image.dart';
import '../../../common/text_input_widget.dart';
import '../../../constants/color_constants.dart';
import '../../../constants/image_assets_constants.dart';
import '../../../constants/pattern_constants.dart';
import '../../../constants/text_styles_constants.dart';
import '../../../lang/translation_service_key.dart';
import '../../dashboard_screen/controller/dashboard_controller.dart';
import '../../login_screen/controller/login_controller.dart';
import '../controller/location_list_controller.dart';

class LocationListSearch extends StatelessWidget {
  late LocationListScreenController controller;

  LocationListSearch({super.key}) {
    controller = Get.find<LocationListScreenController>();
  }

  @override
  Widget build(BuildContext context) {
    return searchView();
  }

  searchView() {
    return Container(
        height: 28.sp,
        margin: EdgeInsets.only(
            left: 10.sp, right: 10.sp, top: 10.sp, bottom: 15.sp),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(35.sp),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.22),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 0), // changes position of shadow
            ),
          ], // use instead of BorderRadius.all(Radius.circular(20))
        ),
        child: Row(
          children: [
            SizedBox(
              width: 17.5.sp,
            ),
            SizedBox(
              height: 18.sp,
              width: 18.sp,
              child: setImage(ImageAssetsConstants.homeSearch),
            ),
            Expanded(
                child: TextInputWidget(
                  controller: controller.searchController.value,
                  showFloatingLabel: false,
                  placeHolder: sSearchforTWTOutlets.tr,
                  onSubmitted: (value) {
                    controller.onRefresh();
                  },
                  hintText: sSearchforTWTOutlets.tr,
                  errorText: null,
                  prefixHeight: 27.5.sp,
                  onFilteringTextInputFormatter: [
                    FilteringTextInputFormatter.allow(
                      RegExp(AppUtilConstants.patternStringAndSpace),
                    ),
                  ],
                ))
          ],
        ));
  }
}
