import '../get_category_item/get_category_item_response.dart';

/// error : false
/// statusCode : 200
/// statusMessage : "Data Retrieved Successfully"
/// data : {"TotalRecords":43,"FirstRecord":1,"LastRecord":4,"TotalPage":11,"Data":[{"SrNo":1,"MenuItemIDP":"2A963812-9391-48D3-BE2F-BC5D65E0145D","RestaurantIDF":"0D74BFA1-AF7D-4182-835B-B815C2972591","ItemName":"Veggie Delight Pizza","ItemTaxPercent":0.00,"IsVeg":true,"ModifierIDFs":"2453688d-2b3e-4f8c-b5f8-6b5c7ed9cece,25043742-7d93-4106-a565-5936366e0943,50fc4ee4-eafd-4b66-b13b-f066dab4d857,984e0e5f-4c56-4954-af15-046c4beee6b6,5fdd1b7e-b22b-4ade-9dc3-2594f3778904","Seasonal":"","Description":"<p>Bursting with assorted fresh vegetables for a healthy and flavorful option.</p>","NutritionalInfo":"","Ingredients":"","ApproxCookingHour":0,"ApproxCookingMinute":0,"IsProductOfDay":false,"isActive":true,"IsStockOut":true,"Price":"230.00","VariantData":[{"VariantIDP":"6b43aaaf-4fa8-48b2-b85f-0607d1401a1f","QuantitySpecification":"Regular (12 Inches)","Price":230.00,"DiscountPercentage":0.00,"DiscountedPrice":230.00}],"ItemImages":[{"ItemImagePath":"https://staging.artisanssolutions.com/admin/Content/Images/Menu/MENU_638513759788931489.jpg","ImageIDP":"7DD8FC34-9191-4212-93CF-2B1389558B31"},{"ItemImagePath":"https://staging.artisanssolutions.com/admin/Content/Images/Menu/MENU_638513759788931489.jpg","ImageIDP":"98A77BF0-1E43-4DF5-B8BA-C0DF8285E91C"}]},{"SrNo":2,"MenuItemIDP":"6F761B2B-83FE-46EC-8C8A-4CF44D8ACBED","RestaurantIDF":"0D74BFA1-AF7D-4182-835B-B815C2972591","ItemName":"Vegetable Sandwich","ItemTaxPercent":0.00,"IsVeg":true,"ModifierIDFs":"","Seasonal":"","Description":"A medley of fresh vegetables between slices of soft bread.","NutritionalInfo":"","Ingredients":"","ApproxCookingHour":0,"ApproxCookingMinute":0,"IsProductOfDay":false,"isActive":true,"IsStockOut":false,"Price":"100.00-180.00","VariantData":[{"VariantIDP":"53b2c81d-9b4d-4818-b345-7725cfd67e74","QuantitySpecification":"Regular","Price":100.00,"DiscountPercentage":0.00,"DiscountedPrice":100.00},{"VariantIDP":"21963805-8387-461d-9d8b-f435626390e7","QuantitySpecification":"Grill","Price":180.00,"DiscountPercentage":0.00,"DiscountedPrice":180.00}],"ItemImages":[{"ItemImagePath":"https://staging.artisanssolutions.com/admin/Content/Images/Menu/MENU_638513811041603731.jpg","ImageIDP":"6E573197-9D8A-4B9A-96F8-9CB2A5A26FAA"},{"ItemImagePath":"https://staging.artisanssolutions.com/admin/Content/Images/Menu/MENU_638513811041603731.jpg","ImageIDP":"EC61CA9F-5C4E-4D86-98E7-BD58A34150B9"}]},{"SrNo":3,"MenuItemIDP":"B0AB100A-0F83-4345-B977-A94139899544","RestaurantIDF":"0D74BFA1-AF7D-4182-835B-B815C2972591","ItemName":"Veg. Mexican Pizza","ItemTaxPercent":0.00,"IsVeg":true,"ModifierIDFs":"","Seasonal":"","Description":"A spicy and flavorful combination of Mexican-inspired toppings.","NutritionalInfo":"","Ingredients":"","ApproxCookingHour":0,"ApproxCookingMinute":0,"IsProductOfDay":false,"isActive":true,"IsStockOut":true,"Price":"290.00","VariantData":[{"VariantIDP":"c890d625-cf1a-4692-8054-402406a9e8ff","QuantitySpecification":"Regular (12 Inches)","Price":290.00,"DiscountPercentage":0.00,"DiscountedPrice":290.00}],"ItemImages":[{"ItemImagePath":"https://staging.artisanssolutions.com/admin/Content/Images/Menu/MENU_638513765933399492.jpg","ImageIDP":"E3D2D249-2F34-42DA-AE02-94A4C205AB28"}]},{"SrNo":4,"MenuItemIDP":"88A0FBCA-5B17-4164-A857-4FBB60224E16","RestaurantIDF":"0D74BFA1-AF7D-4182-835B-B815C2972591","ItemName":"Veg. Cheese Sandwich","ItemTaxPercent":0.00,"IsVeg":true,"ModifierIDFs":"","Seasonal":"","Description":"Cheese Sandwich in 3 easy ways! Crisp, savory, buttery, toasted bread with a warm, gooey, melted cheesy filling are the essentials of a perfect grilled cheese sandwich.","NutritionalInfo":"","Ingredients":"","ApproxCookingHour":0,"ApproxCookingMinute":0,"IsProductOfDay":false,"isActive":true,"IsStockOut":false,"Price":"130.00-220.00","VariantData":[{"VariantIDP":"58b09abf-0821-41c0-9187-9150a58a7e8e","QuantitySpecification":"Grill","Price":220.00,"DiscountPercentage":0.00,"DiscountedPrice":220.00},{"VariantIDP":"ada1f2ad-fd08-42d2-aa4b-b8474e2c0ee1","QuantitySpecification":"Regular","Price":130.00,"DiscountPercentage":0.00,"DiscountedPrice":130.00}],"ItemImages":[{"ItemImagePath":"https://staging.artisanssolutions.com/admin/Content/Images/Menu/MENU_638513814304097750.jpg","ImageIDP":"F1CA6622-245D-4578-A036-9797FCCA2339"}]}]}

class MenuItemsResponse {
  MenuItemsResponse({
      bool? error, 
      int? statusCode, 
      String? statusMessage,
    MenuItemsData? data,}){
    _error = error;
    _statusCode = statusCode;
    _statusMessage = statusMessage;
    _data = data;
}

  MenuItemsResponse.fromJson(dynamic json) {
    _error = json['error'];
    _statusCode = json['statusCode'];
    _statusMessage = json['statusMessage'];
    _data = json['data'] != null ? MenuItemsData.fromJson(json['data']) : null;
  }
  bool? _error;
  int? _statusCode;
  String? _statusMessage;
  MenuItemsData? _data;

  bool? get error => _error;
  int? get statusCode => _statusCode;
  String? get statusMessage => _statusMessage;
  MenuItemsData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['statusCode'] = _statusCode;
    map['statusMessage'] = _statusMessage;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// TotalRecords : 43
/// FirstRecord : 1
/// LastRecord : 4
/// TotalPage : 11
/// Data : [{"SrNo":1,"MenuItemIDP":"2A963812-9391-48D3-BE2F-BC5D65E0145D","RestaurantIDF":"0D74BFA1-AF7D-4182-835B-B815C2972591","ItemName":"Veggie Delight Pizza","ItemTaxPercent":0.00,"IsVeg":true,"ModifierIDFs":"2453688d-2b3e-4f8c-b5f8-6b5c7ed9cece,25043742-7d93-4106-a565-5936366e0943,50fc4ee4-eafd-4b66-b13b-f066dab4d857,984e0e5f-4c56-4954-af15-046c4beee6b6,5fdd1b7e-b22b-4ade-9dc3-2594f3778904","Seasonal":"","Description":"<p>Bursting with assorted fresh vegetables for a healthy and flavorful option.</p>","NutritionalInfo":"","Ingredients":"","ApproxCookingHour":0,"ApproxCookingMinute":0,"IsProductOfDay":false,"isActive":true,"IsStockOut":true,"Price":"230.00","VariantData":[{"VariantIDP":"6b43aaaf-4fa8-48b2-b85f-0607d1401a1f","QuantitySpecification":"Regular (12 Inches)","Price":230.00,"DiscountPercentage":0.00,"DiscountedPrice":230.00}],"ItemImages":[{"ItemImagePath":"https://staging.artisanssolutions.com/admin/Content/Images/Menu/MENU_638513759788931489.jpg","ImageIDP":"7DD8FC34-9191-4212-93CF-2B1389558B31"},{"ItemImagePath":"https://staging.artisanssolutions.com/admin/Content/Images/Menu/MENU_638513759788931489.jpg","ImageIDP":"98A77BF0-1E43-4DF5-B8BA-C0DF8285E91C"}]},{"SrNo":2,"MenuItemIDP":"6F761B2B-83FE-46EC-8C8A-4CF44D8ACBED","RestaurantIDF":"0D74BFA1-AF7D-4182-835B-B815C2972591","ItemName":"Vegetable Sandwich","ItemTaxPercent":0.00,"IsVeg":true,"ModifierIDFs":"","Seasonal":"","Description":"A medley of fresh vegetables between slices of soft bread.","NutritionalInfo":"","Ingredients":"","ApproxCookingHour":0,"ApproxCookingMinute":0,"IsProductOfDay":false,"isActive":true,"IsStockOut":false,"Price":"100.00-180.00","VariantData":[{"VariantIDP":"53b2c81d-9b4d-4818-b345-7725cfd67e74","QuantitySpecification":"Regular","Price":100.00,"DiscountPercentage":0.00,"DiscountedPrice":100.00},{"VariantIDP":"21963805-8387-461d-9d8b-f435626390e7","QuantitySpecification":"Grill","Price":180.00,"DiscountPercentage":0.00,"DiscountedPrice":180.00}],"ItemImages":[{"ItemImagePath":"https://staging.artisanssolutions.com/admin/Content/Images/Menu/MENU_638513811041603731.jpg","ImageIDP":"6E573197-9D8A-4B9A-96F8-9CB2A5A26FAA"},{"ItemImagePath":"https://staging.artisanssolutions.com/admin/Content/Images/Menu/MENU_638513811041603731.jpg","ImageIDP":"EC61CA9F-5C4E-4D86-98E7-BD58A34150B9"}]},{"SrNo":3,"MenuItemIDP":"B0AB100A-0F83-4345-B977-A94139899544","RestaurantIDF":"0D74BFA1-AF7D-4182-835B-B815C2972591","ItemName":"Veg. Mexican Pizza","ItemTaxPercent":0.00,"IsVeg":true,"ModifierIDFs":"","Seasonal":"","Description":"A spicy and flavorful combination of Mexican-inspired toppings.","NutritionalInfo":"","Ingredients":"","ApproxCookingHour":0,"ApproxCookingMinute":0,"IsProductOfDay":false,"isActive":true,"IsStockOut":true,"Price":"290.00","VariantData":[{"VariantIDP":"c890d625-cf1a-4692-8054-402406a9e8ff","QuantitySpecification":"Regular (12 Inches)","Price":290.00,"DiscountPercentage":0.00,"DiscountedPrice":290.00}],"ItemImages":[{"ItemImagePath":"https://staging.artisanssolutions.com/admin/Content/Images/Menu/MENU_638513765933399492.jpg","ImageIDP":"E3D2D249-2F34-42DA-AE02-94A4C205AB28"}]},{"SrNo":4,"MenuItemIDP":"88A0FBCA-5B17-4164-A857-4FBB60224E16","RestaurantIDF":"0D74BFA1-AF7D-4182-835B-B815C2972591","ItemName":"Veg. Cheese Sandwich","ItemTaxPercent":0.00,"IsVeg":true,"ModifierIDFs":"","Seasonal":"","Description":"Cheese Sandwich in 3 easy ways! Crisp, savory, buttery, toasted bread with a warm, gooey, melted cheesy filling are the essentials of a perfect grilled cheese sandwich.","NutritionalInfo":"","Ingredients":"","ApproxCookingHour":0,"ApproxCookingMinute":0,"IsProductOfDay":false,"isActive":true,"IsStockOut":false,"Price":"130.00-220.00","VariantData":[{"VariantIDP":"58b09abf-0821-41c0-9187-9150a58a7e8e","QuantitySpecification":"Grill","Price":220.00,"DiscountPercentage":0.00,"DiscountedPrice":220.00},{"VariantIDP":"ada1f2ad-fd08-42d2-aa4b-b8474e2c0ee1","QuantitySpecification":"Regular","Price":130.00,"DiscountPercentage":0.00,"DiscountedPrice":130.00}],"ItemImages":[{"ItemImagePath":"https://staging.artisanssolutions.com/admin/Content/Images/Menu/MENU_638513814304097750.jpg","ImageIDP":"F1CA6622-245D-4578-A036-9797FCCA2339"}]}]

class MenuItemsData {
  MenuItemsData({
      int? totalRecords, 
      int? firstRecord, 
      int? lastRecord, 
      int? totalPage, 
      List<GetCategoryItemListData>? data,}){
    _totalRecords = totalRecords;
    _firstRecord = firstRecord;
    _lastRecord = lastRecord;
    _totalPage = totalPage;
    _data = data;
}

  MenuItemsData.fromJson(dynamic json) {
    _totalRecords = json['TotalRecords'];
    _firstRecord = json['FirstRecord'];
    _lastRecord = json['LastRecord'];
    _totalPage = json['TotalPage'];
    if (json['Data'] != null) {
      _data = [];
      json['Data'].forEach((v) {
        _data?.add(GetCategoryItemListData.fromJson(v));
      });
    }
  }
  int? _totalRecords;
  int? _firstRecord;
  int? _lastRecord;
  int? _totalPage;
  List<GetCategoryItemListData>? _data;

  int? get totalRecords => _totalRecords;
  int? get firstRecord => _firstRecord;
  int? get lastRecord => _lastRecord;
  int? get totalPage => _totalPage;
  List<GetCategoryItemListData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TotalRecords'] = _totalRecords;
    map['FirstRecord'] = _firstRecord;
    map['LastRecord'] = _lastRecord;
    map['TotalPage'] = _totalPage;
    if (_data != null) {
      map['Data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}
