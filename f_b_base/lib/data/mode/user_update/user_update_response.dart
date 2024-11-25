/// error : false
/// statusCode : 200
/// statusMessage : "Record Updated Successfully."

class UserUpdateResponse {
  UserUpdateResponse({
      this.error, 
      this.statusCode, 
      this.statusMessage,});

  UserUpdateResponse.fromJson(dynamic json) {
    error = json['error'];
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
  }
  bool? error;
  int? statusCode;
  String? statusMessage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = error;
    map['statusCode'] = statusCode;
    map['statusMessage'] = statusMessage;
    return map;
  }

}