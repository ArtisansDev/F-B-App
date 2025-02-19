/// error : false
/// statusCode : 200
/// statusMessage : "Data Retrieved Successfully"
/// data : {"SeatIDP":"8ebd1bd7-ee5f-4f8c-9acf-ffae896d52d0","BranchIDF":"8281f828-2f99-457e-ac27-06914abbe720","RestaurantIDF":"0d74bfa1-af7d-4182-835b-b815c2972591","RestaurantName":"Apple Cinemas","BranchName":"Apple Cinema - Sarkhej, Ahmedabad","SeatNumber":"Table-542","QRCode":"QR_638696886138413141.png","LocationType":"Garden Area","LocationIDF":"c0184e43-2dbc-4ee7-8e6e-a80f6aebfe0a","SeatingCapacity":5,"Seattype":"Table"}

class GetSeatDetailResponse {
  GetSeatDetailResponse({
    bool? error,
    int? statusCode,
    String? statusMessage,
    GetSeatDetailResponseData? data,}) {
    _error = error;
    _statusCode = statusCode;
    _statusMessage = statusMessage;
    _data = data;
  }

  GetSeatDetailResponse.fromJson(dynamic json) {
    _error = json['error'];
    _statusCode = json['statusCode'];
    _statusMessage = json['statusMessage'];
    _data = json['data'] != null
        ? GetSeatDetailResponseData.fromJson(json['data'])
        : null;
  }

  bool? _error;
  int? _statusCode;
  String? _statusMessage;
  GetSeatDetailResponseData? _data;

  bool? get error => _error;

  int? get statusCode => _statusCode;

  String? get statusMessage => _statusMessage;

  GetSeatDetailResponseData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['statusCode'] = _statusCode;
    map['statusMessage'] = _statusMessage;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// SeatIDP : "8ebd1bd7-ee5f-4f8c-9acf-ffae896d52d0"
/// BranchIDF : "8281f828-2f99-457e-ac27-06914abbe720"
/// RestaurantIDF : "0d74bfa1-af7d-4182-835b-b815c2972591"
/// RestaurantName : "Apple Cinemas"
/// BranchName : "Apple Cinema - Sarkhej, Ahmedabad"
/// SeatNumber : "Table-542"
/// QRCode : "QR_638696886138413141.png"
/// LocationType : "Garden Area"
/// LocationIDF : "c0184e43-2dbc-4ee7-8e6e-a80f6aebfe0a"
/// SeatingCapacity : 5
/// Seattype : "Table"

class GetSeatDetailResponseData {
  GetSeatDetailResponseData({
    String? seatIDP,
    String? branchIDF,
    String? restaurantIDF,
    String? restaurantName,
    String? branchName,
    String? seatNumber,
    String? qRCode,
    String? locationType,
    String? locationIDF,
    int? seatingCapacity,
    String? seattype,}) {
    _seatIDP = seatIDP;
    _branchIDF = branchIDF;
    _restaurantIDF = restaurantIDF;
    _restaurantName = restaurantName;
    _branchName = branchName;
    _seatNumber = seatNumber;
    _qRCode = qRCode;
    _locationType = locationType;
    _locationIDF = locationIDF;
    _seatingCapacity = seatingCapacity;
    _seattype = seattype;
  }

  GetSeatDetailResponseData.fromJson(dynamic json) {
    _seatIDP = json['SeatIDP'];
    _branchIDF = json['BranchIDF'];
    _restaurantIDF = json['RestaurantIDF'];
    _restaurantName = json['RestaurantName'];
    _branchName = json['BranchName'];
    _seatNumber = json['SeatNumber'];
    _qRCode = json['QRCode'];
    _locationType = json['LocationType'];
    _locationIDF = json['LocationIDF'];
    _seatingCapacity = json['SeatingCapacity'];
    _seattype = json['Seattype'];
  }

  String? _seatIDP;
  String? _branchIDF;
  String? _restaurantIDF;
  String? _restaurantName;
  String? _branchName;
  String? _seatNumber;
  String? _qRCode;
  String? _locationType;
  String? _locationIDF;
  int? _seatingCapacity;
  String? _seattype;

  String? get seatIDP => _seatIDP;

  String? get branchIDF => _branchIDF;

  String? get restaurantIDF => _restaurantIDF;

  String? get restaurantName => _restaurantName;

  String? get branchName => _branchName;

  String? get seatNumber => _seatNumber;

  String? get qRCode => _qRCode;

  String? get locationType => _locationType;

  String? get locationIDF => _locationIDF;

  int? get seatingCapacity => _seatingCapacity;

  String? get seattype => _seattype;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['SeatIDP'] = _seatIDP;
    map['BranchIDF'] = _branchIDF;
    map['RestaurantIDF'] = _restaurantIDF;
    map['RestaurantName'] = _restaurantName;
    map['BranchName'] = _branchName;
    map['SeatNumber'] = _seatNumber;
    map['QRCode'] = _qRCode;
    map['LocationType'] = _locationType;
    map['LocationIDF'] = _locationIDF;
    map['SeatingCapacity'] = _seatingCapacity;
    map['Seattype'] = _seattype;
    return map;
  }

}