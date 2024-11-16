import 'package:my_coffee/utils/num_utils.dart';

/// error : false
/// statusCode : 200
/// statusMessage : "Data Retrieved Successfully"
/// data : [{"MenuItemIDP":"60782f37-fdb5-4434-a16a-7e9274792c97","ItemName":"Mojito","Description":"A refreshing mix of white rum, lime juice, sugar, mint leaves, and soda water.","IsProductOfDay":true,"IsVeg":true,"IsActive":true,"RestaurantIDF":"8BCDEFB9-D6AC-4CEC-A060-C227E62425CB","NutritionalInfo":"kcal-34,fat-0g,saturates-0g,carbs-9g,sugars-9g,fibre-0g,protein-0g,low in salt-0.04g","ItemTax":0.0,"ModifierData":[{"ModifierName":"Extra Dry","ModifierIDP":"65649677-4004-44CF-B00F-5806A7D412CD","Price":20.00},{"ModifierName":"With a Twist","ModifierIDP":"F182FE73-D7FA-4520-91A0-6BDDAE437F7E","Price":30.00}],"VariantData":[{"QuantitySpecification":"Glass (100 ml)","Price":200.00,"DiscountPercentage":10.00,"DiscountedPrice":180.00,"VariantIDP":"1358D4D7-A3D0-4CAA-BC68-3ADB555C52BB"},{"QuantitySpecification":"Pitcher (500ml)","Price":500.00,"DiscountPercentage":10.00,"DiscountedPrice":450.00,"VariantIDP":"67029BC4-1E33-4F64-8A9B-D3B530D06F8F"}],"ItemImages":[{"ItemImagePath":"http://13.53.89.14:801/admin/Content/Images/Menu/MENU_638486035492535704.jpg","ImageIDP":"1C8954CB-D39D-4AEC-BC17-B5F734EB1698"},{"ItemImagePath":"http://13.53.89.14:801/admin/Content/Images/Menu/MENU_638486035492535704.jpg","ImageIDP":"EC412141-3EB9-4B45-AF5A-EBB48BC486C5"}],"CreatedBy":"A35CA135-4C38-42A2-8AEC-DA4D4746AAD9"}]

class GetItemDetailsResponse {
  GetItemDetailsResponse({
      this.error, 
      this.statusCode, 
      this.statusMessage, 
      this.data,});

  GetItemDetailsResponse.fromJson(dynamic json) {
    error = json['error'];
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(GetItemDetailsData.fromJson(v));
      });
    }
  }
  bool? error;
  int? statusCode;
  String? statusMessage;
  List<GetItemDetailsData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = error;
    map['statusCode'] = statusCode;
    map['statusMessage'] = statusMessage;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// MenuItemIDP : "60782f37-fdb5-4434-a16a-7e9274792c97"
/// ItemName : "Mojito"
/// Description : "A refreshing mix of white rum, lime juice, sugar, mint leaves, and soda water."
/// IsProductOfDay : true
/// IsVeg : true
/// IsActive : true
/// RestaurantIDF : "8BCDEFB9-D6AC-4CEC-A060-C227E62425CB"
/// NutritionalInfo : "kcal-34,fat-0g,saturates-0g,carbs-9g,sugars-9g,fibre-0g,protein-0g,low in salt-0.04g"
/// ItemTax : 0.0
/// ModifierData : [{"ModifierName":"Extra Dry","ModifierIDP":"65649677-4004-44CF-B00F-5806A7D412CD","Price":20.00},{"ModifierName":"With a Twist","ModifierIDP":"F182FE73-D7FA-4520-91A0-6BDDAE437F7E","Price":30.00}]
/// VariantData : [{"QuantitySpecification":"Glass (100 ml)","Price":200.00,"DiscountPercentage":10.00,"DiscountedPrice":180.00,"VariantIDP":"1358D4D7-A3D0-4CAA-BC68-3ADB555C52BB"},{"QuantitySpecification":"Pitcher (500ml)","Price":500.00,"DiscountPercentage":10.00,"DiscountedPrice":450.00,"VariantIDP":"67029BC4-1E33-4F64-8A9B-D3B530D06F8F"}]
/// ItemImages : [{"ItemImagePath":"http://13.53.89.14:801/admin/Content/Images/Menu/MENU_638486035492535704.jpg","ImageIDP":"1C8954CB-D39D-4AEC-BC17-B5F734EB1698"},{"ItemImagePath":"http://13.53.89.14:801/admin/Content/Images/Menu/MENU_638486035492535704.jpg","ImageIDP":"EC412141-3EB9-4B45-AF5A-EBB48BC486C5"}]
/// CreatedBy : "A35CA135-4C38-42A2-8AEC-DA4D4746AAD9"

class GetItemDetailsData {
  GetItemDetailsData({
      this.menuItemIDP, 
      this.itemName, 
      this.description, 
      this.isProductOfDay, 
      this.isVeg, 
      this.isActive, 
      this.restaurantIDF, 
      this.nutritionalInfo, 
      this.itemTax, 
      this.modifierData, 
      this.variantData, 
      this.itemImages, 
      this.createdBy,});

  GetItemDetailsData.fromJson(dynamic json) {
    menuItemIDP = json['MenuItemIDP'];
    itemName = json['ItemName'];
    description = json['Description'];
    isProductOfDay = json['IsProductOfDay'];
    isVeg = json['IsVeg'];
    isActive = json['IsActive'];
    restaurantIDF = json['RestaurantIDF'];
    nutritionalInfo = json['NutritionalInfo'];
    itemTax = getDoubleValue(json['ItemTax']??0);
    if (json['ModifierData'] != null) {
      modifierData = [];
      json['ModifierData'].forEach((v) {
        modifierData?.add(ModifierData.fromJson(v));
      });
    }
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
    createdBy = json['CreatedBy'];

    ///create
    total = json['total']??0.0;
    amount = json['amount']??0.0;
    amountModifier = json['amountModifier']??0.0;
    perItemTotal = json['perItemTotal']??0.0;
    perItemTax = json['perItemTax']??0.0;
    count = json['count']??0;
    if (json['selectModifierData'] != null) {
      selectModifierData = [];
      json['selectModifierData'].forEach((v) {
        selectModifierData?.add(ModifierData.fromJson(v));
      });
    }
    if (json['selectVariantData'] != null) {
      selectVariantData = [];
      json['selectVariantData'].forEach((v) {
        selectVariantData?.add(VariantData.fromJson(v));
      });
    }
  }
  String? menuItemIDP;
  String? itemName;
  String? description;
  bool? isProductOfDay;
  bool? isVeg;
  bool? isActive;
  String? restaurantIDF;
  String? nutritionalInfo;
  double? itemTax;
  List<ModifierData>? modifierData;
  List<VariantData>? variantData;
  List<ItemImages>? itemImages;
  String? createdBy;

  ///create
  double? total;
  double? perItemTotal;
  double? perItemTax;
  double? amountModifier;
  double? amount;
  int? count;
  List<ModifierData>? selectModifierData;
  List<VariantData>? selectVariantData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['MenuItemIDP'] = menuItemIDP;
    map['ItemName'] = itemName;
    map['Description'] = description;
    map['IsProductOfDay'] = isProductOfDay;
    map['IsVeg'] = isVeg;
    map['IsActive'] = isActive;
    map['RestaurantIDF'] = restaurantIDF;
    map['NutritionalInfo'] = nutritionalInfo;
    map['ItemTax'] = itemTax;
    if (modifierData != null) {
      map['ModifierData'] = modifierData?.map((v) => v.toJson()).toList();
    }
    if (variantData != null) {
      map['VariantData'] = variantData?.map((v) => v.toJson()).toList();
    }
    if (itemImages != null) {
      map['ItemImages'] = itemImages?.map((v) => v.toJson()).toList();
    }
    map['CreatedBy'] = createdBy;

    ///select
    map['total'] = total;
    map['perItemTotal'] = perItemTotal;
    map['perItemTax'] = perItemTax;
    map['amountModifier'] = amountModifier;
    map['amount'] = amount;
    map['count'] = count;
    if (selectModifierData != null) {
      map['selectModifierData'] = selectModifierData?.map((v) => v.toJson()).toList();
    }
    if (selectVariantData != null) {
      map['selectVariantData'] = selectVariantData?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// ItemImagePath : "http://13.53.89.14:801/admin/Content/Images/Menu/MENU_638486035492535704.jpg"
/// ImageIDP : "1C8954CB-D39D-4AEC-BC17-B5F734EB1698"

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

/// QuantitySpecification : "Glass (100 ml)"
/// Price : 200.00
/// DiscountPercentage : 10.00
/// DiscountedPrice : 180.00
/// VariantIDP : "1358D4D7-A3D0-4CAA-BC68-3ADB555C52BB"

class VariantData {
  VariantData({
      this.quantitySpecification, 
      this.price, 
      this.discountPercentage, 
      this.discountedPrice, 
      this.variantIDP,});

  VariantData.fromJson(dynamic json) {
    quantitySpecification = json['QuantitySpecification'];
    price = getDoubleValue(json['Price']??0);
    discountPercentage = getDoubleValue(json['DiscountPercentage']??0);
    discountedPrice = getDoubleValue(json['DiscountedPrice']??0);
    variantIDP = json['VariantIDP'];
  }
  String? quantitySpecification;
  double? price;
  double? discountPercentage;
  double? discountedPrice;
  String? variantIDP;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['QuantitySpecification'] = quantitySpecification;
    map['Price'] = price;
    map['DiscountPercentage'] = discountPercentage;
    map['DiscountedPrice'] = discountedPrice;
    map['VariantIDP'] = variantIDP;
    return map;
  }

}

/// ModifierName : "Extra Dry"
/// ModifierIDP : "65649677-4004-44CF-B00F-5806A7D412CD"
/// Price : 20.00

class ModifierData {
  ModifierData({
      this.modifierName, 
      this.modifierIDP, 
      this.price,});

  ModifierData.fromJson(dynamic json) {
    modifierName = json['ModifierName'];
    modifierIDP = json['ModifierIDP'];
    price = json['Price'];
  }
  String? modifierName;
  String? modifierIDP;
  double? price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ModifierName'] = modifierName;
    map['ModifierIDP'] = modifierIDP;
    map['Price'] = price;
    return map;
  }

}