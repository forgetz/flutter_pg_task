class UserModel {
  String userId;
  String username;
  String accessToken;

  UserModel({this.userId, this.username, this.accessToken});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['username'] = this.username;
    data['accessToken'] = this.accessToken;
    return data;
  }
}
