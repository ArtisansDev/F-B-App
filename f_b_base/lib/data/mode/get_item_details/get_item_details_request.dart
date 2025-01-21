/// id : "60782F37-FDB5-4434-A16A-7E9274792C97"

class GetItemDetailsRequest {
  GetItemDetailsRequest({
      this.id,
      this.branchIDF,
  });

  GetItemDetailsRequest.fromJson(dynamic json) {
    id = json['id'];
    branchIDF = json['BranchIDF'];
  }
  String? id;
  String? branchIDF;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['BranchIDF'] = branchIDF;
    return map;
  }

}