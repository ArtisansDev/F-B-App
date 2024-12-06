/// error : false
/// statusCode : 200
/// statusMessage : "Data Retrieved Successfully"
/// data : [{"IsPOSEnable":true,"IsAndroidEnable":true,"IsIOSEnable":true,"AndroidAppVersion":"1.0.0","IOSAppVersion":"1.0.0","CompulsoryUpdateIn":1,"TermsAndCondition":"Sample Terms and Conditions text","AboutUs":"Sample About Us text","RestaurantIDF":"9cc7d063-9391-4262-9244-ba8a679d1081","PaymentResponses":[{"RestaurantIDF":"9cc7d063-9391-4262-9244-ba8a679d1081","PaymentGatewayIDP":"6e9934ce-fe33-4c2d-9628-fae5475f3a25","PaymentGatewaySettingIDP":"611ba19b-3fb9-4787-907f-51b0a129f4fc","PaymentGatewayName":"Cash","Description":"Cash payment option","PaymentGatewayLogo":"http://13.53.89.14:801/admin/Content/Images/Payment/PGM_638678102710393181.png","PaymentGatewayNo":"0","MerchantID":"","SecretKey":"","APIKey":"","URL":"","Configurations":"","SandboxConfigurations":{"MerchantID":"761173165749545","SecretKey":"43106-268","mp_username":"RMSxdk_SB","mp_password":"RmS_Sb!p@s$wd","mp_merchant_ID":"SB_ttgreen","mp_app_name":"SB_ttgreen","mp_verification_key":"ff160fc47518b2a225551759a6b22379"},"ProductionConfigurations":{"MerchantID":"761173165749545","SecretKey":"43106-268","mp_username":"RMSxdk_SB","mp_password":"RmS_Sb!p@s$wd","mp_merchant_ID":"SB_ttgreen","mp_app_name":"SB_ttgreen","mp_verification_key":"ff160fc47518b2a225551759a6b22379"}},{"RestaurantIDF":"9cc7d063-9391-4262-9244-ba8a679d1081","PaymentGatewayIDP":"4edd3f4b-0115-4706-8244-452612462b83","PaymentGatewaySettingIDP":"8441289b-de99-4103-8014-71b2e1c9a7b4","PaymentGatewayName":"Senang Pay","Description":"Senang Pay","PaymentGatewayLogo":"http://13.53.89.14:801/admin/Content/Images/Payment/PGM_638678132549611074.png","PaymentGatewayNo":"1","MerchantID":"761173165749545","SecretKey":"43106-268","APIKey":"","URL":"","Configurations":"","SandboxConfigurations":{"MerchantID":"761173165749545","SecretKey":"43106-268","mp_username":"RMSxdk_SB","mp_password":"RmS_Sb!p@s$wd","mp_merchant_ID":"SB_ttgreen","mp_app_name":"SB_ttgreen","mp_verification_key":"ff160fc47518b2a225551759a6b22379"},"ProductionConfigurations":{"MerchantID":"761173165749545","SecretKey":"43106-268","mp_username":"RMSxdk_SB","mp_password":"RmS_Sb!p@s$wd","mp_merchant_ID":"SB_ttgreen","mp_app_name":"SB_ttgreen","mp_verification_key":"ff160fc47518b2a225551759a6b22379"}},{"RestaurantIDF":"9cc7d063-9391-4262-9244-ba8a679d1081","PaymentGatewayIDP":"b7171499-669d-474f-b19f-2f4b3e60718a","PaymentGatewaySettingIDP":"6b9becae-59cd-4b40-a035-f5c16c162094","PaymentGatewayName":"Fiuu","Description":"Fiuu (formerly Razer Merchant Services)","PaymentGatewayLogo":"http://13.53.89.14:801/admin/Content/Images/Payment/PGM_638690076431347022.jpg","PaymentGatewayNo":"2","MerchantID":"SB_ttgreen","SecretKey":"ff160fc47518b2a225551759a6b22379","APIKey":"","URL":"","Configurations":"","SandboxConfigurations":{"MerchantID":"761173165749545","SecretKey":"43106-268","mp_username":"RMSxdk_SB","mp_password":"RmS_Sb!p@s$wd","mp_merchant_ID":"SB_ttgreen","mp_app_name":"SB_ttgreen","mp_verification_key":"ff160fc47518b2a225551759a6b22379"},"ProductionConfigurations":{"MerchantID":"761173165749545","SecretKey":"43106-268","mp_username":"RMSxdk_SB","mp_password":"RmS_Sb!p@s$wd","mp_merchant_ID":"SB_ttgreen","mp_app_name":"SB_ttgreen","mp_verification_key":"ff160fc47518b2a225551759a6b22379"}}]}]

class GetGeneralSettingResponse {
  GetGeneralSettingResponse({
    this.error,
    this.statusCode,
    this.statusMessage,
    this.data,});

  GetGeneralSettingResponse.fromJson(dynamic json) {
    error = json['error'];
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(GetGeneralSettingData.fromJson(v));
      });
    }
  }
  bool? error;
  int? statusCode;
  String? statusMessage;
  List<GetGeneralSettingData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = error;
    map['statusCode'] = statusCode;
    map['statusMessage'] = statusMessage;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// IsPOSEnable : true
/// IsAndroidEnable : true
/// IsIOSEnable : true
/// AndroidAppVersion : "1.0.0"
/// IOSAppVersion : "1.0.0"
/// CompulsoryUpdateIn : 1
/// TermsAndCondition : "Sample Terms and Conditions text"
/// AboutUs : "Sample About Us text"
/// RestaurantIDF : "9cc7d063-9391-4262-9244-ba8a679d1081"
/// PaymentResponses : [{"RestaurantIDF":"9cc7d063-9391-4262-9244-ba8a679d1081","PaymentGatewayIDP":"6e9934ce-fe33-4c2d-9628-fae5475f3a25","PaymentGatewaySettingIDP":"611ba19b-3fb9-4787-907f-51b0a129f4fc","PaymentGatewayName":"Cash","Description":"Cash payment option","PaymentGatewayLogo":"http://13.53.89.14:801/admin/Content/Images/Payment/PGM_638678102710393181.png","PaymentGatewayNo":"0","MerchantID":"","SecretKey":"","APIKey":"","URL":"","Configurations":"","SandboxConfigurations":{"MerchantID":"761173165749545","SecretKey":"43106-268","mp_username":"RMSxdk_SB","mp_password":"RmS_Sb!p@s$wd","mp_merchant_ID":"SB_ttgreen","mp_app_name":"SB_ttgreen","mp_verification_key":"ff160fc47518b2a225551759a6b22379"},"ProductionConfigurations":{"MerchantID":"761173165749545","SecretKey":"43106-268","mp_username":"RMSxdk_SB","mp_password":"RmS_Sb!p@s$wd","mp_merchant_ID":"SB_ttgreen","mp_app_name":"SB_ttgreen","mp_verification_key":"ff160fc47518b2a225551759a6b22379"}},{"RestaurantIDF":"9cc7d063-9391-4262-9244-ba8a679d1081","PaymentGatewayIDP":"4edd3f4b-0115-4706-8244-452612462b83","PaymentGatewaySettingIDP":"8441289b-de99-4103-8014-71b2e1c9a7b4","PaymentGatewayName":"Senang Pay","Description":"Senang Pay","PaymentGatewayLogo":"http://13.53.89.14:801/admin/Content/Images/Payment/PGM_638678132549611074.png","PaymentGatewayNo":"1","MerchantID":"761173165749545","SecretKey":"43106-268","APIKey":"","URL":"","Configurations":"","SandboxConfigurations":{"MerchantID":"761173165749545","SecretKey":"43106-268","mp_username":"RMSxdk_SB","mp_password":"RmS_Sb!p@s$wd","mp_merchant_ID":"SB_ttgreen","mp_app_name":"SB_ttgreen","mp_verification_key":"ff160fc47518b2a225551759a6b22379"},"ProductionConfigurations":{"MerchantID":"761173165749545","SecretKey":"43106-268","mp_username":"RMSxdk_SB","mp_password":"RmS_Sb!p@s$wd","mp_merchant_ID":"SB_ttgreen","mp_app_name":"SB_ttgreen","mp_verification_key":"ff160fc47518b2a225551759a6b22379"}},{"RestaurantIDF":"9cc7d063-9391-4262-9244-ba8a679d1081","PaymentGatewayIDP":"b7171499-669d-474f-b19f-2f4b3e60718a","PaymentGatewaySettingIDP":"6b9becae-59cd-4b40-a035-f5c16c162094","PaymentGatewayName":"Fiuu","Description":"Fiuu (formerly Razer Merchant Services)","PaymentGatewayLogo":"http://13.53.89.14:801/admin/Content/Images/Payment/PGM_638690076431347022.jpg","PaymentGatewayNo":"2","MerchantID":"SB_ttgreen","SecretKey":"ff160fc47518b2a225551759a6b22379","APIKey":"","URL":"","Configurations":"","SandboxConfigurations":{"MerchantID":"761173165749545","SecretKey":"43106-268","mp_username":"RMSxdk_SB","mp_password":"RmS_Sb!p@s$wd","mp_merchant_ID":"SB_ttgreen","mp_app_name":"SB_ttgreen","mp_verification_key":"ff160fc47518b2a225551759a6b22379"},"ProductionConfigurations":{"MerchantID":"761173165749545","SecretKey":"43106-268","mp_username":"RMSxdk_SB","mp_password":"RmS_Sb!p@s$wd","mp_merchant_ID":"SB_ttgreen","mp_app_name":"SB_ttgreen","mp_verification_key":"ff160fc47518b2a225551759a6b22379"}}]

class GetGeneralSettingData {
  GetGeneralSettingData({
    this.isPOSEnable,
    this.isAndroidEnable,
    this.isIOSEnable,
    this.androidAppVersion,
    this.iOSAppVersion,
    this.compulsoryUpdateIn,
    this.termsAndCondition,
    this.aboutUs,
    this.restaurantIDF,
    this.paymentResponses,});

  GetGeneralSettingData.fromJson(dynamic json) {
    isPOSEnable = json['IsPOSEnable'];
    isAndroidEnable = json['IsAndroidEnable'];
    isIOSEnable = json['IsIOSEnable'];
    androidAppVersion = json['AndroidAppVersion'];
    iOSAppVersion = json['IOSAppVersion'];
    compulsoryUpdateIn = json['CompulsoryUpdateIn'];
    termsAndCondition = json['TermsAndCondition'];
    aboutUs = json['AboutUs'];
    restaurantIDF = json['RestaurantIDF'];
    if (json['PaymentResponses'] != null) {
      paymentResponses = [];
      json['PaymentResponses'].forEach((v) {
        paymentResponses?.add(PaymentTypeResponseData.fromJson(v));
      });
    }
  }
  bool? isPOSEnable;
  bool? isAndroidEnable;
  bool? isIOSEnable;
  String? androidAppVersion;
  String? iOSAppVersion;
  int? compulsoryUpdateIn;
  String? termsAndCondition;
  String? aboutUs;
  String? restaurantIDF;
  List<PaymentTypeResponseData>? paymentResponses;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['IsPOSEnable'] = isPOSEnable;
    map['IsAndroidEnable'] = isAndroidEnable;
    map['IsIOSEnable'] = isIOSEnable;
    map['AndroidAppVersion'] = androidAppVersion;
    map['IOSAppVersion'] = iOSAppVersion;
    map['CompulsoryUpdateIn'] = compulsoryUpdateIn;
    map['TermsAndCondition'] = termsAndCondition;
    map['AboutUs'] = aboutUs;
    map['RestaurantIDF'] = restaurantIDF;
    if (paymentResponses != null) {
      map['PaymentResponses'] = paymentResponses?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// RestaurantIDF : "9cc7d063-9391-4262-9244-ba8a679d1081"
/// PaymentGatewayIDP : "6e9934ce-fe33-4c2d-9628-fae5475f3a25"
/// PaymentGatewaySettingIDP : "611ba19b-3fb9-4787-907f-51b0a129f4fc"
/// PaymentGatewayName : "Cash"
/// Description : "Cash payment option"
/// PaymentGatewayLogo : "http://13.53.89.14:801/admin/Content/Images/Payment/PGM_638678102710393181.png"
/// PaymentGatewayNo : "0"
/// MerchantID : ""
/// SecretKey : ""
/// APIKey : ""
/// URL : ""
/// Configurations : ""
/// SandboxConfigurations : {"MerchantID":"761173165749545","SecretKey":"43106-268","mp_username":"RMSxdk_SB","mp_password":"RmS_Sb!p@s$wd","mp_merchant_ID":"SB_ttgreen","mp_app_name":"SB_ttgreen","mp_verification_key":"ff160fc47518b2a225551759a6b22379"}
/// ProductionConfigurations : {"MerchantID":"761173165749545","SecretKey":"43106-268","mp_username":"RMSxdk_SB","mp_password":"RmS_Sb!p@s$wd","mp_merchant_ID":"SB_ttgreen","mp_app_name":"SB_ttgreen","mp_verification_key":"ff160fc47518b2a225551759a6b22379"}

class PaymentTypeResponseData {
  PaymentTypeResponseData({
    this.restaurantIDF,
    this.paymentGatewayIDP,
    this.paymentGatewaySettingIDP,
    this.paymentGatewayName,
    this.description,
    this.paymentGatewayLogo,
    this.paymentGatewayNo,
    this.merchantID,
    this.secretKey,
    this.aPIKey,
    this.url,
    this.configurations,
    this.sandboxConfigurations,
    this.productionConfigurations,});

  PaymentTypeResponseData.fromJson(dynamic json) {
    restaurantIDF = json['RestaurantIDF'];
    paymentGatewayIDP = json['PaymentGatewayIDP'];
    paymentGatewaySettingIDP = json['PaymentGatewaySettingIDP'];
    paymentGatewayName = json['PaymentGatewayName'];
    description = json['Description'];
    paymentGatewayLogo = json['PaymentGatewayLogo'];
    paymentGatewayNo = json['PaymentGatewayNo'];
    merchantID = json['MerchantID'];
    secretKey = json['SecretKey'];
    aPIKey = json['APIKey'];
    url = json['URL'];
    configurations = json['Configurations'];
    sandboxConfigurations = json['SandboxConfigurations'] != null ? SandboxConfigurations.fromJson(json['SandboxConfigurations']) : null;
    productionConfigurations = json['ProductionConfigurations'] != null ? ProductionConfigurations.fromJson(json['ProductionConfigurations']) : null;
  }
  String? restaurantIDF;
  String? paymentGatewayIDP;
  String? paymentGatewaySettingIDP;
  String? paymentGatewayName;
  String? description;
  String? paymentGatewayLogo;
  String? paymentGatewayNo;
  String? merchantID;
  String? secretKey;
  String? aPIKey;
  String? url;
  String? configurations;
  SandboxConfigurations? sandboxConfigurations;
  ProductionConfigurations? productionConfigurations;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['RestaurantIDF'] = restaurantIDF;
    map['PaymentGatewayIDP'] = paymentGatewayIDP;
    map['PaymentGatewaySettingIDP'] = paymentGatewaySettingIDP;
    map['PaymentGatewayName'] = paymentGatewayName;
    map['Description'] = description;
    map['PaymentGatewayLogo'] = paymentGatewayLogo;
    map['PaymentGatewayNo'] = paymentGatewayNo;
    map['MerchantID'] = merchantID;
    map['SecretKey'] = secretKey;
    map['APIKey'] = aPIKey;
    map['URL'] = url;
    map['Configurations'] = configurations;
    if (sandboxConfigurations != null) {
      map['SandboxConfigurations'] = sandboxConfigurations?.toJson();
    }
    if (productionConfigurations != null) {
      map['ProductionConfigurations'] = productionConfigurations?.toJson();
    }
    return map;
  }

}

/// MerchantID : "761173165749545"
/// SecretKey : "43106-268"
/// mp_username : "RMSxdk_SB"
/// mp_password : "RmS_Sb!p@s$wd"
/// mp_merchant_ID : "SB_ttgreen"
/// mp_app_name : "SB_ttgreen"
/// mp_verification_key : "ff160fc47518b2a225551759a6b22379"

class ProductionConfigurations {
  ProductionConfigurations({
    this.merchantID,
    this.secretKey,
    this.mpUsername,
    this.mpPassword,
    this.mpMerchantID,
    this.mpAppName,
    this.mpVerificationKey,});

  ProductionConfigurations.fromJson(dynamic json) {
    merchantID = json['MerchantID'];
    secretKey = json['SecretKey'];
    mpUsername = json['mp_username'];
    mpPassword = json['mp_password'];
    mpMerchantID = json['mp_merchant_ID'];
    mpAppName = json['mp_app_name'];
    mpVerificationKey = json['mp_verification_key'];
  }
  String? merchantID;
  String? secretKey;
  String? mpUsername;
  String? mpPassword;
  String? mpMerchantID;
  String? mpAppName;
  String? mpVerificationKey;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['MerchantID'] = merchantID;
    map['SecretKey'] = secretKey;
    map['mp_username'] = mpUsername;
    map['mp_password'] = mpPassword;
    map['mp_merchant_ID'] = mpMerchantID;
    map['mp_app_name'] = mpAppName;
    map['mp_verification_key'] = mpVerificationKey;
    return map;
  }

}

/// MerchantID : "761173165749545"
/// SecretKey : "43106-268"
/// mp_username : "RMSxdk_SB"
/// mp_password : "RmS_Sb!p@s$wd"
/// mp_merchant_ID : "SB_ttgreen"
/// mp_app_name : "SB_ttgreen"
/// mp_verification_key : "ff160fc47518b2a225551759a6b22379"

class SandboxConfigurations {
  SandboxConfigurations({
    this.merchantID,
    this.secretKey,
    this.mpUsername,
    this.mpPassword,
    this.mpMerchantID,
    this.mpAppName,
    this.mpVerificationKey,});

  SandboxConfigurations.fromJson(dynamic json) {
    merchantID = json['MerchantID'];
    secretKey = json['SecretKey'];
    mpUsername = json['mp_username'];
    mpPassword = json['mp_password'];
    mpMerchantID = json['mp_merchant_ID'];
    mpAppName = json['mp_app_name'];
    mpVerificationKey = json['mp_verification_key'];
  }
  String? merchantID;
  String? secretKey;
  String? mpUsername;
  String? mpPassword;
  String? mpMerchantID;
  String? mpAppName;
  String? mpVerificationKey;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['MerchantID'] = merchantID;
    map['SecretKey'] = secretKey;
    map['mp_username'] = mpUsername;
    map['mp_password'] = mpPassword;
    map['mp_merchant_ID'] = mpMerchantID;
    map['mp_app_name'] = mpAppName;
    map['mp_verification_key'] = mpVerificationKey;
    return map;
  }

}