import 'package:f_b_base/data/local/shared_prefs/shared_prefs.dart';
import 'package:f_b_base/data/mode/get_general_setting/get_general_setting_response.dart';
import 'package:get/get.dart';


class AboutUsController extends GetxController {
  Rx<GetGeneralSettingData> mGetGeneralSettingData =
      GetGeneralSettingData().obs;

  getAboutUs() async {
    mGetGeneralSettingData.value = await SharedPrefs().getGeneralSetting();
  }
}
