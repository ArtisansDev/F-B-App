/// SeatIDP : "55ee032c-20d1-4689-b1d4-01aaee8e4594"
/// UserIDF : "b8f1a827-1234-4f9d-b8bb-c411cd9d8940"
/// TrackingOrderID : "5963522762"
/// TableStatus : "A"

class SetTableStatusRequest {
  SetTableStatusRequest({
      String? seatIDP, 
      String? userIDF, 
      String? trackingOrderID, 
      String? tableStatus,}){
    _seatIDP = seatIDP;
    _userIDF = userIDF;
    _trackingOrderID = trackingOrderID;
    _tableStatus = tableStatus;
}

  SetTableStatusRequest.fromJson(dynamic json) {
    _seatIDP = json['SeatIDP'];
    _userIDF = json['UserIDF'];
    _trackingOrderID = json['TrackingOrderID'];
    _tableStatus = json['TableStatus'];
  }
  String? _seatIDP;
  String? _userIDF;
  String? _trackingOrderID;
  String? _tableStatus;

  String? get seatIDP => _seatIDP;
  String? get userIDF => _userIDF;
  String? get trackingOrderID => _trackingOrderID;
  String? get tableStatus => _tableStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['SeatIDP'] = _seatIDP;
    map['UserIDF'] = _userIDF;
    map['TrackingOrderID'] = _trackingOrderID;
    map['TableStatus'] = _tableStatus;
    return map;
  }

}