import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../data/local/shared_prefs/shared_prefs.dart';
import '../../../routes/route_constants.dart';
import '../../../utils/network_utils.dart';

class SplashScreenController extends GetxController {
  RxString version = ''.obs;

  getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version.value = packageInfo.version;
  }

  initSharedPreferencesInstance() async {
    await SharedPrefs().sharedPreferencesInstance();
  }

  nextPage() {
    NetworkUtils().checkInternetConnection().then((isInternetAvailable) async {
      if (isInternetAvailable) {
        // await SharedPrefs().setUserToken('');
        // String sLoginStatus = await SharedPrefs().getUserToken();
        await Future.delayed(const Duration(seconds: 2));
        // Get.delete<SplashScreenController>();
        // if(sLoginStatus.trim().isNotEmpty){
        //   Get.offNamed(
        //     RouteConstants.rDashboardScreen,
        //   );
        // } else {
        Get.offNamed(
          RouteConstants.rIntroductionScreen,
        );
        // }
      }
    });
  }
}
