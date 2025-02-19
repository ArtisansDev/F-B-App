/// success : true
/// message : "Login successfully."
/// code : 200

class LogoutResponse {
  LogoutResponse({
    this.success,
    this.message,
    this.code,
  });

  LogoutResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    code = json['code'];
  }

  bool? success;
  String? message;
  int? code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    map['code'] = code;
    return map;
  }
}

