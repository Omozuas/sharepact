// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'package:sharepact_app/api/model/error_model.dart';

class AvaterResponseModel {
  final int code;
  final String? message;
  final AvaterUrlModel? data;
  final Errors? errors;
  final bool? status;
  final String? resource;

  AvaterResponseModel({
    required this.code,
    this.message,
    this.data,
    this.errors,
    this.status,
    this.resource,
  });

  factory AvaterResponseModel.fromJson(Map<String, dynamic> json) {
    return AvaterResponseModel(
      code: json["code"],
      message: json["message"],
      data: json["data"] != null ? AvaterUrlModel.fromJson(json["data"]) : null,
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

AvaterResponseModel avaterResponseModelFromJson(String str) =>
    AvaterResponseModel.fromJson(json.decode(str));

String avaterResponseModelToJson(AvaterResponseModel data) =>
    json.encode(data.toJson());

class AvaterUrlModel {
  List<String>? avatars;

  AvaterUrlModel({
    this.avatars,
  });

  factory AvaterUrlModel.fromJson(Map<String, dynamic> json) => AvaterUrlModel(
        avatars: List<String>.from(json["avatars"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "avatars": List<dynamic>.from(avatars!.map((x) => x)),
      };
}
