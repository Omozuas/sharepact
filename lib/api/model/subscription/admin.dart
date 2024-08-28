class AdmineModel {
  String? id;
  String? username;
  String? avatarUrl;

  AdmineModel({
    this.id,
    this.username,
    this.avatarUrl,
  });

  factory AdmineModel.fromJson(Map<String, dynamic> json) => AdmineModel(
        id: json["_id"],
        username: json["username"],
        avatarUrl: json["avatarUrl"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "avatarUrl": avatarUrl,
      };
}
