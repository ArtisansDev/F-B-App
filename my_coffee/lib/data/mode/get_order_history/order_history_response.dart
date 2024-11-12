/// error : false
/// statusCode : 200
/// statusMessage : "Data Retrieved Successfully"
/// data : {"TotalRecords":5,"FirstRecord":1,"LastRecord":1,"TotalPage":5,"Data":[{"OrderIDP":"b9cdfb50-830b-4896-ae0f-beb031357a7d","PaymentMethod":0,"PaymentStatus":"P","BranchName":"Apple Cinema - Sarkhej, Ahmedabad","Address":"Shapath 3, Sarkhej Gandhinagar Highway Bodakdev Ahmedabad - 380054","PinCode":"380054","StateName":"Perak","CityName":"Gopeng","Country":"Malaysia","CurrencySymbol":"RM","CurrencyCode":"MYR","TrackingOrderID":"f764341dee012b8e7a12c1ecc5095014f20170a9","UserIDF":"935adc24-7acb-491f-9fe9-c90652414adb","OrderType":0,"OrderSource":0,"RestaurantIDF":"0d74bfa1-af7d-4182-835b-b815c2972591","BranchIDF":"8281f828-2f99-457e-ac27-06914abbe720","SeatIDF":"00000000-0000-0000-0000-000000000000","OrderDate":"2024-11-12T10:25:48.199668Z","OrderMenu":[{"MenuItemIDF":"ffecfb39-c793-423f-9de6-44dd5857a62a","VariantIDF":"18f5ddf4-f6a2-43f5-8176-71c033baa577","Quantity":1,"DiscountPercentage":0.00,"ItemName":"Garlic Bread","ItemVariantName":"Regular","ItemTaxPercent":0.00,"AllModifierPrices":"","AllModifierIDFs":"","VariantPrice":120.00,"ItemDiscountPrice":120.00,"DiscountedItemAmount":0.00,"DiscountedItemTotalAmount":0.00,"ItemTaxPrice":0.00,"ItemTotal":120.00,"ItemTotalTaxPrice":0.00,"ItemModifierTotal":0.00,"ItemDiscountPriceTotal":120.00,"TotalItemAmount":120.00},{"MenuItemIDF":"5ee6184b-2293-43d6-beac-831b05a388c4","VariantIDF":"78d5a4d3-b806-4ddd-96a0-748ac43759e5","Quantity":1,"DiscountPercentage":10.00,"ItemName":"Tandoori Garlic Bread","ItemVariantName":"Regular (4 Piece)","ItemTaxPercent":5.00,"AllModifierPrices":"","AllModifierIDFs":"","VariantPrice":160.00,"ItemDiscountPrice":144.00,"DiscountedItemAmount":16.00,"DiscountedItemTotalAmount":16.00,"ItemTaxPrice":7.20,"ItemTotal":160.00,"ItemTotalTaxPrice":7.20,"ItemModifierTotal":0.00,"ItemDiscountPriceTotal":144.00,"TotalItemAmount":151.20},{"MenuItemIDF":"5ee6184b-2293-43d6-beac-831b05a388c4","VariantIDF":"78d5a4d3-b806-4ddd-96a0-748ac43759e5","Quantity":2,"DiscountPercentage":10.00,"ItemName":"Tandoori Garlic Bread","ItemVariantName":"Regular (4 Piece)","ItemTaxPercent":5.00,"AllModifierPrices":"20.0","AllModifierIDFs":"D856163D-BDB7-4BB9-8F7C-1E1655CF3F95","VariantPrice":160.00,"ItemDiscountPrice":144.00,"DiscountedItemAmount":16.00,"DiscountedItemTotalAmount":32.00,"ItemTaxPrice":7.20,"ItemTotal":320.00,"ItemTotalTaxPrice":14.40,"ItemModifierTotal":40.00,"ItemDiscountPriceTotal":288.00,"TotalItemAmount":342.40}],"OrderTax":[{"TaxIDF":"7aad68ca-7edb-4e36-a893-a191f6702ac2","TaxName":"SST","TaxPercentage":5.00,"TaxAmount":30.68},{"TaxIDF":"d327b6d4-85a9-4feb-b7a9-e23dd802e8e7","TaxName":"Service Tax","TaxPercentage":10.00,"TaxAmount":61.36}],"QuantityTotal":4,"ItemTotal":600.00,"ModifierTotal":40.00,"DiscountTotal":48.00,"ItemTaxTotal":21.60,"SubTotal":613.60,"TaxAmountTotal":92.04,"TotalAmount":705.64,"AdditionalNotes":""}]}

class OrderHistoryResponse {
  OrderHistoryResponse({
    this.error,
    this.statusCode,
    this.statusMessage,
    this.data,});

  OrderHistoryResponse.fromJson(dynamic json) {
    error = json['error'];
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    data = json['data'] != null ? OrderHistoryResponseData.fromJson(json['data']) : null;
  }
  bool? error;
  int? statusCode;
  String? statusMessage;
  OrderHistoryResponseData? data;

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

/// TotalRecords : 5
/// FirstRecord : 1
/// LastRecord : 1
/// TotalPage : 5
/// Data : [{"OrderIDP":"b9cdfb50-830b-4896-ae0f-beb031357a7d","PaymentMethod":0,"PaymentStatus":"P","BranchName":"Apple Cinema - Sarkhej, Ahmedabad","Address":"Shapath 3, Sarkhej Gandhinagar Highway Bodakdev Ahmedabad - 380054","PinCode":"380054","StateName":"Perak","CityName":"Gopeng","Country":"Malaysia","CurrencySymbol":"RM","CurrencyCode":"MYR","TrackingOrderID":"f764341dee012b8e7a12c1ecc5095014f20170a9","UserIDF":"935adc24-7acb-491f-9fe9-c90652414adb","OrderType":0,"OrderSource":0,"RestaurantIDF":"0d74bfa1-af7d-4182-835b-b815c2972591","BranchIDF":"8281f828-2f99-457e-ac27-06914abbe720","SeatIDF":"00000000-0000-0000-0000-000000000000","OrderDate":"2024-11-12T10:25:48.199668Z","OrderMenu":[{"MenuItemIDF":"ffecfb39-c793-423f-9de6-44dd5857a62a","VariantIDF":"18f5ddf4-f6a2-43f5-8176-71c033baa577","Quantity":1,"DiscountPercentage":0.00,"ItemName":"Garlic Bread","ItemVariantName":"Regular","ItemTaxPercent":0.00,"AllModifierPrices":"","AllModifierIDFs":"","VariantPrice":120.00,"ItemDiscountPrice":120.00,"DiscountedItemAmount":0.00,"DiscountedItemTotalAmount":0.00,"ItemTaxPrice":0.00,"ItemTotal":120.00,"ItemTotalTaxPrice":0.00,"ItemModifierTotal":0.00,"ItemDiscountPriceTotal":120.00,"TotalItemAmount":120.00},{"MenuItemIDF":"5ee6184b-2293-43d6-beac-831b05a388c4","VariantIDF":"78d5a4d3-b806-4ddd-96a0-748ac43759e5","Quantity":1,"DiscountPercentage":10.00,"ItemName":"Tandoori Garlic Bread","ItemVariantName":"Regular (4 Piece)","ItemTaxPercent":5.00,"AllModifierPrices":"","AllModifierIDFs":"","VariantPrice":160.00,"ItemDiscountPrice":144.00,"DiscountedItemAmount":16.00,"DiscountedItemTotalAmount":16.00,"ItemTaxPrice":7.20,"ItemTotal":160.00,"ItemTotalTaxPrice":7.20,"ItemModifierTotal":0.00,"ItemDiscountPriceTotal":144.00,"TotalItemAmount":151.20},{"MenuItemIDF":"5ee6184b-2293-43d6-beac-831b05a388c4","VariantIDF":"78d5a4d3-b806-4ddd-96a0-748ac43759e5","Quantity":2,"DiscountPercentage":10.00,"ItemName":"Tandoori Garlic Bread","ItemVariantName":"Regular (4 Piece)","ItemTaxPercent":5.00,"AllModifierPrices":"20.0","AllModifierIDFs":"D856163D-BDB7-4BB9-8F7C-1E1655CF3F95","VariantPrice":160.00,"ItemDiscountPrice":144.00,"DiscountedItemAmount":16.00,"DiscountedItemTotalAmount":32.00,"ItemTaxPrice":7.20,"ItemTotal":320.00,"ItemTotalTaxPrice":14.40,"ItemModifierTotal":40.00,"ItemDiscountPriceTotal":288.00,"TotalItemAmount":342.40}],"OrderTax":[{"TaxIDF":"7aad68ca-7edb-4e36-a893-a191f6702ac2","TaxName":"SST","TaxPercentage":5.00,"TaxAmount":30.68},{"TaxIDF":"d327b6d4-85a9-4feb-b7a9-e23dd802e8e7","TaxName":"Service Tax","TaxPercentage":10.00,"TaxAmount":61.36}],"QuantityTotal":4,"ItemTotal":600.00,"ModifierTotal":40.00,"DiscountTotal":48.00,"ItemTaxTotal":21.60,"SubTotal":613.60,"TaxAmountTotal":92.04,"TotalAmount":705.64,"AdditionalNotes":""}]

class OrderHistoryResponseData {
  OrderHistoryResponseData({
    this.totalRecords,
    this.firstRecord,
    this.lastRecord,
    this.totalPage,
    this.data,});

  OrderHistoryResponseData.fromJson(dynamic json) {
    totalRecords = json['TotalRecords'];
    firstRecord = json['FirstRecord'];
    lastRecord = json['LastRecord'];
    totalPage = json['TotalPage'];
    if (json['Data'] != null) {
      data = [];
      json['Data'].forEach((v) {
        data?.add(OrderHistoryResponseItemData.fromJson(v));
      });
    }
  }
  int? totalRecords;
  int? firstRecord;
  int? lastRecord;
  int? totalPage;
  List<OrderHistoryResponseItemData>? data;

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

/// OrderIDP : "b9cdfb50-830b-4896-ae0f-beb031357a7d"
/// PaymentMethod : 0
/// PaymentStatus : "P"
/// BranchName : "Apple Cinema - Sarkhej, Ahmedabad"
/// Address : "Shapath 3, Sarkhej Gandhinagar Highway Bodakdev Ahmedabad - 380054"
/// PinCode : "380054"
/// StateName : "Perak"
/// CityName : "Gopeng"
/// Country : "Malaysia"
/// CurrencySymbol : "RM"
/// CurrencyCode : "MYR"
/// TrackingOrderID : "f764341dee012b8e7a12c1ecc5095014f20170a9"
/// UserIDF : "935adc24-7acb-491f-9fe9-c90652414adb"
/// OrderType : 0
/// OrderSource : 0
/// RestaurantIDF : "0d74bfa1-af7d-4182-835b-b815c2972591"
/// BranchIDF : "8281f828-2f99-457e-ac27-06914abbe720"
/// SeatIDF : "00000000-0000-0000-0000-000000000000"
/// OrderDate : "2024-11-12T10:25:48.199668Z"
/// OrderMenu : [{"MenuItemIDF":"ffecfb39-c793-423f-9de6-44dd5857a62a","VariantIDF":"18f5ddf4-f6a2-43f5-8176-71c033baa577","Quantity":1,"DiscountPercentage":0.00,"ItemName":"Garlic Bread","ItemVariantName":"Regular","ItemTaxPercent":0.00,"AllModifierPrices":"","AllModifierIDFs":"","VariantPrice":120.00,"ItemDiscountPrice":120.00,"DiscountedItemAmount":0.00,"DiscountedItemTotalAmount":0.00,"ItemTaxPrice":0.00,"ItemTotal":120.00,"ItemTotalTaxPrice":0.00,"ItemModifierTotal":0.00,"ItemDiscountPriceTotal":120.00,"TotalItemAmount":120.00},{"MenuItemIDF":"5ee6184b-2293-43d6-beac-831b05a388c4","VariantIDF":"78d5a4d3-b806-4ddd-96a0-748ac43759e5","Quantity":1,"DiscountPercentage":10.00,"ItemName":"Tandoori Garlic Bread","ItemVariantName":"Regular (4 Piece)","ItemTaxPercent":5.00,"AllModifierPrices":"","AllModifierIDFs":"","VariantPrice":160.00,"ItemDiscountPrice":144.00,"DiscountedItemAmount":16.00,"DiscountedItemTotalAmount":16.00,"ItemTaxPrice":7.20,"ItemTotal":160.00,"ItemTotalTaxPrice":7.20,"ItemModifierTotal":0.00,"ItemDiscountPriceTotal":144.00,"TotalItemAmount":151.20},{"MenuItemIDF":"5ee6184b-2293-43d6-beac-831b05a388c4","VariantIDF":"78d5a4d3-b806-4ddd-96a0-748ac43759e5","Quantity":2,"DiscountPercentage":10.00,"ItemName":"Tandoori Garlic Bread","ItemVariantName":"Regular (4 Piece)","ItemTaxPercent":5.00,"AllModifierPrices":"20.0","AllModifierIDFs":"D856163D-BDB7-4BB9-8F7C-1E1655CF3F95","VariantPrice":160.00,"ItemDiscountPrice":144.00,"DiscountedItemAmount":16.00,"DiscountedItemTotalAmount":32.00,"ItemTaxPrice":7.20,"ItemTotal":320.00,"ItemTotalTaxPrice":14.40,"ItemModifierTotal":40.00,"ItemDiscountPriceTotal":288.00,"TotalItemAmount":342.40}]
/// OrderTax : [{"TaxIDF":"7aad68ca-7edb-4e36-a893-a191f6702ac2","TaxName":"SST","TaxPercentage":5.00,"TaxAmount":30.68},{"TaxIDF":"d327b6d4-85a9-4feb-b7a9-e23dd802e8e7","TaxName":"Service Tax","TaxPercentage":10.00,"TaxAmount":61.36}]
/// QuantityTotal : 4
/// ItemTotal : 600.00
/// ModifierTotal : 40.00
/// DiscountTotal : 48.00
/// ItemTaxTotal : 21.60
/// SubTotal : 613.60
/// TaxAmountTotal : 92.04
/// TotalAmount : 705.64
/// AdditionalNotes : ""

class OrderHistoryResponseItemData {
  OrderHistoryResponseItemData({
    this.orderIDP,
    this.paymentMethod,
    this.paymentStatus,
    this.branchName,
    this.address,
    this.pinCode,
    this.stateName,
    this.cityName,
    this.country,
    this.currencySymbol,
    this.currencyCode,
    this.trackingOrderID,
    this.userIDF,
    this.orderType,
    this.orderSource,
    this.restaurantIDF,
    this.branchIDF,
    this.seatIDF,
    this.orderDate,
    this.orderMenu,
    this.orderTax,
    this.quantityTotal,
    this.itemTotal,
    this.modifierTotal,
    this.discountTotal,
    this.itemTaxTotal,
    this.subTotal,
    this.taxAmountTotal,
    this.totalAmount,
    this.additionalNotes,});

  OrderHistoryResponseItemData.fromJson(dynamic json) {
    orderIDP = json['OrderIDP'];
    paymentMethod = json['PaymentMethod'];
    paymentStatus = json['PaymentStatus'];
    branchName = json['BranchName'];
    address = json['Address'];
    pinCode = json['PinCode'];
    stateName = json['StateName'];
    cityName = json['CityName'];
    country = json['Country'];
    currencySymbol = json['CurrencySymbol'];
    currencyCode = json['CurrencyCode'];
    trackingOrderID = json['TrackingOrderID'];
    userIDF = json['UserIDF'];
    orderType = json['OrderType'];
    orderSource = json['OrderSource'];
    restaurantIDF = json['RestaurantIDF'];
    branchIDF = json['BranchIDF'];
    seatIDF = json['SeatIDF'];
    orderDate = json['OrderDate'];
    if (json['OrderMenu'] != null) {
      orderMenu = [];
      json['OrderMenu'].forEach((v) {
        orderMenu?.add(OrderMenu.fromJson(v));
      });
    }
    if (json['OrderTax'] != null) {
      orderTax = [];
      json['OrderTax'].forEach((v) {
        orderTax?.add(OrderTax.fromJson(v));
      });
    }
    quantityTotal = json['QuantityTotal'];
    itemTotal = json['ItemTotal'];
    modifierTotal = json['ModifierTotal'];
    discountTotal = json['DiscountTotal'];
    itemTaxTotal = json['ItemTaxTotal'];
    subTotal = json['SubTotal'];
    taxAmountTotal = json['TaxAmountTotal'];
    totalAmount = json['TotalAmount'];
    additionalNotes = json['AdditionalNotes'];
  }
  String? orderIDP;
  int? paymentMethod;
  String? paymentStatus;
  String? branchName;
  String? address;
  String? pinCode;
  String? stateName;
  String? cityName;
  String? country;
  String? currencySymbol;
  String? currencyCode;
  String? trackingOrderID;
  String? userIDF;
  int? orderType;
  int? orderSource;
  String? restaurantIDF;
  String? branchIDF;
  String? seatIDF;
  String? orderDate;
  List<OrderMenu>? orderMenu;
  List<OrderTax>? orderTax;
  int? quantityTotal;
  double? itemTotal;
  double? modifierTotal;
  double? discountTotal;
  double? itemTaxTotal;
  double? subTotal;
  double? taxAmountTotal;
  double? totalAmount;
  String? additionalNotes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrderIDP'] = orderIDP;
    map['PaymentMethod'] = paymentMethod;
    map['PaymentStatus'] = paymentStatus;
    map['BranchName'] = branchName;
    map['Address'] = address;
    map['PinCode'] = pinCode;
    map['StateName'] = stateName;
    map['CityName'] = cityName;
    map['Country'] = country;
    map['CurrencySymbol'] = currencySymbol;
    map['CurrencyCode'] = currencyCode;
    map['TrackingOrderID'] = trackingOrderID;
    map['UserIDF'] = userIDF;
    map['OrderType'] = orderType;
    map['OrderSource'] = orderSource;
    map['RestaurantIDF'] = restaurantIDF;
    map['BranchIDF'] = branchIDF;
    map['SeatIDF'] = seatIDF;
    map['OrderDate'] = orderDate;
    if (orderMenu != null) {
      map['OrderMenu'] = orderMenu?.map((v) => v.toJson()).toList();
    }
    if (orderTax != null) {
      map['OrderTax'] = orderTax?.map((v) => v.toJson()).toList();
    }
    map['QuantityTotal'] = quantityTotal;
    map['ItemTotal'] = itemTotal;
    map['ModifierTotal'] = modifierTotal;
    map['DiscountTotal'] = discountTotal;
    map['ItemTaxTotal'] = itemTaxTotal;
    map['SubTotal'] = subTotal;
    map['TaxAmountTotal'] = taxAmountTotal;
    map['TotalAmount'] = totalAmount;
    map['AdditionalNotes'] = additionalNotes;
    return map;
  }

}

/// TaxIDF : "7aad68ca-7edb-4e36-a893-a191f6702ac2"
/// TaxName : "SST"
/// TaxPercentage : 5.00
/// TaxAmount : 30.68

class OrderTax {
  OrderTax({
    this.taxIDF,
    this.taxName,
    this.taxPercentage,
    this.taxAmount,});

  OrderTax.fromJson(dynamic json) {
    taxIDF = json['TaxIDF'];
    taxName = json['TaxName'];
    taxPercentage = json['TaxPercentage'];
    taxAmount = json['TaxAmount'];
  }
  String? taxIDF;
  String? taxName;
  double? taxPercentage;
  double? taxAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TaxIDF'] = taxIDF;
    map['TaxName'] = taxName;
    map['TaxPercentage'] = taxPercentage;
    map['TaxAmount'] = taxAmount;
    return map;
  }

}

/// MenuItemIDF : "ffecfb39-c793-423f-9de6-44dd5857a62a"
/// VariantIDF : "18f5ddf4-f6a2-43f5-8176-71c033baa577"
/// Quantity : 1
/// DiscountPercentage : 0.00
/// ItemName : "Garlic Bread"
/// ItemVariantName : "Regular"
/// ItemTaxPercent : 0.00
/// AllModifierPrices : ""
/// AllModifierIDFs : ""
/// VariantPrice : 120.00
/// ItemDiscountPrice : 120.00
/// DiscountedItemAmount : 0.00
/// DiscountedItemTotalAmount : 0.00
/// ItemTaxPrice : 0.00
/// ItemTotal : 120.00
/// ItemTotalTaxPrice : 0.00
/// ItemModifierTotal : 0.00
/// ItemDiscountPriceTotal : 120.00
/// TotalItemAmount : 120.00

class OrderMenu {
  OrderMenu({
    this.menuItemIDF,
    this.variantIDF,
    this.quantity,
    this.discountPercentage,
    this.itemName,
    this.itemVariantName,
    this.itemTaxPercent,
    this.allModifierPrices,
    this.allModifierIDFs,
    this.variantPrice,
    this.itemDiscountPrice,
    this.discountedItemAmount,
    this.discountedItemTotalAmount,
    this.itemTaxPrice,
    this.itemTotal,
    this.itemTotalTaxPrice,
    this.itemModifierTotal,
    this.itemDiscountPriceTotal,
    this.totalItemAmount,});

  OrderMenu.fromJson(dynamic json) {
    menuItemIDF = json['MenuItemIDF'];
    variantIDF = json['VariantIDF'];
    quantity = json['Quantity'];
    discountPercentage = json['DiscountPercentage'];
    itemName = json['ItemName'];
    itemVariantName = json['ItemVariantName'];
    itemTaxPercent = json['ItemTaxPercent'];
    allModifierPrices = json['AllModifierPrices'];
    allModifierIDFs = json['AllModifierIDFs'];
    variantPrice = json['VariantPrice'];
    itemDiscountPrice = json['ItemDiscountPrice'];
    discountedItemAmount = json['DiscountedItemAmount'];
    discountedItemTotalAmount = json['DiscountedItemTotalAmount'];
    itemTaxPrice = json['ItemTaxPrice'];
    itemTotal = json['ItemTotal'];
    itemTotalTaxPrice = json['ItemTotalTaxPrice'];
    itemModifierTotal = json['ItemModifierTotal'];
    itemDiscountPriceTotal = json['ItemDiscountPriceTotal'];
    totalItemAmount = json['TotalItemAmount'];
  }
  String? menuItemIDF;
  String? variantIDF;
  int? quantity;
  double? discountPercentage;
  String? itemName;
  String? itemVariantName;
  double? itemTaxPercent;
  String? allModifierPrices;
  String? allModifierIDFs;
  double? variantPrice;
  double? itemDiscountPrice;
  double? discountedItemAmount;
  double? discountedItemTotalAmount;
  double? itemTaxPrice;
  double? itemTotal;
  double? itemTotalTaxPrice;
  double? itemModifierTotal;
  double? itemDiscountPriceTotal;
  double? totalItemAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['MenuItemIDF'] = menuItemIDF;
    map['VariantIDF'] = variantIDF;
    map['Quantity'] = quantity;
    map['DiscountPercentage'] = discountPercentage;
    map['ItemName'] = itemName;
    map['ItemVariantName'] = itemVariantName;
    map['ItemTaxPercent'] = itemTaxPercent;
    map['AllModifierPrices'] = allModifierPrices;
    map['AllModifierIDFs'] = allModifierIDFs;
    map['VariantPrice'] = variantPrice;
    map['ItemDiscountPrice'] = itemDiscountPrice;
    map['DiscountedItemAmount'] = discountedItemAmount;
    map['DiscountedItemTotalAmount'] = discountedItemTotalAmount;
    map['ItemTaxPrice'] = itemTaxPrice;
    map['ItemTotal'] = itemTotal;
    map['ItemTotalTaxPrice'] = itemTotalTaxPrice;
    map['ItemModifierTotal'] = itemModifierTotal;
    map['ItemDiscountPriceTotal'] = itemDiscountPriceTotal;
    map['TotalItemAmount'] = totalItemAmount;
    return map;
  }

}