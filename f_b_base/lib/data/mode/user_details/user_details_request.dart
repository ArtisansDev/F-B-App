/// id : "dca29073-0eda-435c-81f9-40bce2f34aa7"

class UserDetailsRequest {
  UserDetailsRequest({
      this.id,});

  UserDetailsRequest.fromJson(dynamic json) {
    id = json['id'];
  }
  String? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    return map;
  }

}