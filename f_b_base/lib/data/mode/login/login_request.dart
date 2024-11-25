class LoginRequest {
  LoginRequest({
    String? phoneNumber,
    String? countryCode,
  }) {
    _phoneNumber = phoneNumber;
    _countryCode = countryCode;
  }

  LoginRequest.fromJson(dynamic json) {
    _phoneNumber = json['PhoneNumber'];
    _countryCode = json['CountryCode'];
  }

  String? _phoneNumber;
  String? _countryCode;

  String? get phoneNumber => _phoneNumber;
  String? get countryCode => _countryCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['PhoneNumber'] = _phoneNumber;
    map['CountryCode'] = _countryCode;
    return map;
  }
}
