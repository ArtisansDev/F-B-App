import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:my_coffee/model/order_confirmation/view/packaging/packaging_view.dart';
import 'package:my_coffee/model/order_confirmation/view/payment_details/payment_details_view.dart';
import 'package:my_coffee/model/order_confirmation/view/payment_method/payment_method_view.dart';
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
import 'add_vouchers/add_vouchers_view.dart';
import 'bottom_bar_order_now/bottom_bar_order_now_view.dart';
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
                child: Stack(
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
                        child: BottomBarOrderNowView())
                  ],
                )
            )));
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
          // PackagingView(),

          ///Payment Method
          PaymentMethodView(),

          ///Vouchers
          // AddVouchersView(),

          ///Payment Details
          PaymentDetailsView(),

          SizedBox(
            height: 13.h,
          )
        ],
      ),
    );
  }
}
