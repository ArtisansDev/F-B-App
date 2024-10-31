import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:my_coffee/constants/text_styles_constants.dart';
import '../../../common/appbars_common.dart';
import '../../../common/button_constants.dart';
import '../../../common/text_input_widget.dart';
import '../../../constants/color_constants.dart';
import '../../../constants/pattern_constants.dart';
import '../../../lang/translation_service_key.dart';
import '../../../routes/route_constants.dart';
import '../../../utils/app_utils.dart';
import '../controller/rewards_controller.dart';

class RewardsScreen extends GetView<RewardsScreenController> {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => RewardsScreenController());
    return _fullView();
  }

  ///full_View
  _fullView() {
    return FocusDetector(
        onVisibilityGained: () {},
        onVisibilityLost: () {
          Get.delete<RewardsScreenController>();
        },
        child: GestureDetector(
            onTap: () {
              AppUtils.hideKeyboard(Get.context!);
            },
            child: Container(
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.center,
                )));
  }

}
