/// orderHistoryId : ["AddressIDP","06cb1aa4-417c-42de-a139-a329b096484e"]

class OrderHistoryIdModel {
  OrderHistoryIdModel({
      List<String>? orderHistoryId,}){
    _orderHistoryId = orderHistoryId;
}

  OrderHistoryIdModel.fromJson(dynamic json) {
    _orderHistoryId = json['orderHistoryId'] != null ? json['orderHistoryId'].cast<String>() : [];
  }
  List<String>? _orderHistoryId;

  List<String>? get orderHistoryId => _orderHistoryId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['orderHistoryId'] = _orderHistoryId;
    return map;
  }

}