// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';

import 'package:f_b_base/alert/app_alert_base.dart';
import 'package:f_b_base/constants/message_constants.dart';
import 'package:f_b_base/constants/web_constants.dart';
import 'package:f_b_base/data/local/shared_prefs/shared_prefs.dart';
import 'package:f_b_base/data/mode/add_cart/add_cart.dart';
import 'package:f_b_base/data/mode/get_all_branches_by_restaurant_id/get_all_branches_by_restaurant_id_request.dart';
import 'package:f_b_base/data/mode/get_all_branches_by_restaurant_id/get_all_branches_by_restaurant_id_response.dart';
import 'package:f_b_base/data/mode/get_general_setting/get_general_setting_response.dart';
import 'package:f_b_base/data/remote/api_call/general_api/general_api.dart';
import 'package:f_b_base/data/remote/api_call/product_api/product_api.dart';
import 'package:f_b_base/data/remote/web_response.dart';
import 'package:f_b_base/locator.dart';
import 'package:f_b_base/utils/date_format.dart';
import 'package:f_b_base/utils/get_location.dart';
import 'package:f_b_base/utils/network_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../routes/route_constants.dart';

class IntroductionScreenController extends GetxController {
  final PageController introductionPageController =
      PageController(initialPage: 0);
  GetLocation mGetLocation = GetLocation();

  void onChangePage(int value) {}
  Rx<LatLng> centerLatLng = const LatLng(0, 0).obs;
  final localApi = locator.get<GeneralApi>();

  Rxn<String> selectTableNo = Rxn<String>();
  Rxn<String> selectBranchIDF = Rxn<String>();

  void goToNextPage() {
    generalSettingApiCall();
  }

  void generalSettingApiCall() {
    NetworkUtils().checkInternetConnection().then((isInternetAvailable) async {
      if (isInternetAvailable) {
        WebResponseSuccess mWebResponseSuccess =
            await localApi.postGeneralSetting();
        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          GetGeneralSettingResponse mGetGeneralSettingResponse =
              mWebResponseSuccess.data;
          setValue(mGetGeneralSettingResponse);
        }
      } else {
        AppAlertBase.showSnackBar(
            Get.context!, MessageConstants.noInternetConnection);
      }
    });
  }

  setValue(GetGeneralSettingResponse mGetGeneralSettingResponse) async {
    if (mGetGeneralSettingResponse.statusCode == WebConstants.statusCode200) {
      if ((mGetGeneralSettingResponse.data ?? []).isNotEmpty) {
        GetGeneralSettingData mGetGeneralSettingData =
            (mGetGeneralSettingResponse.data ?? []).first;
        bool bNextPage = false;
        String value = '';
        if (kIsWeb) {
          bNextPage = true;
        } else if (Platform.isAndroid) {
          if (mGetGeneralSettingData.isAndroidEnable ?? false) {
            bNextPage = true;
          } else {
            value = 'This variation is not supported in android';
          }
        } else if (Platform.isIOS) {
          if (mGetGeneralSettingData.isIOSEnable ?? false) {
            bNextPage = true;
          } else {
            value = 'This variation is not supported in ios';
          }
        }
        // if (bNextPage) {
        if ((mGetGeneralSettingData.restaurantIDF ?? '').isNotEmpty) {
          await SharedPrefs().setAddCartData('');
          await SharedPrefs().setBranchesData('');
          await SharedPrefs()
              .setGeneralSetting(jsonEncode(mGetGeneralSettingData));
          if (kIsWeb) {
            await SharedPrefs().setAddCartData(jsonEncode(AddCartModel(
                sTableNo: selectTableNo.value ?? '', sType: 'Dine')));
            await getGetAllBranchesApi(selectBranchIDF.value??'');
          }
          Get.offNamed(
            RouteConstants.rDashboardScreen,
          );
        } else {
          AppAlertBase.showSnackBar(Get.context!, 'restaurant id not found');
        }
      } else {
        AppAlertBase.showSnackBar(
            Get.context!, mGetGeneralSettingResponse.statusMessage ?? "");
      }
    } else {
      AppAlertBase.showSnackBar(
          Get.context!, mGetGeneralSettingResponse.statusMessage ?? "");
    }
  }

  ///mGetAllBranchesListData
  RxList<GetAllBranchesListData> mGetAllBranchesListData =
      <GetAllBranchesListData>[].obs;

   getGetAllBranchesApi(String selectBranchIDF) async{
    await NetworkUtils().checkInternetConnection().then((isInternetAvailable) async {
      if (isInternetAvailable) {
        GetAllBranchesByRestaurantIdRequest
            mGetAllBranchesByRestaurantIdRequest =
            GetAllBranchesByRestaurantIdRequest(
                rowsPerPage: 0,
                pageNumber: 1,
                searchValue: '',
                todayDate: toDayDate(),
                restaurantIDF:
                    (await SharedPrefs().getGeneralSetting()).restaurantIDF ??
                        '');
        WebResponseSuccess mWebResponseSuccess = await locator
            .get<ProductApi>()
            .postGetAllBranchesByRestaurantID(
                mGetAllBranchesByRestaurantIdRequest);

        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          GetAllBranchesByRestaurantIdResponse
              mGetAllBranchesByRestaurantIdResponse = mWebResponseSuccess.data;
          mGetAllBranchesListData.value.clear();
          mGetAllBranchesListData.value
              .addAll(mGetAllBranchesByRestaurantIdResponse.data?.data ?? []);
          int trendIndex = mGetAllBranchesListData.value.indexWhere((element) {
            return element.branchIDP.toString() == selectBranchIDF;
          }, );

          if(trendIndex!=-1){
            debugPrint("#######trendIndex ${trendIndex}");
            await SharedPrefs().setBranchesData(jsonEncode(mGetAllBranchesListData.value[trendIndex]));
          }
        } else {
          AppAlertBase.showSnackBar(
              Get.context!, mWebResponseSuccess.statusMessage ?? '');
        }
      } else {
        AppAlertBase.showSnackBar(
            Get.context!, MessageConstants.noInternetConnection);
      }
    });
  }
}
