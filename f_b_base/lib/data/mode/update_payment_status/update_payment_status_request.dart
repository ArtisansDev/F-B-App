/// RestaurantIDF : "0D74BFA1-AF7D-4182-835B-B815C2972591"
/// PaymentGatewayIDF : "4EDD3F4B-0115-4706-8244-452612462B83"
/// PaymentGatewaySettingIDF : "8441289B-DE99-4103-8014-71B2E1C9A7B4"
/// OrderID : "EF9BE0A8-AF62-48F1-B6C5-3B17D311EC95"
/// TransactionID : "TX1234567890"
/// ResponseCode : "200"
/// ResponseMessage : "Transaction Successful"
/// PaymentStatus : "S"
/// PaidAmount : 1500.75
/// PaymentGatewayNo : "1"
/// ResponseData : "{\"CardType\":\"VISA\",\"Currency\":\"INR\"}"
/// UserID : "935ADC24-7ACB-491F-9FE9-C90652414ADB"

class UpdatePaymentStatusRequest {
  UpdatePaymentStatusRequest({
      this.restaurantIDF, 
      this.paymentGatewayIDF, 
      this.paymentGatewaySettingIDF, 
      this.orderID, 
      this.transactionID, 
      this.responseCode, 
      this.responseMessage, 
      this.paymentStatus, 
      this.paidAmount, 
      this.paymentGatewayNo, 
      this.responseData, 
      this.userID,});

  UpdatePaymentStatusRequest.fromJson(dynamic json) {
    restaurantIDF = json['RestaurantIDF'];
    paymentGatewayIDF = json['PaymentGatewayIDF'];
    paymentGatewaySettingIDF = json['PaymentGatewaySettingIDF'];
    orderID = json['OrderID'];
    transactionID = json['TransactionID'];
    responseCode = json['ResponseCode'];
    responseMessage = json['ResponseMessage'];
    paymentStatus = json['PaymentStatus'];
    paidAmount = json['PaidAmount'];
    paymentGatewayNo = json['PaymentGatewayNo'];
    responseData = json['ResponseData'];
    userID = json['UserID'];
  }
  String? restaurantIDF;
  String? paymentGatewayIDF;
  String? paymentGatewaySettingIDF;
  String? orderID;
  String? transactionID;
  String? responseCode;
  String? responseMessage;
  String? paymentStatus;
  double? paidAmount;
  String? paymentGatewayNo;
  String? responseData;
  String? userID;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['RestaurantIDF'] = restaurantIDF;
    map['PaymentGatewayIDF'] = paymentGatewayIDF;
    map['PaymentGatewaySettingIDF'] = paymentGatewaySettingIDF;
    map['OrderID'] = orderID;
    map['TransactionID'] = transactionID;
    map['ResponseCode'] = responseCode;
    map['ResponseMessage'] = responseMessage;
    map['PaymentStatus'] = paymentStatus;
    map['PaidAmount'] = paidAmount;
    map['PaymentGatewayNo'] = paymentGatewayNo;
    map['ResponseData'] = responseData;
    map['UserID'] = userID;
    return map;
  }

}