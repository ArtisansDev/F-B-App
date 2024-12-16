/// SeatID : "935adc24-7acb-491f-9fe9-c90652414adb"

class GetSaatDetailsRequest {
  GetSaatDetailsRequest({this.seatID});

  GetSaatDetailsRequest.fromJson(dynamic json) {
    seatID = json['SeatID'];
  }

  String? seatID;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['SeatID'] = seatID;
    return map;
  }
}
