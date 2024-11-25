/// RowsPerPage : 10
/// PageNumber : 1
/// BranchIDF : "8281F828-2F99-457E-AC27-06914ABBE720"

class GetCategoryRequest {
  GetCategoryRequest({
      this.rowsPerPage, 
      this.pageNumber, 
      this.branchIDF,});

  GetCategoryRequest.fromJson(dynamic json) {
    rowsPerPage = json['RowsPerPage'];
    pageNumber = json['PageNumber'];
    branchIDF = json['BranchIDF'];
  }
  int? rowsPerPage;
  int? pageNumber;
  String? branchIDF;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['RowsPerPage'] = rowsPerPage;
    map['PageNumber'] = pageNumber;
    map['BranchIDF'] = branchIDF;
    return map;
  }

}