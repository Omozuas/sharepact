import 'package:sharepact_app/api/model/user/notification_model.dart';

class UserModel {
  String? email;
  String? username;
  String? avatarUrl;
  bool? verified;
  String? role;
  NotificationConfig? notificationConfig;
  bool? deleted;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  UserModel({
    this.email,
    this.username,
    this.avatarUrl,
    this.verified,
    this.role,
    this.notificationConfig,
    this.deleted,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json["email"],
        username: json["username"],
        avatarUrl: json["avatarUrl"],
        verified: json["verified"],
        role: json["role"],
        notificationConfig:
            NotificationConfig.fromJson(json["notificationConfig"]),
        deleted: json["deleted"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "username": username,
        "avatarUrl": avatarUrl,
        "verified": verified,
        "role": role,
        "notificationConfig": notificationConfig!.toJson(),
        "deleted": deleted,
        "_id": id,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
      };
}
