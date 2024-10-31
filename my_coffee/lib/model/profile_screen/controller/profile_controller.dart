import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_coffee/alert/app_alert.dart';
import 'package:my_coffee/constants/logout_expired.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../constants/get_user_details.dart';
import '../../../constants/message_constants.dart';
import '../../../data/local/shared_prefs/shared_prefs.dart';
import '../../../data/mode/user_details/user_details_response.dart';
import '../../../routes/route_constants.dart';

class ProfileScreenController extends GetxController {
  RxString version = '--'.obs;
  Rx<UserDetailsResponseData> mUserDetailsResponseData =
      UserDetailsResponseData().obs;
  RxString userName = '--'.obs;
  RxString email = '--'.obs;
  RxString phoneNumber = '--'.obs;

  RxBool viewVisible = false.obs;

  ProfileScreenController() {
    getPackageInfo();
  }

  getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version.value = packageInfo.version;
    await getUserDetails();
    viewVisible.value = true;
  }

  getProfileDetails() async {
    mUserDetailsResponseData.value = await SharedPrefs().getUserDetails();
    userName.value = mUserDetailsResponseData.value.firstName ?? '';
    email.value = mUserDetailsResponseData.value.email ?? '';
    phoneNumber.value = mUserDetailsResponseData.value.phoneNumber ?? '';
    mUserDetailsResponseData.refresh();
  }

  void openNextPage(String title) {
    switch (title) {
      case 'Terms of Use':
        Get.toNamed(
          RouteConstants.rTermsOfUseScreen,
        );
        break;
      case 'About Us':
        Get.toNamed(
          RouteConstants.rAboutUsScreen,
        );
        break;
      case 'Logout':
        AppAlert.showCustomDialogYesNoLogout(
            Get.context!, 'Logout!', MessageConstants.wLogoutMessage, () {
          logout();
        });
        break;
      case 'Delete Account':
        AppAlert.showCustomDialogYesNoLogout(Get.context!, 'Delete Account!',
            MessageConstants.wDeleteAccountMessage, () async {
          await getUserDelete();
        }, rightText: 'Delete');
        break;
    }
  }
}
