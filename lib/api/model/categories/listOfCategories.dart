// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:sharepact_app/api/model/error_model.dart';

class CategoriesResponseModel {
  final int code;
  final String? message;
  final List<CategoriesModel>? data;
  final Errors? errors;
  final bool? status;
  final String? resource;

  CategoriesResponseModel({
    required this.code,
    this.message,
    this.data,
    this.errors,
    this.status,
    this.resource,
  });

  factory CategoriesResponseModel.fromJson(Map<String, dynamic> json) {
    return CategoriesResponseModel(
      code: json["code"],
      message: json["message"],
      data: json['data'] != null
          ? List<CategoriesModel>.from(
              json['data'].map((x) => CategoriesModel.fromJson(x)))
          : [],
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

  CategoriesResponseModel copyWith({
    int? code,
    String? message,
    List<CategoriesModel>? data,
    Errors? errors,
    bool? status,
    String? resource,
  }) {
    return CategoriesResponseModel(
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
    return 'CategoriesResponseModel(code: $code, message: $message, data: $data, errors: $errors, status: $status, resource: $resource)';
  }

  @override
  bool operator ==(covariant CategoriesResponseModel other) {
    if (identical(this, other)) return true;

    return other.code == code &&
        other.message == message &&
        listEquals(other.data, data) &&
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

CategoriesResponseModel categoriesResponseModelFromJson(String str) =>
    CategoriesResponseModel.fromJson(json.decode(str));

String categoriesResponseModelToJson(CategoriesResponseModel data) =>
    json.encode(data.toJson());

class CategoriesModel {
  String? id;
  String? categoryName;
  String? imageUrl;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  CategoriesModel({
    this.id,
    this.categoryName,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      CategoriesModel(
        id: json["_id"],
        categoryName: json["categoryName"],
        imageUrl: json["imageUrl"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "categoryName": categoryName,
        "imageUrl": imageUrl,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
      };

  CategoriesModel copyWith({
    String? id,
    String? categoryName,
    String? imageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) {
    return CategoriesModel(
      id: id ?? this.id,
      categoryName: categoryName ?? this.categoryName,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: v ?? this.v,
    );
  }

  @override
  String toString() {
    return 'CategoriesModel(id: $id, categoryName: $categoryName, imageUrl: $imageUrl, createdAt: $createdAt, updatedAt: $updatedAt, v: $v)';
  }

  @override
  bool operator ==(covariant CategoriesModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.categoryName == categoryName &&
        other.imageUrl == imageUrl &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.v == v;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        categoryName.hashCode ^
        imageUrl.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        v.hashCode;
  }
}
