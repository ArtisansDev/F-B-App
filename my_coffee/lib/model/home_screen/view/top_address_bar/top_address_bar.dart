/*
 * Project      : my_coffee
 * File         : top_address_bar.dart
 * Description  : 
 * Author       : parthapaul
 * Date         : 2024-10-25
 * Version      : 1.0
 * Ticket       : 
 */
import 'package:f_b_base/common/custom_image.dart';
import 'package:f_b_base/constants/color_constants.dart';
import 'package:f_b_base/constants/image_assets_constants.dart';
import 'package:f_b_base/constants/text_styles_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../controller/home_controller.dart';

class TopHomeAddressBar extends StatelessWidget {
  late HomeScreenController controller;

  TopHomeAddressBar({super.key}) {
    controller = Get.find<HomeScreenController>();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(18.sp),
          padding: EdgeInsets.only(left: 18.sp, right: 6.sp),
          width: double.infinity,
          height: 27.sp,
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
            ],
          ),
          child: Row(
            children: [
              GestureDetector(
                  onTap: () {
                    controller.changeLocation();
                  },
                  child: SizedBox(
                    child: setImage(ImageAssetsConstants.homeLocation),
                    height: 20.sp,
                    width: 20.sp,
                  )),
              SizedBox(
                width: 15.sp,
              ),
              Expanded(
                child: GestureDetector(
                    onTap: () {
                      controller.changeLocation();
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Text(
                        controller
                                .mDashboardScreenController
                                .selectGetAllBranchesListData
                                .value
                                .branchName ??
                            'Please select the branch',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: getText500(
                            colors: ColorConstants.buttonBar, size: 16.sp),
                      ),
                    )),
              ),
            ],
          ),
        )
      ],
    );
  }
}
