import 'dart:convert';

import 'package:sharepact_app/api/model/error_model.dart';

class BankResponseModel {
  final int code;
  final String? message;
  final BankModel? data;
  final Errors? errors;
  final bool? status;
  final String? resource;

  BankResponseModel({
    required this.code,
    this.message,
    this.data,
    this.errors,
    this.status,
    this.resource,
  });

  factory BankResponseModel.fromJson(Map<String, dynamic> json) {
    return BankResponseModel(
      code: json["code"],
      message: json["message"],
      data: json['data'] != null ? BankModel.fromJson(json['data']) : null,
      errors: json["errors"] != null ? Errors.fromJson(json["errors"]) : null,
      status: json["status"],
      resource: json["resource"],
    );
  }
  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data?.toJson(),
        "errors": errors?.toJson(),
        "status": status,
        "resource": resource,
      };

  BankResponseModel copyWith({
    int? code,
    String? message,
    BankModel? data,
    Errors? errors,
    bool? status,
    String? resource,
  }) {
    return BankResponseModel(
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
    return 'BankResponseModel(code: $code, message: $message, data: $data, errors: $errors, status: $status, resource: $resource)';
  }

  @override
  bool operator ==(covariant BankResponseModel other) {
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

BankResponseModel bankResponseModelFromJson(String str) =>
    BankResponseModel.fromJson(json.decode(str));

String bankResponseModelToJson(BankResponseModel data) =>
    json.encode(data.toJson());

class BankModel {
  String? id;
  String? user;
  String? accountName;
  String? bankName;
  String? accountNumber;
  String? sortCode;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  BankModel({
    this.id,
    this.user,
    this.accountName,
    this.bankName,
    this.accountNumber,
    this.sortCode,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory BankModel.fromJson(Map<String, dynamic> json) => BankModel(
        id: json["_id"],
        user: json["user"],
        accountName: json["accountName"],
        bankName: json["bankName"],
        accountNumber: json["accountNumber"],
        sortCode: json["sortCode"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user,
        "accountName": accountName,
        "bankName": bankName,
        "accountNumber": accountNumber,
        "sortCode": sortCode,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
