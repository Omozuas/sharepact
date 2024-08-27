import 'dart:convert';

import 'package:sharepact_app/api/model/error_model.dart';

class GeneralResponseModel {
  final int code;
  final String? message;
  final dynamic data;
  final Errors? errors;
  final bool? status;
  final String? resource;

  GeneralResponseModel({
    required this.code,
    this.message,
    this.data,
    this.errors,
    this.status,
    this.resource,
  });

  factory GeneralResponseModel.fromJson(Map<String, dynamic> json) {
    return GeneralResponseModel(
      code: json["code"],
      message: json["message"],
      data: json['data'],
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

GeneralResponseModel generalResponseModelFromJson(String str) =>
    GeneralResponseModel.fromJson(json.decode(str));

String generalResponseModelToJson(GeneralResponseModel data) =>
    json.encode(data.toJson());
