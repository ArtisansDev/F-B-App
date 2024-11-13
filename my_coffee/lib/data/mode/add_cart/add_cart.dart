/*
 * Project      : my_coffee
 * File         : add_cart.dart
 * Description  : 
 * Author       : parthapaul
 * Date         : 2024-10-31
 * Version      : 1.0
 * Ticket       : 
 */

import '../get_all_branches_by_restaurant_id/get_all_branches_by_restaurant_id_response.dart';
import '../get_item_details/get_item_details_response.dart';
import '../get_order_history/order_history_response.dart';

class AddCartModel {
  GetAllBranchesListData? mGetAllBranchesListData;
  OrderHistoryResponseItemData? mOrderHistoryResponseItemData;
  double? totalAmount;
  String? sTableNo = '';
  String? sOrderDateTime = '';
  String? sType = 'Take';
  List<GetItemDetailsData>? mItems;

  AddCartModel({
    this.mOrderHistoryResponseItemData,
    this.mGetAllBranchesListData,
    this.totalAmount,
    this.sTableNo,
    this.sOrderDateTime,
    this.sType,
    this.mItems,
  });

  AddCartModel.fromJson(dynamic json) {
    totalAmount = json['totalAmount'];
    sTableNo = json['table_no'] ?? '';
    sOrderDateTime = json['sOrderDateTime'] ?? '';
    sType = json['type'] ?? 'Take';
    totalAmount = json['totalAmount'];
    mGetAllBranchesListData = json['branches'] != null
        ? GetAllBranchesListData.fromJson(json['branches'])
        : null;
    mOrderHistoryResponseItemData =
        json['order_history_response_item_data'] != null
            ? OrderHistoryResponseItemData.fromJson(
                json['order_history_response_item_data'])
            : null;
    if (json['item'] != null) {
      mItems = [];
      json['item'].forEach((v) {
        mItems?.add(GetItemDetailsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['order_history_response_item_data'] = mOrderHistoryResponseItemData;
    map['totalAmount'] = totalAmount;
    map['sOrderDateTime'] = sOrderDateTime;
    map['branches'] = mGetAllBranchesListData;
    map['item'] = mItems;
    map['type'] = sType;
    map['table_no'] = sTableNo;
    return map;
  }
}
