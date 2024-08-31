// ignore_for_file: public_member_api_docs, sort_constructors_first
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
        "data": data,
        "errors": errors?.toJson(),
        "status": status,
        "resource": resource,
      };

  BankResponseModel copyWith({
    int? code,
    String? message,
    dynamic data,
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

  BankModel copyWith({
    String? id,
    String? user,
    String? accountName,
    String? bankName,
    String? accountNumber,
    String? sortCode,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) {
    return BankModel(
      id: id ?? this.id,
      user: user ?? this.user,
      accountName: accountName ?? this.accountName,
      bankName: bankName ?? this.bankName,
      accountNumber: accountNumber ?? this.accountNumber,
      sortCode: sortCode ?? this.sortCode,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: v ?? this.v,
    );
  }

  @override
  String toString() {
    return 'BankModel(id: $id, user: $user, accountName: $accountName, bankName: $bankName, accountNumber: $accountNumber, sortCode: $sortCode, createdAt: $createdAt, updatedAt: $updatedAt, v: $v)';
  }

  @override
  bool operator ==(covariant BankModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.user == user &&
        other.accountName == accountName &&
        other.bankName == bankName &&
        other.accountNumber == accountNumber &&
        other.sortCode == sortCode &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.v == v;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        user.hashCode ^
        accountName.hashCode ^
        bankName.hashCode ^
        accountNumber.hashCode ^
        sortCode.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        v.hashCode;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user': user,
      'accountName': accountName,
      'bankName': bankName,
      'accountNumber': accountNumber,
      'sortCode': sortCode,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
      'v': v,
    };
  }

  factory BankModel.fromMap(Map<String, dynamic> map) {
    return BankModel(
      id: map['id'] != null ? map['id'] as String : null,
      user: map['user'] != null ? map['user'] as String : null,
      accountName:
          map['accountName'] != null ? map['accountName'] as String : null,
      bankName: map['bankName'] != null ? map['bankName'] as String : null,
      accountNumber:
          map['accountNumber'] != null ? map['accountNumber'] as String : null,
      sortCode: map['sortCode'] != null ? map['sortCode'] as String : null,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int)
          : null,
      v: map['v'] != null ? map['v'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BankModel.fromJson(String source) =>
      BankModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
