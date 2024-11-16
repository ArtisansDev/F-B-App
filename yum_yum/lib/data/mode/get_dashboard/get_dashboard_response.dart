import '../get_best_seller_item/get_best_seller_item_response.dart';

/// error : false
/// statusCode : 200
/// statusMessage : "Data Retrieved Successfully"
/// data : {"BestSellingItems":[{"MenuItemIDP":"6cf9a467-2f6e-4d6b-9bd0-c5f9855b13ee","ItemName":"Black Forest","ItemImagePath":"http://13.53.89.14:801/admin/Content/Images/Menu/MENU_638512685807955011.jpg","Price":"300.00-600.00"},{"MenuItemIDP":"59943fe0-f04b-4818-ba19-56e49255ff0d","ItemName":"Choco Delight","ItemImagePath":"http://13.53.89.14:801/admin/Content/Images/Menu/MENU_638512687582515782.jpeg","Price":"899.00"},{"MenuItemIDP":"f1d92d51-7531-42f7-81fc-a2f7739c723e","ItemName":"Blueberry Cake","ItemImagePath":"http://13.53.89.14:801/admin/Content/Images/Menu/MENU_638512665490207282.jpg","Price":"250.00-60.00"},{"MenuItemIDP":"7c9c2530-7c96-41ef-a913-70d6b8fd5112","ItemName":"Red velvet Cake","ItemImagePath":"http://13.53.89.14:801/admin/Content/Images/Menu/MENU_638473945205686724.png","Price":"1,199.00-99.00"},{"MenuItemIDP":"95dd43bf-21e6-4511-b455-90f31e869197","ItemName":"Onion Pizza","ItemImagePath":"http://13.53.89.14:801/admin/Content/Images/Menu/MENU_638513764741527298.jpg","Price":"200.00"},{"MenuItemIDP":"7ae3005c-2c9d-4c85-a3cf-9ca1d6f00261","ItemName":"Apple SP. Pizza","ItemImagePath":"http://13.53.89.14:801/admin/Content/Images/Menu/MENU_638513767055194045.jpg","Price":"330.00"},{"MenuItemIDP":"2616c8e9-44fe-4e3d-915c-ab06378ea708","ItemName":"Cheesy Heaven Pizza","ItemImagePath":"http://13.53.89.14:801/admin/Content/Images/Menu/MENU_638513757193093293.jpg","Price":"280.00"},{"MenuItemIDP":"572146be-2b14-47c6-90d9-c311c130e8d0","ItemName":"Margarita Pizza","ItemImagePath":"http://13.53.89.14:801/admin/Content/Images/Menu/MENU_638513753214558267.jpg","Price":"200.00"},{"MenuItemIDP":"79755791-bf97-4f5e-80fa-a6df2f54a3ad","ItemName":"Aloo Matar Cheese Sandwich","ItemImagePath":"http://13.53.89.14:801/admin/Content/Images/Menu/MENU_638513817981474688.jpg","Price":"140.00-220.00"},{"MenuItemIDP":"a9bae90d-b74e-4c00-91ac-eeb264800990","ItemName":"Cheese Garlic Bread","ItemImagePath":"http://13.53.89.14:801/admin/Content/Images/Menu/MENU_638513835842459972.jpg","Price":"150.00"}],"BannerMaster":[{"BannerImagePath":"http://13.53.89.14:801/admin/Content/Images/Banner/Banner_638652222203600502.jpg"}]}

class GetDashboardResponse {
  GetDashboardResponse({
      this.error, 
      this.statusCode, 
      this.statusMessage, 
      this.mGetDashboardData,});

  GetDashboardResponse.fromJson(dynamic json) {
    error = json['error'];
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    mGetDashboardData = json['data'] != null ? GetDashboardData.fromJson(json['data']) : null;
  }
  bool? error;
  int? statusCode;
  String? statusMessage;
  GetDashboardData? mGetDashboardData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = error;
    map['statusCode'] = statusCode;
    map['statusMessage'] = statusMessage;
    if (mGetDashboardData != null) {
      map['data'] = mGetDashboardData?.toJson();
    }
    return map;
  }

}

/// BestSellingItems : [{"MenuItemIDP":"6cf9a467-2f6e-4d6b-9bd0-c5f9855b13ee","ItemName":"Black Forest","ItemImagePath":"http://13.53.89.14:801/admin/Content/Images/Menu/MENU_638512685807955011.jpg","Price":"300.00-600.00"},{"MenuItemIDP":"59943fe0-f04b-4818-ba19-56e49255ff0d","ItemName":"Choco Delight","ItemImagePath":"http://13.53.89.14:801/admin/Content/Images/Menu/MENU_638512687582515782.jpeg","Price":"899.00"},{"MenuItemIDP":"f1d92d51-7531-42f7-81fc-a2f7739c723e","ItemName":"Blueberry Cake","ItemImagePath":"http://13.53.89.14:801/admin/Content/Images/Menu/MENU_638512665490207282.jpg","Price":"250.00-60.00"},{"MenuItemIDP":"7c9c2530-7c96-41ef-a913-70d6b8fd5112","ItemName":"Red velvet Cake","ItemImagePath":"http://13.53.89.14:801/admin/Content/Images/Menu/MENU_638473945205686724.png","Price":"1,199.00-99.00"},{"MenuItemIDP":"95dd43bf-21e6-4511-b455-90f31e869197","ItemName":"Onion Pizza","ItemImagePath":"http://13.53.89.14:801/admin/Content/Images/Menu/MENU_638513764741527298.jpg","Price":"200.00"},{"MenuItemIDP":"7ae3005c-2c9d-4c85-a3cf-9ca1d6f00261","ItemName":"Apple SP. Pizza","ItemImagePath":"http://13.53.89.14:801/admin/Content/Images/Menu/MENU_638513767055194045.jpg","Price":"330.00"},{"MenuItemIDP":"2616c8e9-44fe-4e3d-915c-ab06378ea708","ItemName":"Cheesy Heaven Pizza","ItemImagePath":"http://13.53.89.14:801/admin/Content/Images/Menu/MENU_638513757193093293.jpg","Price":"280.00"},{"MenuItemIDP":"572146be-2b14-47c6-90d9-c311c130e8d0","ItemName":"Margarita Pizza","ItemImagePath":"http://13.53.89.14:801/admin/Content/Images/Menu/MENU_638513753214558267.jpg","Price":"200.00"},{"MenuItemIDP":"79755791-bf97-4f5e-80fa-a6df2f54a3ad","ItemName":"Aloo Matar Cheese Sandwich","ItemImagePath":"http://13.53.89.14:801/admin/Content/Images/Menu/MENU_638513817981474688.jpg","Price":"140.00-220.00"},{"MenuItemIDP":"a9bae90d-b74e-4c00-91ac-eeb264800990","ItemName":"Cheese Garlic Bread","ItemImagePath":"http://13.53.89.14:801/admin/Content/Images/Menu/MENU_638513835842459972.jpg","Price":"150.00"}]
/// BannerMaster : [{"BannerImagePath":"http://13.53.89.14:801/admin/Content/Images/Banner/Banner_638652222203600502.jpg"}]

class GetDashboardData {
  GetDashboardData({
      this.bestSellingItems, 
      this.bannerMaster,});

  GetDashboardData.fromJson(dynamic json) {
    if (json['BestSellingItems'] != null) {
      bestSellingItems = [];
      json['BestSellingItems'].forEach((v) {
        bestSellingItems?.add(GetBestSellerItemData.fromJson(v));
      });
    }
    if (json['BannerMaster'] != null) {
      bannerMaster = [];
      json['BannerMaster'].forEach((v) {
        bannerMaster?.add(BannerMaster.fromJson(v));
      });
    }
  }
  List<GetBestSellerItemData>? bestSellingItems;
  List<BannerMaster>? bannerMaster;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (bestSellingItems != null) {
      map['BestSellingItems'] = bestSellingItems?.map((v) => v.toJson()).toList();
    }
    if (bannerMaster != null) {
      map['BannerMaster'] = bannerMaster?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// BannerImagePath : "http://13.53.89.14:801/admin/Content/Images/Banner/Banner_638652222203600502.jpg"

class BannerMaster {
  BannerMaster({
      this.bannerImagePath,});

  BannerMaster.fromJson(dynamic json) {
    bannerImagePath = json['BannerImagePath'];
  }
  String? bannerImagePath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['BannerImagePath'] = bannerImagePath;
    return map;
  }

}