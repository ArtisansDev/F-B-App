/// error : false
/// statusCode : 200
/// statusMessage : "OTP Verification Successful"
/// data : {"isRegister":1,"userId":"6CBF34C6-A15A-4C97-8DED-9C6794A16C68","accessToken":"ctC6zqw4r9_tLcNriuWk9syXrJvce3W4MpgLb-6Nrdz4Xv1NA5B8ccR-4Ybvt0H_w8aLmNElQIq4_xr2lXmcb1XXCgBoi7F27Fc4ma3Nlq1cQeh-Og_Gylr3AfVT6SSUrne3-hhUX3oWYqSOQI0MTdgMglXMrmyI-VneDVQs15neWcnKExuF4Cw0DFYjaPf23QYxT31Jwaj1z-9ow6q__XVP1bXTf_qDaIt-3U1YyoEIacvCEMKtDyE-o-__sXa7obcF1wGvUPSfYX9891T9iocuv_dhjknv9Q3jDpeTmRhDOenimPmLFNB4NN-y76kqnltHz2hmPFuYvomoyv8IpMWX_4dliXnO2aMktdp64GPvcgSDkNwjUPom5sh3WknbMe3kczXX3ZeHG-t1mZloYblFb1sS58IyJEG2nLkv3z0_dOP8BhmKuVs7b_7FdsiAM6nwNfU2u--zqpHrkC5qAeRn7LyheRLUtxzlvOCXw4RtDo0kvmlTkkYDk5-aa4Xk-apnqpdM-MYGHhbFt4aKvQ","text":"OTP Verification Successful"}

class VerifyOtpResponse {
  VerifyOtpResponse({
      this.error, 
      this.statusCode, 
      this.statusMessage, 
      this.data,});

  VerifyOtpResponse.fromJson(dynamic json) {
    error = json['error'];
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    data = json['data'] != null ? VerifyOtpResponseData.fromJson(json['data']) : null;
  }
  bool? error;
  int? statusCode;
  String? statusMessage;
  VerifyOtpResponseData? data;

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

/// isRegister : 1
/// userId : "6CBF34C6-A15A-4C97-8DED-9C6794A16C68"
/// accessToken : "ctC6zqw4r9_tLcNriuWk9syXrJvce3W4MpgLb-6Nrdz4Xv1NA5B8ccR-4Ybvt0H_w8aLmNElQIq4_xr2lXmcb1XXCgBoi7F27Fc4ma3Nlq1cQeh-Og_Gylr3AfVT6SSUrne3-hhUX3oWYqSOQI0MTdgMglXMrmyI-VneDVQs15neWcnKExuF4Cw0DFYjaPf23QYxT31Jwaj1z-9ow6q__XVP1bXTf_qDaIt-3U1YyoEIacvCEMKtDyE-o-__sXa7obcF1wGvUPSfYX9891T9iocuv_dhjknv9Q3jDpeTmRhDOenimPmLFNB4NN-y76kqnltHz2hmPFuYvomoyv8IpMWX_4dliXnO2aMktdp64GPvcgSDkNwjUPom5sh3WknbMe3kczXX3ZeHG-t1mZloYblFb1sS58IyJEG2nLkv3z0_dOP8BhmKuVs7b_7FdsiAM6nwNfU2u--zqpHrkC5qAeRn7LyheRLUtxzlvOCXw4RtDo0kvmlTkkYDk5-aa4Xk-apnqpdM-MYGHhbFt4aKvQ"
/// text : "OTP Verification Successful"

class VerifyOtpResponseData {
  VerifyOtpResponseData({
      this.isRegister, 
      this.userId, 
      this.accessToken, 
      this.text,});

  VerifyOtpResponseData.fromJson(dynamic json) {
    isRegister = json['isRegister'];
    userId = json['userId'];
    accessToken = json['accessToken'];
    text = json['text'];
  }
  int? isRegister;
  String? userId;
  String? accessToken;
  String? text;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['isRegister'] = isRegister;
    map['userId'] = userId;
    map['accessToken'] = accessToken;
    map['text'] = text;
    return map;
  }

}