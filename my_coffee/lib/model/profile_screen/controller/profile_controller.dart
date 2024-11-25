import 'package:f_b_base/alert/app_alert.dart';
import 'package:f_b_base/constants/message_constants.dart';
import 'package:f_b_base/data/local/shared_prefs/shared_prefs.dart';
import 'package:f_b_base/data/mode/add_cart/add_cart.dart';
import 'package:f_b_base/data/mode/user_details/user_details_response.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:my_coffee/constants/logout_expired.dart';

import '../../../constants/get_user_details.dart';
import '../../../routes/route_constants.dart';
import '../../dashboard_screen/controller/dashboard_controller.dart';

class ProfileScreenController extends GetxController {
  DashboardScreenController mDashboardScreenController =
      Get.find<DashboardScreenController>();
  RxString version = '--'.obs;
  Rx<UserDetailsResponseData> mUserDetailsResponseData =
      UserDetailsResponseData().obs;
  RxString userName = '--'.obs;
  RxString email = '--'.obs;
  RxString phoneNumber = '--'.obs;
  Rxn<String> imageUrl = Rxn<String>();

  RxBool viewVisible = false.obs;

  ProfileScreenController() {
    getPackageInfo();
  }

  getPackageInfo() async {
    version.value = dotenv.env['APP_VERSION'] ?? '';
    await getUserDetails();
    viewVisible.value = true;
  }

  getProfileDetails() async {
    mUserDetailsResponseData.value = await SharedPrefs().getUserDetails();
    userName.value = mUserDetailsResponseData.value.firstName ?? '';
    email.value = mUserDetailsResponseData.value.email ?? '';
    phoneNumber.value = mUserDetailsResponseData.value.phoneNumber ?? '';
    imageUrl.value = mUserDetailsResponseData.value.userImage;
    mUserDetailsResponseData.refresh();
  }

  void openNextPage(String title) {
    switch (title) {
      case 'Orders History':
        mDashboardScreenController.selectedIndex.value = 2;
        mDashboardScreenController.selectTitle(2);
        break;
      case 'Orders':
        if ((mAddCartModel.value.mItems ?? []).isNotEmpty) {
          Get.toNamed(RouteConstants.rOrderConfirmationScreen);
        } else {
          AppAlertBase.showSnackBar(Get.context!, 'No item add in your cart');
        }
        break;
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
        AppAlertBase.showCustomDialogYesNoLogout(
            Get.context!, 'Logout!', MessageConstants.wLogoutMessage, () {
          logout();
        });
        break;
      case 'Delete Account':
        AppAlertBase.showCustomDialogYesNoLogout(Get.context!, 'Delete Account!',
            MessageConstants.wDeleteAccountMessage, () async {
          await getUserDelete();
        }, rightText: 'Delete');
        break;
    }
  }

  Rx<AddCartModel> mAddCartModel = AddCartModel().obs;

  void getOrderDetails() async {
    mAddCartModel.value = await SharedPrefs().getAddCartData();
    mAddCartModel.refresh();
  }
}
