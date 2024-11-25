/// error : false
/// statusCode : 200
/// statusMessage : "Address inserted successfully."
/// data : null

class UserUpdateAddressResponse {
  UserUpdateAddressResponse({
      this.error, 
      this.statusCode, 
      this.statusMessage, 
      this.data,});

  UserUpdateAddressResponse.fromJson(dynamic json) {
    error = json['error'];
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    data = json['data'];
  }
  bool? error;
  int? statusCode;
  String? statusMessage;
  dynamic data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = error;
    map['statusCode'] = statusCode;
    map['statusMessage'] = statusMessage;
    map['data'] = data;
    return map;
  }

}