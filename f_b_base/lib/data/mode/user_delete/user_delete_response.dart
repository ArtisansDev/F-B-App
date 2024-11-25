/// error : false
/// statusCode : 200
/// statusMessage : "Record deleted successfully"

class UserDeleteResponse {
  UserDeleteResponse({
      this.error, 
      this.statusCode, 
      this.statusMessage,});

  UserDeleteResponse.fromJson(dynamic json) {
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