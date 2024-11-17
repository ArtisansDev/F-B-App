
import 'package:get/get.dart';
import 'package:my_coffee/data/remote/api_call/api_impl.dart';
import '../../../../alert/app_alert.dart';
import '../../../../constants/web_constants.dart';
import '../../../local/shared_prefs/shared_prefs.dart';
import '../../../mode/get_all_branches_by_restaurant_id/get_all_branches_by_restaurant_id_response.dart';
import '../../../mode/get_category/get_category_response.dart';
import '../../../mode/get_category_item/get_category_item_response.dart';
import '../../../mode/get_item_details/get_item_details_response.dart';
import '../../web_response.dart';
import '../../web_response_failed.dart';
import 'product_api.dart';

class ProductApiImpl extends AllApiImpl with ProductApi {

  ///post GetAllBranchesByRestaurantID
  @override
  Future<WebResponseSuccess> postGetAllBranchesByRestaurantID(
      dynamic exhibitorsListRequest,{bool isLoading = true}) async {
    if(isLoading) {
      AppAlert.showProgressDialog(Get.context!);
    }
    WebConstants.auth = (await SharedPrefs().getUserToken()).isNotEmpty;
    final cases = await mWebProvider.postWithRequest(
        WebConstants.actionGetAllBranchesByRestaurantID, exhibitorsListRequest);
    if(isLoading) {
      AppAlert.hideLoadingDialog(Get.context!);
    }
    if (cases.statusCode != WebConstants.statusCode200) {
      mWebResponseFailed =
          WebResponseFailed.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        // data: mWebResponseFailed,
        statusMessage: mWebResponseFailed.statusMessage,
        error: true,
      );
    } else {
      GetAllBranchesByRestaurantIdResponse
      mGetAllBranchesByRestaurantIdResponse =
      GetAllBranchesByRestaurantIdResponse.fromJson(
          processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mGetAllBranchesByRestaurantIdResponse,
        statusMessage: "",
        error: false,
      );
    }
    return mWebResponseSuccess;
  }

  ///post GetCategory
  @override
  Future<WebResponseSuccess> postGetCategory(
      dynamic exhibitorsListRequest) async {
    AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = (await SharedPrefs().getUserToken()).isNotEmpty;
    final cases = await mWebProvider.postWithRequest(
        WebConstants.actionGetCategory, exhibitorsListRequest);
    AppAlert.hideLoadingDialog(Get.context!);
    if (cases.statusCode == WebConstants.statusCode200) {
      GetCategoryResponse mGetCategoryResponse =
      GetCategoryResponse.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mGetCategoryResponse,
        statusMessage: "",
        error: false,
      );
    } else if (cases.statusCode == WebConstants.statusCode404) {
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        statusMessage: 'No Data Found',
        error: true,
      );
    } else {
      GetCategoryResponse mGetCategoryResponse =
      GetCategoryResponse.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mGetCategoryResponse,
        statusMessage: "",
        error: false,
      );
    }
    return mWebResponseSuccess;
  }

  ///post GetCategoryItem
  @override
  Future<WebResponseSuccess> postGetCategoryItem(
      dynamic exhibitorsListRequest) async {
    AppAlert.showProgressDialog(Get.context!);
    WebConstants.auth = (await SharedPrefs().getUserToken()).isNotEmpty;
    final cases = await mWebProvider.postWithRequest(
        WebConstants.actionGetCategoryItem, exhibitorsListRequest);
    AppAlert.hideLoadingDialog(Get.context!);
    if (cases.statusCode != WebConstants.statusCode200) {
      mWebResponseFailed =
          WebResponseFailed.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        // data: mWebResponseFailed,
        statusMessage: mWebResponseFailed.statusMessage,
        error: true,
      );
    } else {
      GetCategoryItemResponse mGetCategoryItemResponse =
      GetCategoryItemResponse.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mGetCategoryItemResponse,
        statusMessage: "",
        error: false,
      );
    }
    return mWebResponseSuccess;
  }

  ///post GetItemDetails
  @override
  Future<WebResponseSuccess> postGetItemDetails(
      dynamic exhibitorsListRequest,{bool isLoading = true}) async {
    if(isLoading){
      AppAlert.showProgressDialog(Get.context!);
    }
    WebConstants.auth = (await SharedPrefs().getUserToken()).isNotEmpty;
    final cases = await mWebProvider.postWithRequest(
        WebConstants.actionGetItemDetails, exhibitorsListRequest);
    if(isLoading) {
      AppAlert.hideLoadingDialog(Get.context!);
    }
    if (cases.statusCode != WebConstants.statusCode200) {
      mWebResponseFailed =
          WebResponseFailed.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        // data: mWebResponseFailed,
        statusMessage: mWebResponseFailed.statusMessage,
        error: true,
      );
    } else {
      GetItemDetailsResponse mGetItemDetailsResponse =
      GetItemDetailsResponse.fromJson(processResponseToJson(cases));
      mWebResponseSuccess = WebResponseSuccess(
        statusCode: cases.statusCode,
        data: mGetItemDetailsResponse,
        statusMessage: "",
        error: false,
      );
    }
    return mWebResponseSuccess;
  }
}
