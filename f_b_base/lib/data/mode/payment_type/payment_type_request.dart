/// RestaurantIDF : "0D74BFA1-AF7D-4182-835B-B815C2972591"

class PaymentTypeRequest {
  PaymentTypeRequest({
      this.restaurantIDF,});

  PaymentTypeRequest.fromJson(dynamic json) {
    restaurantIDF = json['RestaurantIDF'];
  }
  String? restaurantIDF;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['RestaurantIDF'] = restaurantIDF;
    return map;
  }

}