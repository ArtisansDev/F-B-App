/// BranchIDF : "00000000-0000-0000-0000-000000000000"
/// RestaurantIDF : "0D74BFA1-AF7D-4182-835B-B815C2972591"

class GetDashboardRequest {
  GetDashboardRequest({
      this.totalRecord,
      this.restaurantIDF,});

  GetDashboardRequest.fromJson(dynamic json) {
    totalRecord = json['TotalRecord'];
    restaurantIDF = json['RestaurantIDF'];
  }
  String? totalRecord;
  String? restaurantIDF;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TotalRecord'] = totalRecord;
    map['RestaurantIDF'] = restaurantIDF;
    return map;
  }

}