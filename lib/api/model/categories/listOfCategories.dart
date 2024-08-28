import 'dart:convert';

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
}
