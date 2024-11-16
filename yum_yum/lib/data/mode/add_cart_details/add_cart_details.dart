// /*
//  * Project      : my_coffee
//  * File         : add_cart_details.dart
//  * Description  :
//  * Author       : parthapaul
//  * Date         : 2024-10-28
//  * Version      : 1.0
//  * Ticket       :
//  */
//
// import '../get_item_details/get_item_details_response.dart';
//
// class AddCartDetails {
//   AddCartDetails({
//     this.mAddCartDetailsData,});
//
//   List<AddCartDetailsData>? mAddCartDetailsData;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     if (mAddCartDetailsData != null) {
//       map['data'] = mAddCartDetailsData?.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
//
// }
//
// class AddCartDetailsData {
//   double? total;
//   double? perItemTotal;
//   GetItemDetailsData? mGetItemDetailsData;
//   int? count;
//   AddCartDetailsData({
//     this.mGetItemDetailsData,
//     this.total,
//     this.perItemTotal,
//     this.count,
//     });
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['item_details'] = mGetItemDetailsData;
//     map['perItemTotal'] = perItemTotal;
//     map['total'] = total;
//     map['count'] = count;
//     return map;
//   }
// }