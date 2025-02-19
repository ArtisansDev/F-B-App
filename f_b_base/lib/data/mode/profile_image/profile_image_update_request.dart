class ProfileImageUpdateRequest {
  ProfileImageUpdateRequest({this.userID});

  ProfileImageUpdateRequest.fromJson(dynamic json) {
    userID = json['UserID'];
  }

  String? userID;

  Map<String, String> toJson() {
    final map = <String, String>{};
    map['UserID'] = userID ?? '';
    return map;
  }
}
