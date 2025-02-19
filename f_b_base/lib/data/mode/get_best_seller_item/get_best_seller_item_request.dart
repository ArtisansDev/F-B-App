/// BranchIDF : "00000000-0000-0000-0000-000000000000"
/// RestaurantIDF : "0D74BFA1-AF7D-4182-835B-B815C2972591"

class GetBestSellerItemRequest {
  GetBestSellerItemRequest({
      this.branchIDF, 
      this.restaurantIDF,});

  GetBestSellerItemRequest.fromJson(dynamic json) {
    branchIDF = json['BranchIDF'];
    restaurantIDF = json['RestaurantIDF'];
  }
  String? branchIDF;
  String? restaurantIDF;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['BranchIDF'] = branchIDF;
    map['RestaurantIDF'] = restaurantIDF;
    return map;
  }

}