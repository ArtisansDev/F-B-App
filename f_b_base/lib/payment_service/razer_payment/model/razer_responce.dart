/// amount : "5.30"
/// app_code : 487919
/// txn_ID : 4953234
/// pInstruction : "0"
/// msgType : "C6"
/// status_code : "00"
/// order_id : "43ade0f2-da28-4467-a669-58b7800149de"
/// channel : "CIMB-Clicks"
/// chksum : "e2401ca389bce9eb6bf50024ff47e509"
/// mp_secured_verified : true

class RazerResponse {
  RazerResponse({
      this.amount, 
      this.appCode, 
      this.txnID, 
      this.pInstruction, 
      this.msgType, 
      this.statusCode, 
      this.orderId, 
      this.channel, 
      this.chksum, 
      this.mpSecuredVerified,});

  RazerResponse.fromJson(dynamic json) {
    amount = json['amount'].toString();
    appCode = json['app_code'];
    txnID = json['txn_ID'];
    pInstruction = json['pInstruction'];
    msgType = json['msgType'];
    statusCode = json['status_code'];
    orderId = json['order_id'];
    channel = json['channel'];
    chksum = json['chksum'];
    mpSecuredVerified = json['mp_secured_verified'];
  }
  String? amount;
  int? appCode;
  int? txnID;
  String? pInstruction;
  String? msgType;
  String? statusCode;
  String? orderId;
  String? channel;
  String? chksum;
  bool? mpSecuredVerified;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['amount'] = amount;
    map['app_code'] = appCode;
    map['txn_ID'] = txnID;
    map['pInstruction'] = pInstruction;
    map['msgType'] = msgType;
    map['status_code'] = statusCode;
    map['order_id'] = orderId;
    map['channel'] = channel;
    map['chksum'] = chksum;
    map['mp_secured_verified'] = mpSecuredVerified;
    return map;
  }

}