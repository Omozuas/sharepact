// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/foundation.dart';

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

  AvaterResponseModel copyWith({
    int? code,
    String? message,
    AvaterUrlModel? data,
    Errors? errors,
    bool? status,
    String? resource,
  }) {
    return AvaterResponseModel(
      code: code ?? this.code,
      message: message ?? this.message,
      data: data ?? this.data,
      errors: errors ?? this.errors,
      status: status ?? this.status,
      resource: resource ?? this.resource,
    );
  }

  @override
  String toString() {
    return 'AvaterResponseModel(code: $code, message: $message, data: $data, errors: $errors, status: $status, resource: $resource)';
  }

  @override
  bool operator ==(covariant AvaterResponseModel other) {
    if (identical(this, other)) return true;

    return other.code == code &&
        other.message == message &&
        other.data == data &&
        other.errors == errors &&
        other.status == status &&
        other.resource == resource;
  }

  @override
  int get hashCode {
    return code.hashCode ^
        message.hashCode ^
        data.hashCode ^
        errors.hashCode ^
        status.hashCode ^
        resource.hashCode;
  }
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

  AvaterUrlModel copyWith({
    List<String>? avatars,
  }) {
    return AvaterUrlModel(
      avatars: avatars ?? this.avatars,
    );
  }

  @override
  String toString() => 'AvaterUrlModel(avatars: $avatars)';

  @override
  bool operator ==(covariant AvaterUrlModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.avatars, avatars);
  }

  @override
  int get hashCode => avatars.hashCode;
}
