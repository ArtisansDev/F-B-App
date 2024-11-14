/*
 * Project      : my_coffee
 * File         : senang_pay_payment_model.dart
 * Description  : 
 * Author       : parthapaul
 * Date         : 2024-11-14
 * Version      : 1.0
 * Ticket       : 
 */

class SenangPayPaymentModel {
  SenangPayPaymentModel({
    this.merchantId,
    this.secretKey,
    this.amount,
    this.orderId,
    this.name,
    this.email,
    this.phone,});

  SenangPayPaymentModel.fromJson(dynamic json) {
    merchantId = json['merchantId'];
    secretKey = json['secretKey'];
    amount = json['amount'];
    orderId = json['orderId'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
  }
  String? merchantId;
  String? secretKey;
  String? amount;
  String? orderId;
  String? name;
  String? email;
  String? phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['merchantId'] = merchantId;
    map['secretKey'] = secretKey;
    map['amount'] = amount;
    map['orderId'] = orderId;
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    return map;
  }
}