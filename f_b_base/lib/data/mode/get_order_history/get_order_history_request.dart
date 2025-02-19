/// UserIDF : "935adc24-7acb-491f-9fe9-c90652414adb"

class GetOrderHistoryRequest {
  GetOrderHistoryRequest({
      this.userIDF,this.orderID,this.restaurantID, this.rowsPerPage, this.pageNumber,});

  GetOrderHistoryRequest.fromJson(dynamic json) {
    rowsPerPage = json['RowsPerPage'];
    pageNumber = json['PageNumber'];
    userIDF = json['UserIDF'];
    orderID = json['OrderID'];
    restaurantID = json['RestaurantID'];
  }
  String? userIDF;
  String? orderID;
  String? restaurantID;
  int? pageNumber;
  int? rowsPerPage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['UserIDF'] = userIDF;
    if(orderID!=null) {
      map['OrderID'] = orderID;
    }
    if(restaurantID!=null) {
      map['RestaurantID'] = restaurantID;
    }
    map['RowsPerPage'] = rowsPerPage??0;
    map['PageNumber'] = pageNumber??1;
    return map;
  }

}