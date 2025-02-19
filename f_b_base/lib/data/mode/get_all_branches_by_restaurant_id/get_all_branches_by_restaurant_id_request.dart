/// RowsPerPage : 10
/// PageNumber : 1
/// RestaurantIDF : "0D74BFA1-AF7D-4182-835B-B815C2972591"
/// BranchIDP : null
/// SearchValue : "jahan"
/// TodayDate : "2024-10-18"

class GetAllBranchesByRestaurantIdRequest {
  GetAllBranchesByRestaurantIdRequest({
      this.rowsPerPage, 
      this.pageNumber, 
      this.restaurantIDF, 
      this.branchIDP,
      this.searchValue,
      this.todayDate,});

  GetAllBranchesByRestaurantIdRequest.fromJson(dynamic json) {
    rowsPerPage = json['RowsPerPage'];
    pageNumber = json['PageNumber'];
    restaurantIDF = json['RestaurantIDF'];
    branchIDP = json['BranchIDP'];
    searchValue = json['SearchValue'];
    todayDate = json['TodayDate'];
  }
  int? rowsPerPage;
  int? pageNumber;
  String? restaurantIDF;
  String? branchIDP;
  String? searchValue;
  String? todayDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['RowsPerPage'] = rowsPerPage;
    map['PageNumber'] = pageNumber;
    map['RestaurantIDF'] = restaurantIDF;
    if((branchIDP??'').isEmpty){
      map['BranchIDP'] = null;
    }else{
      map['BranchIDP'] = branchIDP;
    }
    map['SearchValue'] = searchValue;
    map['TodayDate'] = todayDate;
    return map;
  }

}