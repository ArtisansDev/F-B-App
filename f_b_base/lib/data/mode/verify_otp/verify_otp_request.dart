class VerifyOtpRequest {
  VerifyOtpRequest({
    String? countryCode,
    String? phoneNumber,
    String? otp,
  }) {
    _countryCode = countryCode;
    _phoneNumber = phoneNumber;
    _otp = otp;
  }

  VerifyOtpRequest.fromJson(dynamic json) {
    _phoneNumber = json['PhoneNumber'];
    _countryCode = json['CountryCode'];
    _otp = json['OTP'];
  }

  String? _phoneNumber;
  String? _countryCode;
  String? _otp;

  String? get countryCode => _countryCode;
  String? get phoneNumber => _phoneNumber;
  String? get otp => _otp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['CountryCode'] = _countryCode;
    map['PhoneNumber'] = _phoneNumber;
    map['OTP'] = _otp;
    return map;
  }
}
