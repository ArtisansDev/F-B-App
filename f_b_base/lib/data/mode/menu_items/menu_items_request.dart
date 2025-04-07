/// RowsPerPage : 4
/// PageNumber : 1
/// BranchIDF : "8281F828-2F99-457E-AC27-06914ABBE720"
/// RestaurantIDF : "5062DBB1-190D-4A9E-8597-2450678951F1"
/// SearchValue : "Veg"

class MenuItemsRequest {
  MenuItemsRequest({
      int? rowsPerPage, 
      int? pageNumber, 
      String? branchIDF, 
      String? restaurantIDF, 
      String? searchValue,}){
    _rowsPerPage = rowsPerPage;
    _pageNumber = pageNumber;
    _branchIDF = branchIDF;
    _restaurantIDF = restaurantIDF;
    _searchValue = searchValue;
}

  MenuItemsRequest.fromJson(dynamic json) {
    _rowsPerPage = json['RowsPerPage'];
    _pageNumber = json['PageNumber'];
    _branchIDF = json['BranchIDF'];
    _restaurantIDF = json['RestaurantIDF'];
    _searchValue = json['SearchValue'];
  }
  int? _rowsPerPage;
  int? _pageNumber;
  String? _branchIDF;
  String? _restaurantIDF;
  String? _searchValue;

  int? get rowsPerPage => _rowsPerPage;
  int? get pageNumber => _pageNumber;
  String? get branchIDF => _branchIDF;
  String? get restaurantIDF => _restaurantIDF;
  String? get searchValue => _searchValue;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['RowsPerPage'] = _rowsPerPage;
    map['PageNumber'] = _pageNumber;
    map['BranchIDF'] = _branchIDF;
    map['RestaurantIDF'] = _restaurantIDF;
    map['SearchValue'] = _searchValue;
    return map;
  }

}