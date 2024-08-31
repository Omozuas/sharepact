// ignore_for_file: public_member_api_docs, sort_constructors_first
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

  AdmineModel copyWith({
    String? id,
    String? username,
    String? avatarUrl,
  }) {
    return AdmineModel(
      id: id ?? this.id,
      username: username ?? this.username,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  @override
  String toString() =>
      'AdmineModel(id: $id, username: $username, avatarUrl: $avatarUrl)';

  @override
  bool operator ==(covariant AdmineModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.username == username &&
        other.avatarUrl == avatarUrl;
  }

  @override
  int get hashCode => id.hashCode ^ username.hashCode ^ avatarUrl.hashCode;
}
