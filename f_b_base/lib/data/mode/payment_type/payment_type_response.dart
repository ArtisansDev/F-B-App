/// error : false
/// statusCode : 200
/// statusMessage : "Data Retrieved Successfully"
/// data : [{"RestaurantIDF":"9cc7d063-9391-4262-9244-ba8a679d1081","PaymentGatewayIDP":"4edd3f4b-0115-4706-8244-452612462b83","PaymentGatewaySettingIDP":"8441289b-de99-4103-8014-71b2e1c9a7b4","PaymentGatewayName":"Senang Pay","Description":"Senang Pay","PaymentGatewayLogo":"http://13.53.89.14:801/admin/Content/Images/Payment/PGM_638678132549611074.png","PaymentGatewayNo":"1","MerchantID":"761173165749545","SecretKey":"43106-268","APIKey":"","URL":"","Configurations":""},{"RestaurantIDF":"9cc7d063-9391-4262-9244-ba8a679d1081","PaymentGatewayIDP":"6e9934ce-fe33-4c2d-9628-fae5475f3a25","PaymentGatewaySettingIDP":"611ba19b-3fb9-4787-907f-51b0a129f4fc","PaymentGatewayName":"Cash","Description":"Cash payment option","PaymentGatewayLogo":"http://13.53.89.14:801/admin/Content/Images/Payment/PGM_638678102710393181.png","PaymentGatewayNo":"0","MerchantID":"","SecretKey":"","APIKey":"","URL":"","Configurations":""}]

class PaymentTypeResponse {
  PaymentTypeResponse({
    this.error,
    this.statusCode,
    this.statusMessage,
    this.data,});

  PaymentTypeResponse.fromJson(dynamic json) {
    error = json['error'];
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(PaymentTypeResponseData.fromJson(v));
      });
    }
  }
  bool? error;
  int? statusCode;
  String? statusMessage;
  List<PaymentTypeResponseData>? data;

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

/// RestaurantIDF : "9cc7d063-9391-4262-9244-ba8a679d1081"
/// PaymentGatewayIDP : "4edd3f4b-0115-4706-8244-452612462b83"
/// PaymentGatewaySettingIDP : "8441289b-de99-4103-8014-71b2e1c9a7b4"
/// PaymentGatewayName : "Senang Pay"
/// Description : "Senang Pay"
/// PaymentGatewayLogo : "http://13.53.89.14:801/admin/Content/Images/Payment/PGM_638678132549611074.png"
/// PaymentGatewayNo : "1"
/// MerchantID : "761173165749545"
/// SecretKey : "43106-268"
/// APIKey : ""
/// URL : ""
/// Configurations : ""

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
    this.configurations,});

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
    return map;
  }

}