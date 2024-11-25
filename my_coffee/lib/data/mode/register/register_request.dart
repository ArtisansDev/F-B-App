/// Email : "testapi135@gmail.com"
/// FirstName : "John"
/// LastName : "Doe"
/// PhoneNumber : "0987654321"

class RegisterRequest {
  RegisterRequest({
      this.email, 
      this.firstName, 
      this.lastName, 
      this.countryCode,
      this.phoneNumber,});

  RegisterRequest.fromJson(dynamic json) {
    email = json['Email'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    phoneNumber = json['PhoneNumber'];
    countryCode = json['CountryCode'];
  }
  String? email;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? countryCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Email'] = email;
    map['FirstName'] = firstName;
    map['LastName'] = lastName;
    map['PhoneNumber'] = phoneNumber;
    map['CountryCode'] = countryCode;
    return map;
  }

}