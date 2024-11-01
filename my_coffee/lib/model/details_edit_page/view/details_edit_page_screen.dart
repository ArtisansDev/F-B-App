import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:my_coffee/common/custom_image.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:my_coffee/constants/text_styles_constants.dart';

import '../../../../common/appbars_common.dart';
import '../../../../common/button_constants.dart';
import '../../../../common/text_input_widget.dart';
import '../../../../constants/color_constants.dart';
import '../../../../constants/pattern_constants.dart';
import '../../../../lang/translation_service_key.dart';
import '../../../../routes/route_constants.dart';
import '../../../../utils/app_utils.dart';
import '../../../constants/image_assets_constants.dart';
import '../../order_confirmation/controller/order_confirmation_controller.dart';
import '../controller/details_edit_page_controller.dart';

class DetailsEditPageScreen extends GetView<DetailsEditPageController> {
  late int itemId = 0;

  DetailsEditPageScreen({super.key}) {
    itemId = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => DetailsEditPageController(itemId));
    return Scaffold(
        appBar: AppBarsCommon.appBarBack(title: 'Classic Americano'),
        body: SafeArea(bottom: false, child: _fullView()));
  }

  ///full_View
  _fullView() {
    return FocusDetector(
        onVisibilityGained: () {
          // if (Get.isRegistered<OrderConfirmationScreenController>()) {
          //   Get.delete<OrderConfirmationScreenController>();
          // }
        },
        onVisibilityLost: () {
          Get.delete<DetailsEditPageController>();
        },
        child: GestureDetector(
            onTap: () {
              AppUtils.hideKeyboard(Get.context!);
            },
            child: Container(
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.center,
                child: Obx(() {
                  if ((controller.mGetItemDetailsData.value.itemName ?? '')
                      .isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Stack(
                      children: [
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Image.asset(
                            ImageAssetsConstants.buttonLogo,
                            width: 40.w,
                            fit: BoxFit.contain,
                          ),
                        ),
                        mDetailsView(),
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: _bottomBar()
                            // }),
                            )
                      ],
                    );
                  }
                }))));
  }

  mDetailsView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 5.h,
          ),

          SizedBox(
              height: 18.8.h,
              child: PageView.builder(
                controller: controller.introductionPageController.value,
                itemCount: controller.itemImages.value.length,
                itemBuilder: (context, index) {
                  return cacheImageHomeBanner(
                    controller.itemImages.value[index].itemImagePath ?? '',
                    ImageAssetsConstants.backLogo,
                    18.8.h,
                  );
                },
                onPageChanged: (value) {},
              )),

          // Stack(
          //   alignment: Alignment.center,
          //   children: [
          //     Container(
          //       height: 18.8.h,
          //       alignment: Alignment.topCenter,
          //       margin: EdgeInsets.only(right: 10.5.sp),
          //       child: Image.asset(
          //         ImageAssetsConstants.backLogo,
          //         fit: BoxFit.fitHeight,
          //         height: 16.h,
          //       ),
          //     ),
          //     Container(
          //         height: 18.8.h,
          //         alignment: Alignment.bottomCenter,
          //         child: Image.asset(
          //           ImageAssetsConstants.coffee,
          //           fit: BoxFit.fitHeight,
          //           height: 17.3.h,
          //         )),
          //   ],
          // ),
          Container(
            margin: EdgeInsets.only(left: 15.sp, right: 15.sp, top: 20.sp),
            alignment: Alignment.center,
            child: Text(
              controller.mGetItemDetailsData.value.itemName ?? '',
              textAlign: TextAlign.center,
              style: getTextBold(
                  size: 17.sp, colors: ColorConstants.cAppColorsBlue),
            ),
          ),
          // Container(
          //   margin: EdgeInsets.only(left: 15.sp, right: 15.sp, top: 13.sp),
          //   alignment: Alignment.topCenter,
          //   child: Text(
          //     'White Peach Oolong Cham Latte',
          //     textAlign: TextAlign.center,
          //     maxLines: 2,
          //     style: getText600(
          //         size: 16.sp, colors: ColorConstants.buttonBar, heights: 1.3),
          //   ),
          // ),
          // Container(
          //   margin: EdgeInsets.only(left: 15.sp, right: 15.sp, top: 10.sp),
          //   alignment: Alignment.topCenter,
          //   child: Text(
          //     controller.getNutritionalInfo(),
          //     textAlign: TextAlign.center,
          //     maxLines: 2,
          //     style: getTextRegular(
          //         size: 14.sp, colors: ColorConstants.buttonBar, heights: 1.3),
          //   ),
          // ),
          Container(
            margin: EdgeInsets.only(left: 15.sp, right: 15.sp, top: 13.sp),
            alignment: Alignment.topCenter,
            child: HtmlWidget(
              controller.mGetItemDetailsData.value.description ?? '',
              // textAlign: TextAlign.center,
              // maxLines: 2,,
              textStyle: getText500(
                  size: 15.sp, colors: ColorConstants.buttonBar, heights: 1.3),
            ),
          ),

          ///Variant
          Container(
            margin: EdgeInsets.only(left: 19.sp, right: 19.sp, top: 22.sp),
            alignment: Alignment.topCenter,
            child: Row(
              children: [
                Container(
                  width: 24.sp,
                  height: 24.sp,
                  margin: EdgeInsets.only(right: 13.sp),
                  child: setImage(
                    ImageAssetsConstants.temperature,
                    fit: BoxFit.fill,
                  ),
                ),
                Text(
                  'Variant',
                  style: getText600(
                      colors: ColorConstants.cAppColorsBlue, size: 18.sp),
                )
              ],
            ),
          ),
          Visibility(
            visible: (controller.mVariantData.value ?? []).isNotEmpty,
            child: controller.mTagVariantDateView
                .yourKeySkillsView(controller.mVariantData.value ?? []),
          ),

          ///Modifier
          Visibility(
              visible: (controller.mModifierData.value ?? []).isNotEmpty,
              child: Container(
                margin: EdgeInsets.only(left: 19.sp, right: 19.sp, top: 22.sp),
                alignment: Alignment.topCenter,
                child: Row(
                  children: [
                    Container(
                      width: 24.sp,
                      height: 24.sp,
                      margin: EdgeInsets.only(right: 13.sp),
                      child: setImage(
                        ImageAssetsConstants.temperature,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Text(
                      'Modifier',
                      style: getText600(
                          colors: ColorConstants.cAppColorsBlue, size: 18.sp),
                    )
                  ],
                ),
              )),
          Visibility(
            visible: (controller.mModifierData.value ?? []).isNotEmpty,
            child: controller.mTagModifierDateView
                .yourKeySkillsView(controller.mModifierData.value ?? []),
          ),

          // ///Temperature
          // Container(
          //   margin: EdgeInsets.only(left: 19.sp, right: 19.sp, top: 22.sp),
          //   alignment: Alignment.topCenter,
          //   child: Row(
          //     children: [
          //       Container(
          //         width: 24.sp,
          //         height: 24.sp,
          //         margin: EdgeInsets.only(right: 13.sp),
          //         child: setImage(
          //           ImageAssetsConstants.temperature,
          //           fit: BoxFit.fill,
          //         ),
          //       ),
          //       Text(
          //         'Temperature',
          //         style: getText600(
          //             colors: ColorConstants.cAppColorsBlue, size: 18.sp),
          //       )
          //     ],
          //   ),
          // ),
          // Container(
          //   child: controller.mTemperature.yourKeySkillsView(),
          // ),
          //
          // ///Milk
          // Container(
          //   margin: EdgeInsets.only(left: 19.sp, right: 19.sp, top: 8.sp),
          //   alignment: Alignment.topCenter,
          //   child: Row(
          //     children: [
          //       Container(
          //         width: 24.sp,
          //         height: 24.sp,
          //         margin: EdgeInsets.only(right: 13.sp),
          //         child: setImage(
          //           ImageAssetsConstants.milk,
          //           fit: BoxFit.fill,
          //         ),
          //       ),
          //       Text(
          //         'Milk',
          //         style: getText600(
          //             colors: ColorConstants.cAppColorsBlue, size: 18.sp),
          //       ),
          //       SizedBox(
          //         width: 13.sp,
          //       ),
          //       Text(
          //         'Pack 1',
          //         style:
          //             getText500(colors: ColorConstants.buttonBar, size: 14.sp),
          //       )
          //     ],
          //   ),
          // ),
          // Container(
          //   child: controller.mMilk.yourKeySkillsView(),
          // ),
          //
          // ///Coffee
          // Container(
          //   margin: EdgeInsets.only(left: 19.sp, right: 19.sp, top: 8.sp),
          //   alignment: Alignment.topCenter,
          //   child: Row(
          //     children: [
          //       Container(
          //         width: 24.sp,
          //         height: 24.sp,
          //         margin: EdgeInsets.only(right: 13.sp),
          //         child: setImage(
          //           ImageAssetsConstants.coffeeDetails,
          //           fit: BoxFit.fill,
          //         ),
          //       ),
          //       Text(
          //         'Coffee',
          //         style: getText600(
          //             colors: ColorConstants.cAppColorsBlue, size: 18.sp),
          //       ),
          //       SizedBox(
          //         width: 13.sp,
          //       ),
          //       Text(
          //         'Pack 1',
          //         style:
          //             getText500(colors: ColorConstants.buttonBar, size: 14.sp),
          //       )
          //     ],
          //   ),
          // ),
          // Container(
          //   child: controller.mCoffee.yourKeySkillsView(),
          // ),
          //
          // ///Sweetness
          // Container(
          //   margin: EdgeInsets.only(left: 19.sp, right: 19.sp, top: 8.sp),
          //   alignment: Alignment.topCenter,
          //   child: Row(
          //     children: [
          //       Container(
          //         width: 24.sp,
          //         height: 24.sp,
          //         margin: EdgeInsets.only(right: 13.sp),
          //         child: setImage(
          //           ImageAssetsConstants.sweetness,
          //           fit: BoxFit.fill,
          //         ),
          //       ),
          //       Text(
          //         'Sweetness',
          //         style: getText600(
          //             colors: ColorConstants.cAppColorsBlue, size: 18.sp),
          //       ),
          //       SizedBox(
          //         width: 13.sp,
          //       ),
          //       Text(
          //         'Pack 1',
          //         style:
          //             getText500(colors: ColorConstants.buttonBar, size: 14.sp),
          //       )
          //     ],
          //   ),
          // ),
          // Container(
          //   child: controller.mSweetness.yourKeySkillsView(),
          // ),

          ///About Drink
          // Container(
          //   margin: EdgeInsets.only(left: 19.sp, right: 19.sp, top: 8.sp),
          //   alignment: Alignment.topCenter,
          //   child: Row(
          //     children: [
          //       Text(
          //         'About Drink',
          //         style: getText600(
          //             colors: ColorConstants.cAppColorsBlue, size: 18.sp),
          //       ),
          //     ],
          //   ),
          // ),
          // Container(
          //     margin: EdgeInsets.only(left: 18.sp, right: 18.sp),
          //     child: Row(
          //       children: [
          //         SizedBox(
          //           height: 20.h,
          //           child: setImage(ImageAssetsConstants.mockup),
          //         ),
          //         Expanded(
          //             child: Container(
          //           margin:
          //               EdgeInsets.only(left: 15.sp, right: 15.sp, top: 13.sp),
          //           alignment: Alignment.topCenter,
          //           child: Text(
          //             'Did you know?\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. \n\nSed do eiusmod tempor ncididunt ut labore et dolore magna aliqua. ',
          //             textAlign: TextAlign.left,
          //             style: getTextRegular(
          //                 size: 14.5.sp,
          //                 colors: ColorConstants.buttonBar,
          //                 heights: 1.3),
          //           ),
          //         ))
          //       ],
          //     )),
          // Container(
          //   margin: EdgeInsets.only(left: 15.sp, right: 15.sp, top: 13.sp),
          //   alignment: Alignment.topCenter,
          //   child: Text(
          //     'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ',
          //     textAlign: TextAlign.center,
          //     style: getTextRegular(
          //         size: 14.5.sp,
          //         colors: ColorConstants.buttonBar,
          //         heights: 1.3),
          //   ),
          // ),

          ///Ingredients
          // Container(
          //   margin: EdgeInsets.only(left: 19.sp, right: 19.sp, top: 18.sp),
          //   alignment: Alignment.topCenter,
          //   child: Row(
          //     children: [
          //       Text(
          //         'Ingredients',
          //         style: getText600(
          //             colors: ColorConstants.cAppColorsBlue, size: 18.sp),
          //       ),
          //     ],
          //   ),
          // ),
          // Container(
          //   margin: EdgeInsets.only(left: 18.sp, right: 18.sp, top: 18.sp),
          //   child: Row(
          //     children: [
          //       SizedBox(
          //         height: 8.h,
          //         width: 8.h,
          //         child: setImage(ImageAssetsConstants.milkBottle),
          //       ),
          //       Container(
          //         width: 10.w,
          //         alignment: Alignment.center,
          //         child: Text(
          //           '+',
          //           style: getText500(
          //               colors: ColorConstants.buttonBar, size: 20.sp),
          //         ),
          //       ),
          //       SizedBox(
          //         height: 8.h,
          //         width: 8.h,
          //         child: setImage(ImageAssetsConstants.coffeeBottle),
          //       ),
          //       Container(
          //         width: 10.w,
          //         alignment: Alignment.center,
          //         child: Text(
          //           '+',
          //           style: getText500(
          //               colors: ColorConstants.buttonBar, size: 20.sp),
          //         ),
          //       ),
          //       SizedBox(
          //         height: 8.h,
          //         width: 8.h,
          //         child: setImage(ImageAssetsConstants.milkCreamBottle),
          //       ),
          //     ],
          //   ),
          // ),
          // Container(
          //   margin: EdgeInsets.only(left: 18.sp, right: 18.sp, top: 15.sp),
          //   child: Row(
          //     children: [
          //       SizedBox(
          //         width: 8.h,
          //         child: Text('   Milk',
          //             textAlign: TextAlign.center,
          //             style: getText500(
          //                 colors: ColorConstants.buttonBar, size: 15.sp)),
          //       ),
          //       Container(
          //         width: 10.w,
          //         alignment: Alignment.center,
          //         child: Text(
          //           '+',
          //           style: getText500(colors: Colors.transparent, size: 20.sp),
          //         ),
          //       ),
          //       SizedBox(
          //         width: 8.h,
          //         child: Text('   Coffee',
          //             textAlign: TextAlign.center,
          //             style: getText500(
          //                 colors: ColorConstants.buttonBar, size: 15.sp)),
          //       ),
          //       Container(
          //         width: 10.w,
          //         alignment: Alignment.center,
          //         child: Text(
          //           '+',
          //           style: getText500(colors: Colors.transparent, size: 20.sp),
          //         ),
          //       ),
          //       SizedBox(
          //         width: 8.h,
          //         child: Text('Milk Cream',
          //             textAlign: TextAlign.center,
          //             style: getText500(
          //                 colors: ColorConstants.buttonBar, size: 15.sp)),
          //       ),
          //     ],
          //   ),
          // ),

          ///Nutrition
          Visibility(
              visible:
                  (controller.mGetItemDetailsData.value.nutritionalInfo ?? '')
                      .isNotEmpty,
              child: Container(
                margin: EdgeInsets.only(left: 19.sp, right: 19.sp, top: 18.sp),
                alignment: Alignment.topCenter,
                child: Row(
                  children: [
                    Text(
                      'Nutrition',
                      style: getText600(
                          colors: ColorConstants.cAppColorsBlue, size: 18.sp),
                    ),
                  ],
                ),
              )),
          Container(
            margin: EdgeInsets.only(left: 15.sp, right: 15.sp, top: 12.sp),
            alignment: Alignment.center,
            child: HtmlWidget(
                controller.mGetItemDetailsData.value.nutritionalInfo ?? '',
                // textAlign: TextAlign.center,
                // maxLines: 2,
                textStyle: getTextRegular(
                    size: 16.sp,
                    colors: ColorConstants.buttonBar,
                    heights: 1.3)),
          ),

          ///Serving Size: 16oz
          // Container(
          //   margin: EdgeInsets.only(left: 19.sp, right: 19.sp, top: 18.sp),
          //   alignment: Alignment.topCenter,
          //   child: Row(
          //     children: [
          //       Text(
          //         'Serving Size: 16oz',
          //         style:
          //             getText600(colors: ColorConstants.buttonBar, size: 16.sp),
          //       ),
          //     ],
          //   ),
          // ),
          // Container(
          //   margin: EdgeInsets.only(left: 19.sp, right: 19.sp, top: 17.sp),
          //   child: Column(
          //     children: [
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Text(
          //             'Energy/Calories (Kcal)',
          //             style: getTextRegular(
          //                 size: 14.5.sp,
          //                 colors: ColorConstants.buttonBar,
          //                 heights: 1.3),
          //           ),
          //           Text(
          //             '359',
          //             style: getTextRegular(
          //                 size: 14.5.sp,
          //                 colors: ColorConstants.buttonBar,
          //                 heights: 1.3),
          //           )
          //         ],
          //       ),
          //       SizedBox(
          //         height: 10.sp,
          //       ),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Text(
          //             'Total Carbohydrate (g)',
          //             style: getTextRegular(
          //                 size: 14.5.sp,
          //                 colors: ColorConstants.buttonBar,
          //                 heights: 1.3),
          //           ),
          //           Text(
          //             '52',
          //             style: getTextRegular(
          //                 size: 14.5.sp,
          //                 colors: ColorConstants.buttonBar,
          //                 heights: 1.3),
          //           )
          //         ],
          //       ),
          //       SizedBox(
          //         height: 10.sp,
          //       ),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Text(
          //             'Sugar(g)',
          //             style: getTextRegular(
          //                 size: 14.5.sp,
          //                 colors: ColorConstants.buttonBar,
          //                 heights: 1.3),
          //           ),
          //           Text(
          //             '52',
          //             style: getTextRegular(
          //                 size: 14.5.sp,
          //                 colors: ColorConstants.buttonBar,
          //                 heights: 1.3),
          //           )
          //         ],
          //       ),
          //       SizedBox(
          //         height: 10.sp,
          //       ),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Text(
          //             'Protein(g)',
          //             style: getTextRegular(
          //                 size: 14.5.sp,
          //                 colors: ColorConstants.buttonBar,
          //                 heights: 1.3),
          //           ),
          //           Text(
          //             '5.2',
          //             style: getTextRegular(
          //                 size: 14.5.sp,
          //                 colors: ColorConstants.buttonBar,
          //                 heights: 1.3),
          //           )
          //         ],
          //       ),
          //       SizedBox(
          //         height: 10.sp,
          //       ),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Text(
          //             'Fat(g)',
          //             style: getTextRegular(
          //                 size: 14.5.sp,
          //                 colors: ColorConstants.buttonBar,
          //                 heights: 1.3),
          //           ),
          //           Text(
          //             '15.2',
          //             style: getTextRegular(
          //                 size: 14.5.sp,
          //                 colors: ColorConstants.buttonBar,
          //                 heights: 1.3),
          //           )
          //         ],
          //       ),
          //       SizedBox(
          //         height: 10.sp,
          //       ),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Text(
          //             'Sodium(mg)',
          //             style: getTextRegular(
          //                 size: 14.5.sp,
          //                 colors: ColorConstants.buttonBar,
          //                 heights: 1.3),
          //           ),
          //           Text(
          //             '3.3',
          //             style: getTextRegular(
          //                 size: 14.5.sp,
          //                 colors: ColorConstants.buttonBar,
          //                 heights: 1.3),
          //           )
          //         ],
          //       )
          //     ],
          //   ),
          // ),

          SizedBox(
            height: 20.h,
          )
        ],
      ),
    );
  }

  _bottomBar() {
    return Container(
      height: 18.h,
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 10.sp, right: 10.sp),
      decoration: BoxDecoration(
        color: ColorConstants.buttonBar.withOpacity(0.80),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.buttonBar.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, -2), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(11.sp),
          topLeft: Radius.circular(11.sp),
        ),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(18.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 55.w,
                      child: Text(
                        controller.sVariant.value,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: getText500(colors: Colors.white, size: 15.sp),
                      ),
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    Text(
                      'RM ${controller.totalAmount.value.toStringAsFixed(2)}',
                      style: getText600(
                          colors: ColorConstants.cAppColorsBlue, size: 17.sp),
                    ),
                  ],
                ),
                SizedBox(
                  width: 28.w,
                  child: incDecView(),
                )
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                  child: Container(
                // margin: EdgeInsets.only(left: 20.sp),
                // child: rectangleRoundedCornerButtonMedium(sBuyNow.tr, () {
                //   controller.buyNow();
                // },
                //     bgColor: Colors.white,
                //     textColor: ColorConstants.buttonBar,
                //     height: 28.sp,
                //     size: 17.sp),
              )),
              SizedBox(
                width: 20.sp,
              ),
              Expanded(
                  child: Container(
                margin: EdgeInsets.only(right: 20.sp),
                child: rectangleRoundedCornerButtonMedium(sEditOrder.tr, () {
                  controller.editOrder();
                },
                    bgColor: ColorConstants.cAppColorsBlue,
                    textColor: Colors.white,
                    height: 28.sp,
                    size: 17.sp),
              )),
            ],
          ),
        ],
      ),
    );
  }

  incDecView() {
    return Container(
        height: 25.sp,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11.sp),
            color: Colors.grey.shade400),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // Decrement button
            Container(
              height: 25.sp,
              width: 25.sp,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11.sp),
                  color: Colors.white),
              child: IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  if (controller.count.value != 1) {
                    controller.count.value = controller.count.value - 1;
                    controller.priceIncDec();
                  }
                },
                color: ColorConstants.buttonBar,
                iconSize: 17.sp,
              ),
            ),

            // Counter display
            Text(
              '${controller.count.value}',
              style:
                  getText500(colors: ColorConstants.buttonBar, size: 15.5.sp),
            ),

            // Increment button
            Container(
                height: 25.sp,
                width: 25.sp,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11.sp),
                    color: ColorConstants.cAppColorsBlue),
                child: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    controller.count.value = controller.count.value + 1;
                    controller.priceIncDec();
                  },
                  color: Colors.white,
                  iconSize: 17.sp,
                )),
          ],
        ));
  }
}
