import 'package:f_b_base/common/custom_image.dart';
import 'package:f_b_base/constants/color_constants.dart';
import 'package:f_b_base/constants/image_assets_constants.dart';
import 'package:f_b_base/constants/text_styles_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../alert/app_alert.dart';
import '../../../branch_location_list_screen/controller/branch_location_list_controller.dart';
import '../../controller/home_controller.dart';
import 'branch_list_item_row.dart';

class BranchListScreen extends StatelessWidget {
  late HomeScreenController controller;

  BranchListScreen({super.key}) {
    controller = Get.find<HomeScreenController>();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Visibility(
            visible: controller.mGetAllBranchesListData.isNotEmpty,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: 18.sp, right: 18.sp, top: 18.sp, bottom: 13.sp),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 21.sp,
                        width: 21.sp,
                        child: Icon(Icons.fastfood_outlined)
                        // setImage(ImageAssetsConstants.homeLocation,
                        //     fit: BoxFit.fill),
                      ),
                      SizedBox(
                        width: 15.sp,
                      ),
                      Expanded(
                          child: Text(
                        'Branches',
                        style: getTextRegular(
                            size: 16.5.sp, colors: ColorConstants.buttonBar),
                      )),
                      GestureDetector(
                        onTap: () async {
                          controller.changeBranchLocation();

                        },
                        child: Text(
                          'View All',
                          style: getTextRegular(
                              size: 16.5.sp, colors: ColorConstants.buttonBar),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(left: 18.sp, right: 20.sp),
                    height: 36.5.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.mGetAllBranchesListData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return BranchListItemRow(
                          index: index,
                        );
                      },
                    ))
              ],
            ));
      },
    );
  }
}
