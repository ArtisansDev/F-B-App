/// id : "dca29073-0eda-435c-81f9-40bce2f34aa7"

class UserDeleteRequest {
  UserDeleteRequest({
      this.id,});

  UserDeleteRequest.fromJson(dynamic json) {
    id = json['Id'];
  }
  String? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = id;
    return map;
  }

}