/// error : false
/// statusCode : 200
/// statusMessage : "Data Retrieved Successfully"
/// data : {"TotalRecords":2,"FirstRecord":1,"LastRecord":2,"TotalPage":1,"Data":[{"CategoryIDP":"5062dbb1-190d-4a9e-8597-2450678951f1","CategoryName":"South Indian","CategoryImagePath":"http://13.53.89.14:801/admin/Content/Images/Category/638639949787236857-image3-5-900x601-1.jpg"},{"CategoryIDP":"cc109190-0f7e-4d42-be06-a1c989afee0a","CategoryName":"Chinese","CategoryImagePath":"http://13.53.89.14:801/admin/Content/Images/Category/638640835942095860-Chinese.png"}]}

class GetCategoryResponse {
  GetCategoryResponse({
      this.error, 
      this.statusCode, 
      this.statusMessage, 
      this.data,});

  GetCategoryResponse.fromJson(dynamic json) {
    error = json['error'];
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    data = json['data'] != null ? GetCategoryData.fromJson(json['data']) : null;
  }
  bool? error;
  int? statusCode;
  String? statusMessage;
  GetCategoryData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = error;
    map['statusCode'] = statusCode;
    map['statusMessage'] = statusMessage;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// TotalRecords : 2
/// FirstRecord : 1
/// LastRecord : 2
/// TotalPage : 1
/// Data : [{"CategoryIDP":"5062dbb1-190d-4a9e-8597-2450678951f1","CategoryName":"South Indian","CategoryImagePath":"http://13.53.89.14:801/admin/Content/Images/Category/638639949787236857-image3-5-900x601-1.jpg"},{"CategoryIDP":"cc109190-0f7e-4d42-be06-a1c989afee0a","CategoryName":"Chinese","CategoryImagePath":"http://13.53.89.14:801/admin/Content/Images/Category/638640835942095860-Chinese.png"}]

class GetCategoryData {
  GetCategoryData({
      this.totalRecords, 
      this.firstRecord, 
      this.lastRecord, 
      this.totalPage, 
      this.data,});

  GetCategoryData.fromJson(dynamic json) {
    totalRecords = json['TotalRecords'];
    firstRecord = json['FirstRecord'];
    lastRecord = json['LastRecord'];
    totalPage = json['TotalPage'];
    if (json['Data'] != null) {
      data = [];
      json['Data'].forEach((v) {
        data?.add(GetCategoryListData.fromJson(v));
      });
    }
  }
  int? totalRecords;
  int? firstRecord;
  int? lastRecord;
  int? totalPage;
  List<GetCategoryListData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TotalRecords'] = totalRecords;
    map['FirstRecord'] = firstRecord;
    map['LastRecord'] = lastRecord;
    map['TotalPage'] = totalPage;
    if (data != null) {
      map['Data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// CategoryIDP : "5062dbb1-190d-4a9e-8597-2450678951f1"
/// CategoryName : "South Indian"
/// CategoryImagePath : "http://13.53.89.14:801/admin/Content/Images/Category/638639949787236857-image3-5-900x601-1.jpg"

class GetCategoryListData {
  GetCategoryListData({
      this.categoryIDP, 
      this.categoryName, 
      this.categoryImagePath,});

  GetCategoryListData.fromJson(dynamic json) {
    categoryIDP = json['CategoryIDP'];
    categoryName = json['CategoryName'];
    categoryImagePath = json['CategoryImagePath'];
  }
  String? categoryIDP;
  String? categoryName;
  String? categoryImagePath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['CategoryIDP'] = categoryIDP;
    map['CategoryName'] = categoryName;
    map['CategoryImagePath'] = categoryImagePath;
    return map;
  }

}