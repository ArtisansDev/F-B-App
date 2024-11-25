/// error : false
/// statusCode : 200
/// statusMessage : "OTP Sent Successful"
/// data : {"OTP":"123456","text":"OTP Sent Successful"}

class LoginResponse {
  LoginResponse({
    this.error,
    this.statusCode,
    this.statusMessage,
    this.data,
  });

  LoginResponse.fromJson(dynamic json) {
    error = json['error'];
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    data =
    json['data'] != null ? LoginResponseData.fromJson(json['data']) : null;
  }

  bool? error;
  int? statusCode;
  String? statusMessage;
  LoginResponseData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = error;
    map['statusCode'] = statusCode;
    map['statusMessage'] = statusMessage;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

/// OTP : "123456"
/// text : "OTP Sent Successful"

class LoginResponseData {
  LoginResponseData({
    this.otp,
    this.text,
  });

  LoginResponseData.fromJson(dynamic json) {
    otp = json['OTP'];
    text = json['text'];
  }

  String? otp;
  String? text;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OTP'] = otp;
    map['text'] = text;
    return map;
  }
}
