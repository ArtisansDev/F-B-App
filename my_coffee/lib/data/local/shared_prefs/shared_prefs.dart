import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../mode/add_cart/add_cart.dart';
import '../../mode/get_all_branches_by_restaurant_id/get_all_branches_by_restaurant_id_response.dart';
import '../../mode/get_general_setting/get_general_setting_response.dart';
import '../../mode/login/login_response.dart';
import '../../mode/user_details/user_details_response.dart';
import 'pref_constants.dart';

class SharedPrefs {
  // Singleton approach
  static final SharedPrefs _instance = SharedPrefs._internal();

  factory SharedPrefs() => _instance;

  SharedPrefs._internal();

  SharedPreferences? sharedPreferences;

  sharedPreferencesInstance() async {
    if (sharedPreferences == null) {
      return sharedPreferences = await SharedPreferences.getInstance();
    } else {
      return sharedPreferences;
    }
  }

  /// AppUserToke
  Future<void> setUserToken(String? bearerToken) async {
    /// debugPrint("setToken $bearerToken");
    sharedPreferences!.setString(PrefConstants.token, bearerToken ?? "");
  }

  Future<String> getUserToken() async {
    String value = sharedPreferences!.getString(PrefConstants.token) ?? "";
    if (value.isNotEmpty) {
      return value;
    }
    return  "";
  }

  /// AppUserId
  Future<void> setUserId(String? sUserId) async {
    /// debugPrint("setToken $bearerToken");
    sharedPreferences!.setString(PrefConstants.sUserId, sUserId ?? "");
  }

  Future<String> getUserId() async {
    String value = sharedPreferences!.getString(PrefConstants.sUserId) ?? "";
    if (value.isNotEmpty) {
      return value;
    }
    return  "";
  }

  /// userDetails
  Future<void> setUserDetails(String? setUserDetails) async {
    sharedPreferences!.setString(PrefConstants.sUserDetails, setUserDetails ?? "");
  }

  Future<UserDetailsResponseData> getUserDetails() async {
    String value = sharedPreferences!.getString(PrefConstants.sUserDetails) ?? "";
    if (value.isNotEmpty) {
      return UserDetailsResponseData.fromJson(json.decode(value));
    }
    return  UserDetailsResponseData();
  }


  /// GeneralSetting
  Future<void> setGeneralSetting(String? setGeneralSetting) async {
    sharedPreferences!.setString(PrefConstants.sGeneralSetting, setGeneralSetting ?? "");
  }

  Future<GetGeneralSettingData> getGeneralSetting() async {
    String value = sharedPreferences!.getString(PrefConstants.sGeneralSetting) ?? "";
    if (value.isNotEmpty) {
      return GetGeneralSettingData.fromJson(json.decode(value));
    }
    return  GetGeneralSettingData();
  }

  /// GetBranchesData
  Future<void> setBranchesData(String? setBranchesData) async {
    sharedPreferences!.setString(PrefConstants.sBranchesData, setBranchesData ?? "");
  }

  Future<GetAllBranchesListData> getBranchesData() async {
    String value = sharedPreferences!.getString(PrefConstants.sBranchesData) ?? "";
    if (value.isNotEmpty) {
      return GetAllBranchesListData.fromJson(json.decode(value));
    }
    return  GetAllBranchesListData();
  }

  /// AddCartModel
  Future<void> setAddCartData(String? setAddCartData) async {
    sharedPreferences!.setString(PrefConstants.sAddCartData, setAddCartData ?? "");
  }

  Future<AddCartModel> getAddCartData() async {
    String value = sharedPreferences!.getString(PrefConstants.sAddCartData) ?? "";
    print("####### $value");
    if (value.isNotEmpty) {
      return AddCartModel.fromJson(json.decode(value));
    }
    return  AddCartModel();
  }
}
