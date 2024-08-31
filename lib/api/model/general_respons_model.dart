// ignore_for_file: public_member_api_docs, sort_constructors_first
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

  GeneralResponseModel copyWith({
    int? code,
    String? message,
    dynamic data,
    Errors? errors,
    bool? status,
    String? resource,
  }) {
    return GeneralResponseModel(
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
    return 'GeneralResponseModel(code: $code, message: $message, data: $data, errors: $errors, status: $status, resource: $resource)';
  }

  @override
  bool operator ==(covariant GeneralResponseModel other) {
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

GeneralResponseModel generalResponseModelFromJson(String str) =>
    GeneralResponseModel.fromJson(json.decode(str));

String generalResponseModelToJson(GeneralResponseModel data) =>
    json.encode(data.toJson());
