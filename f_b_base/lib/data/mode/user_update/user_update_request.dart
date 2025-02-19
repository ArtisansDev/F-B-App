/// UserID : "dca29073-0eda-435c-81f9-40bce2f34aa7"
/// Email : "testapi12@gmail.com"
/// FirstName : "Jeel"
/// LastName : "Doe"
/// PhoneNumber : "1234567290"

class UserUpdateRequest {
  UserUpdateRequest({
      this.userID, 
      this.email, 
      this.firstName, 
      this.lastName, 
      this.phoneNumber,});

  UserUpdateRequest.fromJson(dynamic json) {
    userID = json['UserID'];
    email = json['Email'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    phoneNumber = json['PhoneNumber'];
  }
  String? userID;
  String? email;
  String? firstName;
  String? lastName;
  String? phoneNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['UserID'] = userID;
    map['Email'] = email;
    map['FirstName'] = firstName;
    map['LastName'] = lastName;
    map['PhoneNumber'] = phoneNumber;
    return map;
  }

}