/// RowsPerPage : 4
/// PageNumber : 1
/// BranchIDF : "8281F828-2F99-457E-AC27-06914ABBE720"
/// CategoryIDF : "5062DBB1-190D-4A9E-8597-2450678951F1"

class GetCategoryItemRequest {
  GetCategoryItemRequest({
      this.rowsPerPage, 
      this.pageNumber, 
      this.branchIDF, 
      this.categoryIDF,});

  GetCategoryItemRequest.fromJson(dynamic json) {
    rowsPerPage = json['RowsPerPage'];
    pageNumber = json['PageNumber'];
    branchIDF = json['BranchIDF'];
    categoryIDF = json['CategoryIDF'];
  }
  int? rowsPerPage;
  int? pageNumber;
  String? branchIDF;
  String? categoryIDF;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['RowsPerPage'] = rowsPerPage;
    map['PageNumber'] = pageNumber;
    map['BranchIDF'] = branchIDF;
    map['CategoryIDF'] = categoryIDF;
    return map;
  }

}