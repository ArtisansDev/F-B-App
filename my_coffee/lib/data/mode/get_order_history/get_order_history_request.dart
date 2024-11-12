/// UserIDF : "935adc24-7acb-491f-9fe9-c90652414adb"

class GetOrderHistoryRequest {
  GetOrderHistoryRequest({
      this.userIDF,});

  GetOrderHistoryRequest.fromJson(dynamic json) {
    userIDF = json['UserIDF'];
  }
  String? userIDF;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['UserIDF'] = userIDF;
    return map;
  }

}