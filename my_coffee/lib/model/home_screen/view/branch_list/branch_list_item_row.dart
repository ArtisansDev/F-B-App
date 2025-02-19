import 'package:f_b_base/data/mode/get_all_branches_by_restaurant_id/get_all_branches_by_restaurant_id_response.dart';
import 'package:f_b_base/utils/date_format.dart';
import 'package:f_b_base/utils/open_url.dart';
import 'package:my_coffee/alert/app_alert.dart';
import 'package:f_b_base/alert/app_alert_base.dart';
import 'package:f_b_base/common/create_card_view.dart';
import 'package:f_b_base/common/custom_image.dart';
import 'package:f_b_base/constants/color_constants.dart';
import 'package:f_b_base/constants/image_assets_constants.dart';
import 'package:f_b_base/constants/text_styles_constants.dart';
import 'package:f_b_base/data/local/shared_prefs/shared_prefs.dart';
import 'package:f_b_base/data/mode/add_cart/add_cart.dart';
import 'package:f_b_base/data/mode/get_best_seller_item/get_best_seller_item_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../alert/app_alert.dart';
import '../../../location_list_screen/controller/location_list_controller.dart';
import '../../controller/home_controller.dart';

class BranchListItemRow extends StatelessWidget {
  final int index;
  late HomeScreenController controller;

  BranchListItemRow({super.key, required this.index}) {
    controller = Get.find<HomeScreenController>();
  }

  @override
  Widget build(BuildContext context) {
    GetAllBranchesListData mGetAllBranchesListData =
        controller.mGetAllBranchesListData[index];
    return GestureDetector(
      onTap: () {},
      child: SizedBox(
        width: 75.w,
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
                              style:
                                  getText600(size: 16.sp, colors: Colors.red),
                            )
                          : Row(
                              children: [
                                Text(
                                  timeCheck(
                                          mGetAllBranchesListData.fromTime ??
                                              '0:0',
                                          mGetAllBranchesListData.toTime ??
                                              '0:0')
                                      ? 'Open'
                                      : 'Close',
                                  style: getText600(
                                      size: 16.sp,
                                      colors: timeCheck(
                                              mGetAllBranchesListData
                                                      .fromTime ??
                                                  '0:0',
                                              mGetAllBranchesListData.toTime ??
                                                  '0:0')
                                          ? Colors.green
                                          : Colors.red),
                                ),
                                const Text('  |  '),
                                timeCheck(
                                        mGetAllBranchesListData.fromTime ??
                                            '0:0',
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
                          makePhoneCall(
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
                                child: Text(
                                    mGetAllBranchesListData.address ?? '',
                                    maxLines: 3,
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
      ),
    );
  }
}
