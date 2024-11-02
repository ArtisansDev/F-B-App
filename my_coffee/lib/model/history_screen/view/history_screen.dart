import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:my_coffee/constants/color_constants.dart';
import 'package:my_coffee/constants/text_styles_constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../common/button_constants.dart';
import '../../../lang/translation_service_key.dart';
import '../../../utils/app_utils.dart';
import '../controller/history_controller.dart';

class HistoryScreen extends GetView<HistoryScreenController> {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => HistoryScreenController());
    return  FocusDetector(
        onVisibilityGained: () {},
        onVisibilityLost: () {
          Get.delete<HistoryScreenController>();
        },
        child: GestureDetector(
            onTap: () {
              AppUtils.hideKeyboard(Get.context!);
            },
            child: Container(
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      historyListView(),
                      SizedBox(
                        height: 10.h,
                      )
                    ],
                  ),
                ))));
  }

 /// History list
  historyListView() {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.only(
                left: 18.sp, right: 18.sp, top: 15.sp),
            padding: EdgeInsets.all(14.sp),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(13.sp),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///branch
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 7,
                        child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.start,
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text('Branch Name',
                                maxLines: 2,
                                style: getText600(
                                    size: 16.sp,
                                    colors: ColorConstants
                                        .cAppColorsBlue)),
                            Text('city, State -70075',
                                maxLines: 2,
                                style: getTextRegular(
                                    size: 14.sp,
                                    colors: ColorConstants
                                        .appVersion))
                          ],
                        )),
                    Expanded(
                        flex: 5,
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Text('14-10-2024 | 15.50',
                              style: getTextRegular(
                                  size: 15.sp,
                                  colors: ColorConstants
                                      .appVersion)),
                        ))
                  ],
                ),

                ///top line
                Container(
                  height: 2.5.sp,
                  width: double.infinity,
                  margin: EdgeInsets.only(
                      top: 12.sp, bottom: 12.sp),
                  color: ColorConstants.appVersion,
                ),

                ///Item
                Container(
                  margin: EdgeInsets.only(bottom: 10.sp),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.start,
                    crossAxisAlignment:
                    CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 7,
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.start,
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text('Item Name',
                                  maxLines: 1,
                                  style: getText600(
                                      size: 16.sp,
                                      colors: ColorConstants
                                          .buttonBar)),
                              Text('sweet, regular',
                                  maxLines: 1,
                                  style: getTextRegular(
                                      size: 14.sp,
                                      colors: ColorConstants
                                          .buttonBar))
                            ],
                          )),
                      Expanded(
                          flex: 2,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text('X1',
                                style: getText600(
                                    size: 15.sp,
                                    colors: ColorConstants
                                        .buttonBar)),
                          )),
                      Expanded(
                          flex: 4,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text('RM 5.50',
                                style: getText600(
                                    size: 15.sp,
                                    colors: ColorConstants
                                        .cAppColorsBlue)),
                          ))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10.sp),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.start,
                    crossAxisAlignment:
                    CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 7,
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.start,
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text('Item Name',
                                  maxLines: 1,
                                  style: getText600(
                                      size: 16.sp,
                                      colors: ColorConstants
                                          .buttonBar)),
                              Text('sweet, regular',
                                  maxLines: 1,
                                  style: getTextRegular(
                                      size: 14.sp,
                                      colors: ColorConstants
                                          .buttonBar))
                            ],
                          )),
                      Expanded(
                          flex: 2,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text('X1',
                                style: getText600(
                                    size: 15.sp,
                                    colors: ColorConstants
                                        .buttonBar)),
                          )),
                      Expanded(
                          flex: 4,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text('RM 5.50',
                                style: getText600(
                                    size: 15.sp,
                                    colors: ColorConstants
                                        .cAppColorsBlue)),
                          ))
                    ],
                  ),
                ),

                ///end line
                Container(
                  height: 2.5.sp,
                  width: double.infinity,
                  margin: EdgeInsets.only(
                      top: 12.sp, bottom: 12.sp),
                  color: ColorConstants.appVersion,
                ),

                ///reorder
                Container(
                  width: 45.w,
                  margin: EdgeInsets.only(top: 10.sp),
                  child: rectangleRoundedCornerButtonMedium(
                      sReorder.tr, () {
                    // controller.orderNow();
                  },
                      bgColor: ColorConstants.cAppColorsBlue,
                      textColor: Colors.white,
                      height: 26.sp,
                      size: 15.5.sp),
                )
              ],
            ),
          );
        });
  }
}
