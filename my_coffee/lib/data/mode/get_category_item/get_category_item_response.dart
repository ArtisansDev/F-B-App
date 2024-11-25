/// error : false
/// statusCode : 200
/// statusMessage : "Data Retrieved Successfully"
/// data : {"TotalRecords":8,"FirstRecord":1,"LastRecord":4,"TotalPage":2,"Data":[{"SrNo":1,"MenuItemIDP":"DFFD1351-DD88-4CB9-BC4C-34E64D89C3FF","RestaurantIDF":"0D74BFA1-AF7D-4182-835B-B815C2972591","ItemName":"Tomato Pizza","ItemTaxPercent":0.00,"IsVeg":true,"ModifierIDFs":"","Seasonal":"","Description":"Fresh tomato slices on a bed of cheese and sauce for a simple yet delicious option.","NutritionalInfo":"","Ingredients":"","ApproxCookingHour":0,"ApproxCookingMinute":0,"IsProductOfDay":false,"isActive":true,"Price":"200.00","VariantData":[{"VariantIDP":"0a48cabd-d752-48ec-afbd-f5c470320dee","QuantitySpecification":"Regular (12 Inches)","Price":200.00,"DiscountPercentage":0.00,"DiscountedPrice":200.00}],"ItemImages":[{"ItemImagePath":"http://13.53.89.14:801/admin/Content/Images/Menu/MENU_638513763351673625.jpg","ImageIDP":"94091585-DD63-4770-89EC-8AD728DC4D40"},{"ItemImagePath":"http://13.53.89.14:801/admin/Content/Images/Menu/MENU_638513763351673625.jpg","ImageIDP":"C81F3D92-F590-4023-878C-B93430C2062C"}]},{"SrNo":2,"MenuItemIDP":"5EE6184B-2293-43D6-BEAC-831B05A388C4","RestaurantIDF":"0D74BFA1-AF7D-4182-835B-B815C2972591","ItemName":"Tandoori Garlic Bread","ItemTaxPercent":0.00,"IsVeg":true,"ModifierIDFs":"","Seasonal":"","Description":"Garlic bread infused with aromatic tandoori spices.","NutritionalInfo":"","Ingredients":"","ApproxCookingHour":0,"ApproxCookingMinute":0,"IsProductOfDay":false,"isActive":true,"Price":"160.00","VariantData":[{"VariantIDP":"78d5a4d3-b806-4ddd-96a0-748ac43759e5","QuantitySpecification":"Regular (4 Piece)","Price":160.00,"DiscountPercentage":0.00,"DiscountedPrice":160.00}],"ItemImages":[{"ItemImagePath":"http://13.53.89.14:801/admin/Content/Images/Menu/MENU_638513837130865830.jpg","ImageIDP":"091EA974-1E33-4200-B873-0739E73D373A"},{"ItemImagePath":"http://13.53.89.14:801/admin/Content/Images/Menu/MENU_638513837130865830.jpg","ImageIDP":"E85FF907-E462-4647-A210-3E8625DEEBD2"}]},{"SrNo":3,"MenuItemIDP":"ACBCADE5-7DD1-48B5-A398-AA6A2C22EB22","RestaurantIDF":"0D74BFA1-AF7D-4182-835B-B815C2972591","ItemName":"Plain Uttapam","ItemTaxPercent":0.00,"IsVeg":true,"ModifierIDFs":"","Seasonal":"","Description":"<ul><li>Thick, soft pancake made from rice batter, topped with vegetables or onions, served with sambhar and chutney.</li></ul>","NutritionalInfo":"<ul><li>250-300 kcal,&nbsp;</li><li>8g protein,&nbsp;</li><li>30g carbs,&nbsp;</li><li>10g fat</li></ul><p>&nbsp;</p>","Ingredients":"","ApproxCookingHour":0,"ApproxCookingMinute":15,"IsProductOfDay":false,"isActive":true,"Price":"100.00-120.00","VariantData":[{"VariantIDP":"816781c3-2f34-4483-b851-27b04c2a8ee4","QuantitySpecification":"Extra Ghee","Price":120.00,"DiscountPercentage":0.00,"DiscountedPrice":120.00},{"VariantIDP":"8016a8fe-9205-4ba3-ac84-2bcab0b1a28c","QuantitySpecification":"Regular Uttapam","Price":100.00,"DiscountPercentage":0.00,"DiscountedPrice":100.00}],"ItemImages":[{"ItemImagePath":"http://13.53.89.14:801/admin/Content/Images/Menu/MENU_638651070884124811.jpg","ImageIDP":"8CCA15CB-28CB-44B5-82BA-3F858FEAE6FC"}]},{"SrNo":4,"MenuItemIDP":"73C212D4-0D16-4C07-9BB9-03B8AE5ACEC8","RestaurantIDF":"0D74BFA1-AF7D-4182-835B-B815C2972591","ItemName":"Pizza","ItemTaxPercent":0.00,"IsVeg":false,"ModifierIDFs":"8ca3e358-e519-4191-a9eb-705290a38658","Seasonal":"Monsoon","Description":"<ul><li>gfgddtrttrtfdg</li><li>sdfdgfdgdfg</li></ul>","NutritionalInfo":"<ul><li>dtmsdfsdjgrt</li><li>dggreggfgfgfg</li><li>dgdfgfdhgfjhhfg dge &nbsp;e r g</li></ul>","Ingredients":"36DF0762-A048-4554-84D3-055EC8435FC0,35CFAB9F-EA40-469E-89D5-B6AEBFA00147","ApproxCookingHour":0,"ApproxCookingMinute":0,"IsProductOfDay":false,"isActive":true,"Price":"120.00","VariantData":[{"VariantIDP":"5507732b-30d0-413e-a403-e6f466eeb3eb","QuantitySpecification":"regular size","Price":120.00,"DiscountPercentage":0.00,"DiscountedPrice":120.00}],"ItemImages":[{"ItemImagePath":"http://13.53.89.14:801/admin/Content/Images/Menu/MENU_638643451114535821.jpeg","ImageIDP":"6066D4ED-1C37-44BC-A411-22D97B9A7B9B"}]}]}

class GetCategoryItemResponse {
  GetCategoryItemResponse({
      this.error, 
      this.statusCode, 
      this.statusMessage, 
      this.data,});

  GetCategoryItemResponse.fromJson(dynamic json) {
    error = json['error'];
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    data = json['data'] != null ? GetCategoryItemData.fromJson(json['data']) : null;
  }
  bool? error;
  int? statusCode;
  String? statusMessage;
  GetCategoryItemData? data;

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

/// TotalRecords : 8
/// FirstRecord : 1
/// LastRecord : 4
/// TotalPage : 2
/// Data : [{"SrNo":1,"MenuItemIDP":"DFFD1351-DD88-4CB9-BC4C-34E64D89C3FF","RestaurantIDF":"0D74BFA1-AF7D-4182-835B-B815C2972591","ItemName":"Tomato Pizza","ItemTaxPercent":0.00,"IsVeg":true,"ModifierIDFs":"","Seasonal":"","Description":"Fresh tomato slices on a bed of cheese and sauce for a simple yet delicious option.","NutritionalInfo":"","Ingredients":"","ApproxCookingHour":0,"ApproxCookingMinute":0,"IsProductOfDay":false,"isActive":true,"Price":"200.00","VariantData":[{"VariantIDP":"0a48cabd-d752-48ec-afbd-f5c470320dee","QuantitySpecification":"Regular (12 Inches)","Price":200.00,"DiscountPercentage":0.00,"DiscountedPrice":200.00}],"ItemImages":[{"ItemImagePath":"http://13.53.89.14:801/admin/Content/Images/Menu/MENU_638513763351673625.jpg","ImageIDP":"94091585-DD63-4770-89EC-8AD728DC4D40"},{"ItemImagePath":"http://13.53.89.14:801/admin/Content/Images/Menu/MENU_638513763351673625.jpg","ImageIDP":"C81F3D92-F590-4023-878C-B93430C2062C"}]},{"SrNo":2,"MenuItemIDP":"5EE6184B-2293-43D6-BEAC-831B05A388C4","RestaurantIDF":"0D74BFA1-AF7D-4182-835B-B815C2972591","ItemName":"Tandoori Garlic Bread","ItemTaxPercent":0.00,"IsVeg":true,"ModifierIDFs":"","Seasonal":"","Description":"Garlic bread infused with aromatic tandoori spices.","NutritionalInfo":"","Ingredients":"","ApproxCookingHour":0,"ApproxCookingMinute":0,"IsProductOfDay":false,"isActive":true,"Price":"160.00","VariantData":[{"VariantIDP":"78d5a4d3-b806-4ddd-96a0-748ac43759e5","QuantitySpecification":"Regular (4 Piece)","Price":160.00,"DiscountPercentage":0.00,"DiscountedPrice":160.00}],"ItemImages":[{"ItemImagePath":"http://13.53.89.14:801/admin/Content/Images/Menu/MENU_638513837130865830.jpg","ImageIDP":"091EA974-1E33-4200-B873-0739E73D373A"},{"ItemImagePath":"http://13.53.89.14:801/admin/Content/Images/Menu/MENU_638513837130865830.jpg","ImageIDP":"E85FF907-E462-4647-A210-3E8625DEEBD2"}]},{"SrNo":3,"MenuItemIDP":"ACBCADE5-7DD1-48B5-A398-AA6A2C22EB22","RestaurantIDF":"0D74BFA1-AF7D-4182-835B-B815C2972591","ItemName":"Plain Uttapam","ItemTaxPercent":0.00,"IsVeg":true,"ModifierIDFs":"","Seasonal":"","Description":"<ul><li>Thick, soft pancake made from rice batter, topped with vegetables or onions, served with sambhar and chutney.</li></ul>","NutritionalInfo":"<ul><li>250-300 kcal,&nbsp;</li><li>8g protein,&nbsp;</li><li>30g carbs,&nbsp;</li><li>10g fat</li></ul><p>&nbsp;</p>","Ingredients":"","ApproxCookingHour":0,"ApproxCookingMinute":15,"IsProductOfDay":false,"isActive":true,"Price":"100.00-120.00","VariantData":[{"VariantIDP":"816781c3-2f34-4483-b851-27b04c2a8ee4","QuantitySpecification":"Extra Ghee","Price":120.00,"DiscountPercentage":0.00,"DiscountedPrice":120.00},{"VariantIDP":"8016a8fe-9205-4ba3-ac84-2bcab0b1a28c","QuantitySpecification":"Regular Uttapam","Price":100.00,"DiscountPercentage":0.00,"DiscountedPrice":100.00}],"ItemImages":[{"ItemImagePath":"http://13.53.89.14:801/admin/Content/Images/Menu/MENU_638651070884124811.jpg","ImageIDP":"8CCA15CB-28CB-44B5-82BA-3F858FEAE6FC"}]},{"SrNo":4,"MenuItemIDP":"73C212D4-0D16-4C07-9BB9-03B8AE5ACEC8","RestaurantIDF":"0D74BFA1-AF7D-4182-835B-B815C2972591","ItemName":"Pizza","ItemTaxPercent":0.00,"IsVeg":false,"ModifierIDFs":"8ca3e358-e519-4191-a9eb-705290a38658","Seasonal":"Monsoon","Description":"<ul><li>gfgddtrttrtfdg</li><li>sdfdgfdgdfg</li></ul>","NutritionalInfo":"<ul><li>dtmsdfsdjgrt</li><li>dggreggfgfgfg</li><li>dgdfgfdhgfjhhfg dge &nbsp;e r g</li></ul>","Ingredients":"36DF0762-A048-4554-84D3-055EC8435FC0,35CFAB9F-EA40-469E-89D5-B6AEBFA00147","ApproxCookingHour":0,"ApproxCookingMinute":0,"IsProductOfDay":false,"isActive":true,"Price":"120.00","VariantData":[{"VariantIDP":"5507732b-30d0-413e-a403-e6f466eeb3eb","QuantitySpecification":"regular size","Price":120.00,"DiscountPercentage":0.00,"DiscountedPrice":120.00}],"ItemImages":[{"ItemImagePath":"http://13.53.89.14:801/admin/Content/Images/Menu/MENU_638643451114535821.jpeg","ImageIDP":"6066D4ED-1C37-44BC-A411-22D97B9A7B9B"}]}]

class GetCategoryItemData {
  GetCategoryItemData({
      this.totalRecords, 
      this.firstRecord, 
      this.lastRecord, 
      this.totalPage, 
      this.data,});

  GetCategoryItemData.fromJson(dynamic json) {
    totalRecords = json['TotalRecords'];
    firstRecord = json['FirstRecord'];
    lastRecord = json['LastRecord'];
    totalPage = json['TotalPage'];
    if (json['Data'] != null) {
      data = [];
      json['Data'].forEach((v) {
        data?.add(GetCategoryItemListData.fromJson(v));
      });
    }
  }
  int? totalRecords;
  int? firstRecord;
  int? lastRecord;
  int? totalPage;
  List<GetCategoryItemListData>? data;

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

/// SrNo : 1
/// MenuItemIDP : "DFFD1351-DD88-4CB9-BC4C-34E64D89C3FF"
/// RestaurantIDF : "0D74BFA1-AF7D-4182-835B-B815C2972591"
/// ItemName : "Tomato Pizza"
/// ItemTaxPercent : 0.00
/// IsVeg : true
/// ModifierIDFs : ""
/// Seasonal : ""
/// Description : "Fresh tomato slices on a bed of cheese and sauce for a simple yet delicious option."
/// NutritionalInfo : ""
/// Ingredients : ""
/// ApproxCookingHour : 0
/// ApproxCookingMinute : 0
/// IsProductOfDay : false
/// isActive : true
/// Price : "200.00"
/// VariantData : [{"VariantIDP":"0a48cabd-d752-48ec-afbd-f5c470320dee","QuantitySpecification":"Regular (12 Inches)","Price":200.00,"DiscountPercentage":0.00,"DiscountedPrice":200.00}]
/// ItemImages : [{"ItemImagePath":"http://13.53.89.14:801/admin/Content/Images/Menu/MENU_638513763351673625.jpg","ImageIDP":"94091585-DD63-4770-89EC-8AD728DC4D40"},{"ItemImagePath":"http://13.53.89.14:801/admin/Content/Images/Menu/MENU_638513763351673625.jpg","ImageIDP":"C81F3D92-F590-4023-878C-B93430C2062C"}]

class GetCategoryItemListData {
  GetCategoryItemListData({
      this.srNo, 
      this.menuItemIDP, 
      this.restaurantIDF, 
      this.itemName, 
      this.itemTaxPercent, 
      this.isVeg, 
      this.modifierIDFs, 
      this.seasonal, 
      this.description, 
      this.nutritionalInfo, 
      this.ingredients, 
      this.approxCookingHour, 
      this.approxCookingMinute, 
      this.isProductOfDay, 
      this.isActive, 
      this.price, 
      this.variantData, 
      this.itemImages,});

  GetCategoryItemListData.fromJson(dynamic json) {
    srNo = json['SrNo'];
    menuItemIDP = json['MenuItemIDP'];
    restaurantIDF = json['RestaurantIDF'];
    itemName = json['ItemName'];
    itemTaxPercent = json['ItemTaxPercent'];
    isVeg = json['IsVeg'];
    modifierIDFs = json['ModifierIDFs'];
    seasonal = json['Seasonal'];
    description = json['Description'];
    nutritionalInfo = json['NutritionalInfo'];
    ingredients = json['Ingredients'];
    approxCookingHour = json['ApproxCookingHour'];
    approxCookingMinute = json['ApproxCookingMinute'];
    isProductOfDay = json['IsProductOfDay'];
    isActive = json['isActive'];
    price = json['Price'];
    if (json['VariantData'] != null) {
      variantData = [];
      json['VariantData'].forEach((v) {
        variantData?.add(VariantData.fromJson(v));
      });
    }
    if (json['ItemImages'] != null) {
      itemImages = [];
      json['ItemImages'].forEach((v) {
        itemImages?.add(ItemImages.fromJson(v));
      });
    }
  }
  int? srNo;
  String? menuItemIDP;
  String? restaurantIDF;
  String? itemName;
  double? itemTaxPercent;
  bool? isVeg;
  String? modifierIDFs;
  String? seasonal;
  String? description;
  String? nutritionalInfo;
  String? ingredients;
  int? approxCookingHour;
  int? approxCookingMinute;
  bool? isProductOfDay;
  bool? isActive;
  String? price;
  List<VariantData>? variantData;
  List<ItemImages>? itemImages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['SrNo'] = srNo;
    map['MenuItemIDP'] = menuItemIDP;
    map['RestaurantIDF'] = restaurantIDF;
    map['ItemName'] = itemName;
    map['ItemTaxPercent'] = itemTaxPercent;
    map['IsVeg'] = isVeg;
    map['ModifierIDFs'] = modifierIDFs;
    map['Seasonal'] = seasonal;
    map['Description'] = description;
    map['NutritionalInfo'] = nutritionalInfo;
    map['Ingredients'] = ingredients;
    map['ApproxCookingHour'] = approxCookingHour;
    map['ApproxCookingMinute'] = approxCookingMinute;
    map['IsProductOfDay'] = isProductOfDay;
    map['isActive'] = isActive;
    map['Price'] = price;
    if (variantData != null) {
      map['VariantData'] = variantData?.map((v) => v.toJson()).toList();
    }
    if (itemImages != null) {
      map['ItemImages'] = itemImages?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// ItemImagePath : "http://13.53.89.14:801/admin/Content/Images/Menu/MENU_638513763351673625.jpg"
/// ImageIDP : "94091585-DD63-4770-89EC-8AD728DC4D40"

class ItemImages {
  ItemImages({
      this.itemImagePath, 
      this.imageIDP,});

  ItemImages.fromJson(dynamic json) {
    itemImagePath = json['ItemImagePath'];
    imageIDP = json['ImageIDP'];
  }
  String? itemImagePath;
  String? imageIDP;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ItemImagePath'] = itemImagePath;
    map['ImageIDP'] = imageIDP;
    return map;
  }

}

/// VariantIDP : "0a48cabd-d752-48ec-afbd-f5c470320dee"
/// QuantitySpecification : "Regular (12 Inches)"
/// Price : 200.00
/// DiscountPercentage : 0.00
/// DiscountedPrice : 200.00

class VariantData {
  VariantData({
      this.variantIDP, 
      this.quantitySpecification, 
      this.price, 
      this.discountPercentage, 
      this.discountedPrice,});

  VariantData.fromJson(dynamic json) {
    variantIDP = json['VariantIDP'];
    quantitySpecification = json['QuantitySpecification'];
    price = json['Price'];
    discountPercentage = json['DiscountPercentage'];
    discountedPrice = json['DiscountedPrice'];
  }
  String? variantIDP;
  String? quantitySpecification;
  double? price;
  double? discountPercentage;
  double? discountedPrice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['VariantIDP'] = variantIDP;
    map['QuantitySpecification'] = quantitySpecification;
    map['Price'] = price;
    map['DiscountPercentage'] = discountPercentage;
    map['DiscountedPrice'] = discountedPrice;
    return map;
  }

}