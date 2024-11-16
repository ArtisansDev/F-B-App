/// AddressIDP : ""
/// UserIDF : "1986AD2B-EF7C-428E-BCC7-ABAC59001D8D"
/// AddressType : "1"
/// Address : "1234567 Elm Street, Springfield, USA"

class UserUpdateAddressRequest {
  UserUpdateAddressRequest({
      this.addressIDP, 
      this.userIDF, 
      this.addressType, 
      this.address,});

  UserUpdateAddressRequest.fromJson(dynamic json) {
    addressIDP = json['AddressIDP'];
    userIDF = json['UserIDF'];
    addressType = json['AddressType'];
    address = json['Address'];
  }
  String? addressIDP;
  String? userIDF;
  String? addressType;
  String? address;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['AddressIDP'] = addressIDP;
    map['UserIDF'] = userIDF;
    map['AddressType'] = addressType;
    map['Address'] = address;
    return map;
  }

}