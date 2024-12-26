class LoginRequest {
  LoginRequest({
    String? phoneNumber,
    String? countryCode,
    String? restaurantIDF,
  }) {
    _phoneNumber = phoneNumber;
    _countryCode = countryCode;
    _restaurantIDF = restaurantIDF;
  }

  LoginRequest.fromJson(dynamic json) {
    _phoneNumber = json['PhoneNumber'];
    _countryCode = json['CountryCode'];
    _restaurantIDF = json['RestaurantIDF'];
  }

  String? _phoneNumber;
  String? _countryCode;
  String? _restaurantIDF;

  String? get phoneNumber => _phoneNumber;
  String? get countryCode => _countryCode;
  String? get restaurantIDF => _restaurantIDF;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['PhoneNumber'] = _phoneNumber;
    map['CountryCode'] = _countryCode;
    map['RestaurantIDF'] = _restaurantIDF;
    return map;
  }
}
