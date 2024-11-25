

import 'app_constants.dart';

class WebConstants {

  // Standard Comparison Values
  static int statusCode200 = 200;
  static int statusCode400 = 400;
  static int statusCode401 = 401;
  static int statusCode404 = 404;
  static int statusCode422 = 422;

  static String statusMessageOK = "OK";
  static String statusMessageBadRequest = "Bad Request";
  static String statusMessageEntityError = "Unprocessable Entity Error";
  static String statusMessageTokenIsExpired = "Token is Expired";

  // Web response cases
  static String statusCode403Message =
      "{  \"error\" : true,\n  \"status\" : 403,\n  \"message\" : \"Bad Request\",\n  \"data\" : {\"message\":\"Unauthorized error\"},\n  \"responseTime\" : 1639548038\n  }";
  static String statusCode404Message =
      "{  \"error\" : true,\n  \"status\" : 404,\n  \"message\" : \"Bad Request\",\n  \"data\" : {\"message\":\"Unable to find the action URL\"},\n  \"responseTime\" : 1639548038\n  }";
  static String statusCode502Message =
      "{\r\n  \"error\": true,\r\n  \"status\": 502,\r\n  \"message\": \"Bad Request\",\r\n  \"data\": {\r\n    \"message\": \"Server Error, Please try after sometime\"\r\n  },\r\n  \"responseTime\": 1639548038\r\n}";
  static String statusCode503Message =
      "{  \"error\" : true,\n  \"status\" : 503,\n  \"message\" : \"Bad Request\",\n  \"data\" : {\"message\":\"Unable to process your request right now, Please try again later\"},\n  \"responseTime\" : 1639548038\n  }";

  // ///APP_NAME
  // static String appName = "app/";
  //
  // ///API_VERSION
  // static String apiVersion = "v1/";

  /// Base URL
  static String baseUrlLive = "http://staging.artisanssolutions.com/api/";
  static String baseUrlDev = "http://staging.artisanssolutions.com/api/";
  static String baseURL =
      AppConstants.isLiveURLToUse ? baseUrlLive : baseUrlDev;

  /// Webservice
  /// Avoid kDebugMode(it can be profile mode) prefer using kReleaseMode only
  static String baseUrlCommon = baseURL;//+appName+apiVersion;
  static bool auth = false;


  /// Master - all Url
  ///16-Oct-24
  static String actionLogin =  "Account/SendOTP";  //post
  static String actionVerifyOtp =  "Account/VerifyOTP";//post
  static String actionRegister =  "Account/Register";//post
  static String actionProfile =  "Registration/GetUserData";  //post
  static String actionProfileUpdate =  "Registration/UserDetails_Update"; //post
  static String actionProfileAddress =  "Registration/Address_Insert_Update";//post
  static String actionDeleteAccount =  "Account/DeleteAccount";  //post

  ///23-Oct-24
  static String actionGetGeneralSetting =  "GetGeneralSetting/";  //get
  static String actionGetBestSellerItem =  "Menu/GetBestSellerItem";  //post
  static String actionGetAllBranchesByRestaurantID =  "Branch/getAllBranchesByResturantIDF";  //post
  static String actionGetCategory =  "Menu/GetCategory";  //post
  static String actionGetCategoryItem =  "Menu/GetCategoryItem";  //post
  static String actionGetItemDetails =  "Menu/GetItemDetails";  //post
  static String actionOrderPlace =  "Order/ProcessOrder";  //post
  static String actionGetOrderHistory =  "Order/GetOrderHistory";  //post
  static String actionPostPaymentType =  "Payment/getPaymentMethod";  //post
  static String actionPostUpdatePaymentStatus =  "Payment/updatePaymentStatus";  //post

  ///28-Oct-24
  static String actionGetDashboard =  "GetDashboard";  //post

  ///4-Nov-24
  static String actionSaveImage =  "Registration/User_SaveImage";  //post


}