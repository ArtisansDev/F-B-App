/// error : false
/// statusCode : 200
/// statusMessage : "Data Retrieved Successfully"
/// data : [{"IsWebsiteEnable":true,"IsAndroidEnable":true,"IsIOSEnable":false,"AndroidAppVersion":"21","IOSAppVersion":"15","CompulsoryUpdate":1,"CompulsoryUpdateIn":1,"TermsAndConditionURL":"https://localhost:44385/GenralSetting/Index","AboutUsURL":null,"RestaurantIDF":"0d74bfa1-af7d-4182-835b-b815c2972591"}]

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

/// IsWebsiteEnable : true
/// IsAndroidEnable : true
/// IsIOSEnable : false
/// AndroidAppVersion : "21"
/// IOSAppVersion : "15"
/// CompulsoryUpdate : 1
/// CompulsoryUpdateIn : 1
/// TermsAndConditionURL : "https://localhost:44385/GenralSetting/Index"
/// AboutUsURL : null
/// RestaurantIDF : "0d74bfa1-af7d-4182-835b-b815c2972591"

class GetGeneralSettingData {
  GetGeneralSettingData({
      this.isWebsiteEnable, 
      this.isAndroidEnable, 
      this.isIOSEnable, 
      this.androidAppVersion, 
      this.iOSAppVersion, 
      this.compulsoryUpdate, 
      this.compulsoryUpdateIn, 
      this.termsAndConditionURL, 
      this.aboutUsURL, 
      this.restaurantIDF,});

  GetGeneralSettingData.fromJson(dynamic json) {
    isWebsiteEnable = json['IsWebsiteEnable'];
    isAndroidEnable = json['IsAndroidEnable'];
    isIOSEnable = json['IsIOSEnable'];
    androidAppVersion = json['AndroidAppVersion'];
    iOSAppVersion = json['IOSAppVersion'];
    compulsoryUpdate = json['CompulsoryUpdate'];
    compulsoryUpdateIn = json['CompulsoryUpdateIn'];
    termsAndConditionURL = json['TermsAndConditionURL'];
    aboutUsURL = json['AboutUsURL']??'';
    restaurantIDF = json['RestaurantIDF'];
  }
  bool? isWebsiteEnable;
  bool? isAndroidEnable;
  bool? isIOSEnable;
  String? androidAppVersion;
  String? iOSAppVersion;
  int? compulsoryUpdate;
  int? compulsoryUpdateIn;
  String? termsAndConditionURL;
  String? aboutUsURL;
  String? restaurantIDF;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['IsWebsiteEnable'] = isWebsiteEnable;
    map['IsAndroidEnable'] = isAndroidEnable;
    map['IsIOSEnable'] = isIOSEnable;
    map['AndroidAppVersion'] = androidAppVersion;
    map['IOSAppVersion'] = iOSAppVersion;
    map['CompulsoryUpdate'] = compulsoryUpdate;
    map['CompulsoryUpdateIn'] = compulsoryUpdateIn;
    map['TermsAndConditionURL'] = termsAndConditionURL;
    map['AboutUsURL'] = aboutUsURL;
    map['RestaurantIDF'] = restaurantIDF;
    return map;
  }

}