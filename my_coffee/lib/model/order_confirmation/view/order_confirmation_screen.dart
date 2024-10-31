import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:my_coffee/model/order_confirmation/view/pick_up_at_view/pick_up_at_view.dart';
import 'package:my_coffee/model/order_confirmation/view/special_remarks/special_remarks_view.dart';
import 'package:my_coffee/utils/num_utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:my_coffee/constants/text_styles_constants.dart';
import '../../../common/appbars_common.dart';
import '../../../common/button_constants.dart';
import '../../../common/custom_image.dart';
import '../../../constants/color_constants.dart';
import '../../../constants/image_assets_constants.dart';
import '../../../lang/translation_service_key.dart';
import '../../../utils/app_utils.dart';
import '../controller/order_confirmation_controller.dart';
import 'order_list/order_list_view.dart';

class OrderConfirmationScreen
    extends GetView<OrderConfirmationScreenController> {
  const OrderConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => OrderConfirmationScreenController());
    return Scaffold(
        appBar: AppBarsCommon.appBarBack(title: sOrderConfirmation.tr),
        body: SafeArea(bottom: false, child: _fullView()));
  }

  ///full_View
  _fullView() {
    return FocusDetector(
        onVisibilityGained: () {},
        onVisibilityLost: () {},
        child: GestureDetector(
            onTap: () {
              AppUtils.hideKeyboard(Get.context!);
            },
            child: Container(
                height: double.infinity,
                width: double.infinity,
                color: ColorConstants.primaryBackgroundColor,
                alignment: Alignment.center,
                child: Obx(
                  () {
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
                        mOrderConfirmationView(),
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: _bottomBar())
                      ],
                    );
                  },
                ))));
  }

  mOrderConfirmationView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          ///Pick Up at
          PickUpAtView(),

          ///Your Order
          OrderListView(),

          // ///Frequently Enjoyed With
          // FrequentlyEnjoyedWithView(),

          ///Special Remarks
          SpecialRemarksView(),

          ///Packaging
          packaging(),

          ///Payment Method
          paymentMethod(),

          ///Vouchers
          addVouchers(),

          ///Payment Details
          paymentDetails(),

          SizedBox(
            height: 13.h,
          )
        ],
      ),
    );
  }

  packaging() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 19.sp, right: 19.sp, top: 18.sp),
          alignment: Alignment.topCenter,
          child: Row(
            children: [
              Text(
                'Packaging',
                style: getText600(
                    colors: ColorConstants.cAppColorsBlue, size: 17.sp),
              ),
            ],
          ),
        ),
        Container(
            margin: EdgeInsets.only(left: 19.sp, right: 19.sp, top: 17.sp),
            padding: EdgeInsets.all(12.sp),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(13.sp),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 12.sp,
                    ),
                    SizedBox(
                      height: 5.h,
                      width: 5.h,
                      child: setImage(ImageAssetsConstants.needStraws),
                    ),
                    SizedBox(
                      width: 13.sp,
                    ),
                    Expanded(
                        child: Text(
                      'I need Straws',
                      style: getText500(
                          size: 16.sp, colors: ColorConstants.buttonBar),
                    )),
                    const Icon(
                      Icons.check_box_rounded,
                      color: ColorConstants.cAppColorsBlue,
                    ),
                    SizedBox(
                      width: 12.sp,
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 12.sp, bottom: 12.sp),
                  width: double.infinity,
                  height: 4.sp,
                  color: Colors.grey.shade300,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 12.sp,
                    ),
                    SizedBox(
                      height: 5.h,
                      width: 5.h,
                      child: setImage(ImageAssetsConstants.bag),
                    ),
                    SizedBox(
                      width: 13.sp,
                    ),
                    Expanded(
                        child: Text(
                      'I need Paper Bag for my order',
                      style: getText500(
                          size: 16.sp, colors: ColorConstants.buttonBar),
                    )),
                    Icon(
                      Icons.check_box_outline_blank_rounded,
                      color: Colors.grey.shade300,
                    ),
                    SizedBox(
                      width: 12.sp,
                    ),
                  ],
                ),
              ],
            )),
      ],
    );
  }

  paymentMethod() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 19.sp, right: 19.sp, top: 18.sp),
          alignment: Alignment.topCenter,
          child: Row(
            children: [
              Text(
                'Payment Method',
                style: getText600(
                    colors: ColorConstants.cAppColorsBlue, size: 17.sp),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 19.sp, right: 19.sp, top: 17.sp),
          padding: EdgeInsets.all(12.sp),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13.sp),
          ),
          child: Row(
            children: [
              SizedBox(
                height: 5.h,
                width: 5.h,
                child: setImage(ImageAssetsConstants.addVoucher),
              ),
              SizedBox(
                width: 13.sp,
              ),
              Expanded(
                  child: Text(
                'Select Payment Method',
                style:
                    getText500(size: 16.sp, colors: ColorConstants.buttonBar),
              )),
            ],
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: 21.sp, right: 19.sp, top: 13.sp),
          child: Text(
            'Enjoy Faster checkout by paying with TWT Balance!',
            style: getTextRegular(
                size: 14.5.sp, colors: ColorConstants.buttonBar, heights: 1.3),
          ),
        ),
      ],
    );
  }

  addVouchers() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 19.sp, right: 19.sp, top: 18.sp),
          alignment: Alignment.topCenter,
          child: Row(
            children: [
              Text(
                'Vouchers',
                style: getText600(
                    colors: ColorConstants.cAppColorsBlue, size: 17.sp),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 19.sp, right: 19.sp, top: 17.sp),
          padding: EdgeInsets.all(12.sp),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13.sp),
          ),
          child: Row(
            children: [
              SizedBox(
                height: 5.h,
                width: 5.h,
                child: setImage(ImageAssetsConstants.addVoucher),
              ),
              SizedBox(
                width: 13.sp,
              ),
              Expanded(
                  child: Text(
                'Add Voucher',
                style:
                    getText500(size: 16.sp, colors: ColorConstants.buttonBar),
              )),
            ],
          ),
        ),
      ],
    );
  }

  paymentDetails() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 19.sp, right: 19.sp, top: 18.sp),
          alignment: Alignment.topCenter,
          child: Row(
            children: [
              Text(
                'Payment Details',
                style: getTextBold(
                    colors: ColorConstants.cAppColorsBlue, size: 17.sp),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 19.sp, right: 19.sp, top: 17.sp),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Amount (Incl. 6% SST)',
                    style: getTextRegular(
                        size: 14.5.sp,
                        colors: ColorConstants.buttonBar,
                        heights: 1.3),
                  ),
                  Text(
                    'RM 9.90',
                    style: getTextRegular(
                        size: 14.5.sp,
                        colors: ColorConstants.buttonBar,
                        heights: 1.3),
                  )
                ],
              ),
              SizedBox(
                height: 10.sp,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Voucher',
                    style: getTextRegular(
                        size: 14.5.sp,
                        colors: ColorConstants.buttonBar,
                        heights: 1.3),
                  ),
                  Text(
                    'RM 0.0',
                    style: getTextRegular(
                        size: 14.5.sp,
                        colors: ColorConstants.buttonBar,
                        heights: 1.3),
                  )
                ],
              ),
              SizedBox(
                height: 10.sp,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Subtotal',
                    style: getText600(
                        size: 14.5.sp,
                        colors: ColorConstants.buttonBar,
                        heights: 1.3),
                  ),
                  Text(
                    'RM 9.90',
                    style: getText600(
                        size: 14.5.sp,
                        colors: ColorConstants.buttonBar,
                        heights: 1.3),
                  )
                ],
              ),
              SizedBox(
                height: 10.sp,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Delivery fee',
                    style: getTextRegular(
                        size: 14.5.sp,
                        colors: ColorConstants.buttonBar,
                        heights: 1.3),
                  ),
                  Text(
                    'RM 0.00',
                    style: getTextRegular(
                        size: 14.5.sp,
                        colors: ColorConstants.buttonBar,
                        heights: 1.3),
                  )
                ],
              ),
              SizedBox(
                height: 10.sp,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Rounding Adj',
                    style: getTextRegular(
                        size: 14.5.sp,
                        colors: ColorConstants.buttonBar,
                        heights: 1.3),
                  ),
                  Text(
                    'RM 0.00',
                    style: getTextRegular(
                        size: 14.5.sp,
                        colors: ColorConstants.buttonBar,
                        heights: 1.3),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  _bottomBar() {
    return Container(
      height: 11.h,
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
      child: Container(
        margin: EdgeInsets.all(18.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Items  ${controller.totalCountItem.value}',
                  style: getText500(colors: Colors.white, size: 15.sp),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Text(
                  'RM ${getDoubleValue(controller.totalAmount.value).toStringAsFixed(2)}',
                  style: getText600(
                      colors: ColorConstants.cAppColorsBlue, size: 17.sp),
                ),
              ],
            ),
            Container(
              width: 45.w,
              margin: EdgeInsets.only(left: 20.sp),
              child: rectangleRoundedCornerButtonMedium(sOrderNow.tr, () {
                controller.orderNow();
              },
                  bgColor: ColorConstants.cAppColorsBlue,
                  textColor: Colors.white,
                  height: 28.sp,
                  size: 17.sp),
            )
          ],
        ),
      ),
    );
  }
}
