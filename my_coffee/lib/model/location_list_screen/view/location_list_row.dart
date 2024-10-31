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
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../common/create_card_view.dart';
import '../../../common/custom_image.dart';
import '../../../constants/color_constants.dart';
import '../../../constants/image_assets_constants.dart';
import '../../../constants/text_styles_constants.dart';
import '../../../data/mode/get_all_branches_by_restaurant_id/get_all_branches_by_restaurant_id_response.dart';
import '../../../lang/translation_service_key.dart';
import '../../../utils/date_format.dart';
import '../../../utils/open_url.dart';
import '../../dashboard_screen/controller/dashboard_controller.dart';
import '../../login_screen/controller/login_controller.dart';
import '../controller/location_list_controller.dart';

class LocationListRow extends StatelessWidget {
  late LocationListScreenController controller;
  final int index;

  LocationListRow({super.key, required this.index}) {
    controller = Get.find<LocationListScreenController>();
  }

  @override
  Widget build(BuildContext context) {
    GetAllBranchesListData mGetAllBranchesListData =
        controller.mGetAllBranchesListData.value[index];
    return GestureDetector(
      onTap: () {
        if (Get.isRegistered<DashboardScreenController>()) {
          DashboardScreenController mDashboardScreenController =
              Get.find<DashboardScreenController>();
          mDashboardScreenController.setLocation(mGetAllBranchesListData);
        }
      },
      child: getCardView(
          paddingLeftRight: 0,
          paddingTopBottom: 0,
          Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(11.sp),
                    topRight: Radius.circular(11.sp)),
                // Image border
                child: Image.asset(index % 2 == 0
                    ? ImageAssetsConstants.location1
                    : ImageAssetsConstants.location2),
              ),
              Container(
                margin: EdgeInsets.all(17.sp),
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mGetAllBranchesListData.branchName ?? '',
                      style: getText600(
                          colors: ColorConstants.buttonBar, size: 16.5.sp),
                    ),
                    SizedBox(
                      height: 5.sp,
                    ),
                    ((time24to12Format(
                                    mGetAllBranchesListData.fromTime ?? '0:0')
                                .contains('0:00')) &&
                            (time24to12Format(
                                    mGetAllBranchesListData.toTime ?? '0:0')
                                .contains('0:00')))
                        ? Text(
                            'Close',
                            style: getText600(size: 16.sp, colors: Colors.red),
                          )
                        : Row(
                            children: [
                              Text(
                                timeCheck(
                                        mGetAllBranchesListData.fromTime ??
                                            '0:0',
                                        mGetAllBranchesListData.toTime ?? '0:0')
                                    ? 'Open'
                                    : 'Close',
                                style: getText600(
                                    size: 16.sp,
                                    colors: timeCheck(
                                            mGetAllBranchesListData.fromTime ??
                                                '0:0',
                                            mGetAllBranchesListData.toTime ??
                                                '0:0')
                                        ? Colors.green
                                        : Colors.red),
                              ),
                              const Text('  |  '),
                              timeCheck(
                                      mGetAllBranchesListData.fromTime ?? '0:0',
                                      mGetAllBranchesListData.toTime ?? '0:0')
                                  ? Text(
                                      'Close at ${time24to12Format(mGetAllBranchesListData.toTime ?? '0:0')}',
                                      style: getTextRegular(
                                          size: 16.sp,
                                          colors: ColorConstants.buttonBar))
                                  : Text(
                                      'Open at ${time24to12Format(mGetAllBranchesListData.fromTime ?? '0:0')}',
                                      style: getTextRegular(
                                          size: 16.sp,
                                          colors: ColorConstants.buttonBar)),
                            ],
                          ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    GestureDetector(
                      onTap: () {
                        openLaunchUrlWp(
                            mGetAllBranchesListData.mobileNumber ?? '');
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            height: 21.sp,
                            width: 21.sp,
                            child: setImage(ImageAssetsConstants.edit3),
                          ),
                          SizedBox(
                            width: 17.sp,
                          ),
                          Expanded(
                            child: Text(
                                mGetAllBranchesListData.mobileNumber ?? '',
                                style: getTextRegular(
                                    size: 16.sp,
                                    colors: ColorConstants.buttonBar)),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    GestureDetector(
                        onTap: () {
                          openGoogleMapsAddress(
                              mGetAllBranchesListData.address ?? '');
                        },
                        child: Row(
                          children: [
                            SizedBox(
                              height: 21.sp,
                              width: 21.sp,
                              child: setImage(
                                  ImageAssetsConstants.homeLocationPin),
                            ),
                            SizedBox(
                              width: 17.sp,
                            ),
                            Expanded(
                              child: Text(mGetAllBranchesListData.address ?? '',
                                  style: getTextRegular(
                                      size: 16.sp,
                                      colors: ColorConstants.buttonBar)),
                            )
                          ],
                        )),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
