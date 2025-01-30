/// error : false
/// statusCode : 200
/// statusMessage : "Table cleared and marked as available."
/// data : ""

class SuccessResponse {
  SuccessResponse({
      bool? error, 
      int? statusCode, 
      String? statusMessage, 
      String? data,}){
    _error = error;
    _statusCode = statusCode;
    _statusMessage = statusMessage;
    _data = data;
}

  SuccessResponse.fromJson(dynamic json) {
    _error = json['error'];
    _statusCode = json['statusCode'];
    _statusMessage = json['statusMessage'];
    _data = json['data'];
  }
  bool? _error;
  int? _statusCode;
  String? _statusMessage;
  String? _data;

  bool? get error => _error;
  int? get statusCode => _statusCode;
  String? get statusMessage => _statusMessage;
  String? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['statusCode'] = _statusCode;
    map['statusMessage'] = _statusMessage;
    map['data'] = _data;
    return map;
  }

}