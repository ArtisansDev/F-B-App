import 'package:get/get.dart';

import '../../../data/local/shared_prefs/shared_prefs.dart';
import '../../../data/mode/get_general_setting/get_general_setting_response.dart';

class TermsOfUseController extends GetxController {
  Rx<GetGeneralSettingData> mGetGeneralSettingData =
      GetGeneralSettingData().obs;

  getTermsOfUse() async {
    mGetGeneralSettingData.value = await SharedPrefs().getGeneralSetting();
  }
}
