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

class AddCartModel {
  GetAllBranchesListData? mGetAllBranchesListData;
  double? totalAmount;
  String? sTableNo='';
  String? sType='Take';
  List<GetItemDetailsData>? mItems;

  AddCartModel({
    this.mGetAllBranchesListData,
    this.totalAmount,
    this.sTableNo,
    this.sType,
    this.mItems,
  });

  AddCartModel.fromJson(dynamic json) {
    totalAmount = json['totalAmount'];
    sTableNo = json['table_no']??'';
    sType = json['type']??'Take';
    totalAmount = json['totalAmount'];
    mGetAllBranchesListData = json['branches'] != null
        ? GetAllBranchesListData.fromJson(json['branches'])
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
    map['totalAmount'] = totalAmount;
    map['branches'] = mGetAllBranchesListData;
    map['item'] = mItems;
    map['type'] = sType;
    map['table_no'] = sTableNo;
    return map;
  }
}
