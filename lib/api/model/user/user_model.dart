import 'dart:convert';

import 'package:sharepact_app/api/model/error_model.dart';
import 'package:sharepact_app/api/model/user/notification_model.dart';

class UserResponseModel {
  final int code;
  final String? message;
  final UserModel? data;
  final Errors? errors;
  final bool? status;
  final String? resource;

  UserResponseModel({
    required this.code,
    this.message,
    this.data,
    this.errors,
    this.status,
    this.resource,
  });

  factory UserResponseModel.fromJson(Map<String, dynamic> json) {
    return UserResponseModel(
      code: json["code"],
      message: json["message"],
      data: json['data'] != null ? UserModel.fromJson(json['data']) : null,
      errors: json["errors"] != null ? Errors.fromJson(json["errors"]) : null,
      status: json["status"],
      resource: json["resource"],
    );
  }
  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data,
        "errors": errors?.toJson(),
        "status": status,
        "resource": resource,
      };
}

UserResponseModel userResponseModelFromJson(String str) =>
    UserResponseModel.fromJson(json.decode(str));

String userResponseModelToJson(UserResponseModel data) =>
    json.encode(data.toJson());

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
