/// error : false
/// statusCode : 200
/// statusMessage : "Data Retrieved Successfully"
/// data : [{"SeatIDP":"99515d50-e9f0-4d9d-a669-7b3dee8e8db7","BranchIDF":"8281f828-2f99-457e-ac27-06914abbe720","RestaurantIDF":"0d74bfa1-af7d-4182-835b-b815c2972591","SeatNumber":"Table-1","SeatingCapacity":4,"CreationDate":"2024-10-22T15:12:09.68","ModificationDate":"2024-10-22T15:12:09.68","SeatType":"Table","IsActive":true,"IsDeleted":false,"UpdationDate":"2024-10-22T15:12:09.68","LocationIDF":"360d5ee5-7d31-4576-adf6-7a3dc88c2a1d","SeatingType":"-","LocationType":"-","TableStatus":"A","OccupiedTrackingOrderID":"","OccupiedOrderID":"00000000-0000-0000-0000-000000000000","TotalPayableAmount":0.00,"OrderDate":"","FormatedOrderDate":"","PaymentStatus":"","OrderStatus":""}]

class GetAllTableStatusResponse {
  GetAllTableStatusResponse({
      bool? error, 
      int? statusCode, 
      String? statusMessage, 
      List<TableStatusData>? data,}){
    _error = error;
    _statusCode = statusCode;
    _statusMessage = statusMessage;
    _data = data;
}

  GetAllTableStatusResponse.fromJson(dynamic json) {
    _error = json['error'];
    _statusCode = json['statusCode'];
    _statusMessage = json['statusMessage'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(TableStatusData.fromJson(v));
      });
    }
  }
  bool? _error;
  int? _statusCode;
  String? _statusMessage;
  List<TableStatusData>? _data;

  bool? get error => _error;
  int? get statusCode => _statusCode;
  String? get statusMessage => _statusMessage;
  List<TableStatusData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['statusCode'] = _statusCode;
    map['statusMessage'] = _statusMessage;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// SeatIDP : "99515d50-e9f0-4d9d-a669-7b3dee8e8db7"
/// BranchIDF : "8281f828-2f99-457e-ac27-06914abbe720"
/// RestaurantIDF : "0d74bfa1-af7d-4182-835b-b815c2972591"
/// SeatNumber : "Table-1"
/// SeatingCapacity : 4
/// CreationDate : "2024-10-22T15:12:09.68"
/// ModificationDate : "2024-10-22T15:12:09.68"
/// SeatType : "Table"
/// IsActive : true
/// IsDeleted : false
/// UpdationDate : "2024-10-22T15:12:09.68"
/// LocationIDF : "360d5ee5-7d31-4576-adf6-7a3dc88c2a1d"
/// SeatingType : "-"
/// LocationType : "-"
/// TableStatus : "A"
/// OccupiedTrackingOrderID : ""
/// OccupiedOrderID : "00000000-0000-0000-0000-000000000000"
/// TotalPayableAmount : 0.00
/// OrderDate : ""
/// FormatedOrderDate : ""
/// PaymentStatus : ""
/// OrderStatus : ""

class TableStatusData {
  TableStatusData({
      String? seatIDP, 
      String? branchIDF, 
      String? restaurantIDF, 
      String? seatNumber, 
      int? seatingCapacity, 
      String? creationDate, 
      String? modificationDate, 
      String? seatType, 
      bool? isActive, 
      bool? isDeleted, 
      String? updationDate, 
      String? locationIDF, 
      String? seatingType, 
      String? locationType, 
      String? tableStatus, 
      String? occupiedTrackingOrderID, 
      String? occupiedOrderID, 
      double? totalPayableAmount, 
      String? orderDate, 
      String? formatedOrderDate, 
      String? paymentStatus, 
      String? orderStatus,}){
    _seatIDP = seatIDP;
    _branchIDF = branchIDF;
    _restaurantIDF = restaurantIDF;
    _seatNumber = seatNumber;
    _seatingCapacity = seatingCapacity;
    _creationDate = creationDate;
    _modificationDate = modificationDate;
    _seatType = seatType;
    _isActive = isActive;
    _isDeleted = isDeleted;
    _updationDate = updationDate;
    _locationIDF = locationIDF;
    _seatingType = seatingType;
    _locationType = locationType;
    _tableStatus = tableStatus;
    _occupiedTrackingOrderID = occupiedTrackingOrderID;
    _occupiedOrderID = occupiedOrderID;
    _totalPayableAmount = totalPayableAmount;
    _orderDate = orderDate;
    _formatedOrderDate = formatedOrderDate;
    _paymentStatus = paymentStatus;
    _orderStatus = orderStatus;
}

  TableStatusData.fromJson(dynamic json) {
    _seatIDP = json['SeatIDP'];
    _branchIDF = json['BranchIDF'];
    _restaurantIDF = json['RestaurantIDF'];
    _seatNumber = json['SeatNumber'];
    _seatingCapacity = json['SeatingCapacity'];
    _creationDate = json['CreationDate'];
    _modificationDate = json['ModificationDate'];
    _seatType = json['SeatType'];
    _isActive = json['IsActive'];
    _isDeleted = json['IsDeleted'];
    _updationDate = json['UpdationDate'];
    _locationIDF = json['LocationIDF'];
    _seatingType = json['SeatingType'];
    _locationType = json['LocationType'];
    _tableStatus = json['TableStatus'];
    _occupiedTrackingOrderID = json['OccupiedTrackingOrderID'];
    _occupiedOrderID = json['OccupiedOrderID'];
    _totalPayableAmount = json['TotalPayableAmount'];
    _orderDate = json['OrderDate'];
    _formatedOrderDate = json['FormatedOrderDate'];
    _paymentStatus = json['PaymentStatus'];
    _orderStatus = json['OrderStatus'];
  }
  String? _seatIDP;
  String? _branchIDF;
  String? _restaurantIDF;
  String? _seatNumber;
  int? _seatingCapacity;
  String? _creationDate;
  String? _modificationDate;
  String? _seatType;
  bool? _isActive;
  bool? _isDeleted;
  String? _updationDate;
  String? _locationIDF;
  String? _seatingType;
  String? _locationType;
  String? _tableStatus;
  String? _occupiedTrackingOrderID;
  String? _occupiedOrderID;
  double? _totalPayableAmount;
  String? _orderDate;
  String? _formatedOrderDate;
  String? _paymentStatus;
  String? _orderStatus;

  String? get seatIDP => _seatIDP;
  String? get branchIDF => _branchIDF;
  String? get restaurantIDF => _restaurantIDF;
  String? get seatNumber => _seatNumber;
  int? get seatingCapacity => _seatingCapacity;
  String? get creationDate => _creationDate;
  String? get modificationDate => _modificationDate;
  String? get seatType => _seatType;
  bool? get isActive => _isActive;
  bool? get isDeleted => _isDeleted;
  String? get updationDate => _updationDate;
  String? get locationIDF => _locationIDF;
  String? get seatingType => _seatingType;
  String? get locationType => _locationType;
  String? get tableStatus => _tableStatus;
  String? get occupiedTrackingOrderID => _occupiedTrackingOrderID;
  String? get occupiedOrderID => _occupiedOrderID;
  double? get totalPayableAmount => _totalPayableAmount;
  String? get orderDate => _orderDate;
  String? get formatedOrderDate => _formatedOrderDate;
  String? get paymentStatus => _paymentStatus;
  String? get orderStatus => _orderStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['SeatIDP'] = _seatIDP;
    map['BranchIDF'] = _branchIDF;
    map['RestaurantIDF'] = _restaurantIDF;
    map['SeatNumber'] = _seatNumber;
    map['SeatingCapacity'] = _seatingCapacity;
    map['CreationDate'] = _creationDate;
    map['ModificationDate'] = _modificationDate;
    map['SeatType'] = _seatType;
    map['IsActive'] = _isActive;
    map['IsDeleted'] = _isDeleted;
    map['UpdationDate'] = _updationDate;
    map['LocationIDF'] = _locationIDF;
    map['SeatingType'] = _seatingType;
    map['LocationType'] = _locationType;
    map['TableStatus'] = _tableStatus;
    map['OccupiedTrackingOrderID'] = _occupiedTrackingOrderID;
    map['OccupiedOrderID'] = _occupiedOrderID;
    map['TotalPayableAmount'] = _totalPayableAmount;
    map['OrderDate'] = _orderDate;
    map['FormatedOrderDate'] = _formatedOrderDate;
    map['PaymentStatus'] = _paymentStatus;
    map['OrderStatus'] = _orderStatus;
    return map;
  }

}