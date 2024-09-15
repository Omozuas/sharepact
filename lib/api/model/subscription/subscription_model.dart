// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:sharepact_app/api/model/error_model.dart';
import 'package:sharepact_app/api/model/subscription/ServiceModel.dart';
import 'package:sharepact_app/api/model/subscription/admin.dart';
import 'package:sharepact_app/api/model/subscription/join_request_model.dart';
import 'package:sharepact_app/api/model/subscription/subMembers_model.dart';

class SubscriptionResponseModel {
  final int code;
  final String? message;
  final List<SubscriptionModel>? data;
  final Errors? errors;
  final bool? status;
  final String? resource;

  SubscriptionResponseModel({
    required this.code,
    this.message,
    this.data,
    this.errors,
    this.status,
    this.resource,
  });

  factory SubscriptionResponseModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionResponseModel(
      code: json["code"],
      message: json["message"],
      data: json['data'] != null
          ? List<SubscriptionModel>.from(
              json['data'].map((x) => SubscriptionModel.fromJson(x)))
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

  SubscriptionResponseModel copyWith({
    int? code,
    String? message,
    List<SubscriptionModel>? data,
    Errors? errors,
    bool? status,
    String? resource,
  }) {
    return SubscriptionResponseModel(
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
    return 'SubscriptionResponseModel(code: $code, message: $message, data: $data, errors: $errors, status: $status, resource: $resource)';
  }

  @override
  bool operator ==(covariant SubscriptionResponseModel other) {
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

SubscriptionResponseModel subscriptionResponseModelFromJson(String str) =>
    SubscriptionResponseModel.fromJson(json.decode(str));

String subscriptionResponseModelToJson(SubscriptionResponseModel data) =>
    json.encode(data.toJson());

class SubscriptionModel {
  String? id;
  String? groupName;
  final numberOfMembers;
  final subscriptionCost;
  final handlingFee;
  final individualShare;
  String? groupCode;
  ServiceModel? service;
  AdmineModel? admin;
  List<SubmembersModel>? members;
  List<JoinRequest>? joinRequests;
  bool? existingGroup;
  bool? activated;
  DateTime? nextSubscriptionDate;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? oneTimePayment;
  final v;

  SubscriptionModel({
    this.id,
    this.service,
    this.groupName,
    this.numberOfMembers,
    this.subscriptionCost,
    this.handlingFee,
    this.individualShare,
    this.groupCode,
    this.admin,
    this.members,
    this.joinRequests,
    this.existingGroup,
    this.activated,
    this.createdAt,
    this.updatedAt,
    this.nextSubscriptionDate,
    this.oneTimePayment,
    this.v,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      id: json["_id"] as String?, // Safely cast to String?
      service: json["service"] != null
          ? ServiceModel.fromJson(json["service"])
          : null,
      groupName: json["groupName"] as String?, // Safely cast to String?
      numberOfMembers: json["numberOfMembers"],
      subscriptionCost: json["subscriptionCost"],
      handlingFee: json["handlingFee"],
      individualShare: json["individualShare"],
      groupCode: json["groupCode"] as String?, // Safely cast to String?
      oneTimePayment: json["oneTimePayment"] as bool?,
      admin: json["admin"] != null ? AdmineModel.fromJson(json["admin"]) : null,
      members: json["members"] != null
          ? List<SubmembersModel>.from(
              json["members"].map((x) => SubmembersModel.fromJson(x)))
          : [], // Provide an empty list if null
      joinRequests: json["joinRequests"] != null
          ? List<JoinRequest>.from(
              json["joinRequests"].map((x) => JoinRequest.fromJson(x)))
          : [], // Provide an empty list if null
      existingGroup: json["existingGroup"] as bool?,
      nextSubscriptionDate: json["nextSubscriptionDate"] != null
          ? DateTime.parse(json["nextSubscriptionDate"])
          : null,
      activated: json["activated"] as bool?,
      createdAt:
          json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null,
      updatedAt:
          json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : null,
      v: json["__v"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "service": service,
        "groupName": groupName,
        "numberOfMembers": numberOfMembers,
        "subscriptionCost": subscriptionCost,
        "handlingFee": handlingFee,
        "individualShare": individualShare,
        "groupCode": groupCode,
        "admin": admin?.toJson(),
        "members": List<dynamic>.from(members!.map((x) => x.toJson())),
        "joinRequests":
            List<dynamic>.from(joinRequests!.map((x) => x.toJson())),
        "existingGroup": existingGroup,
        "activated": activated,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "nextSubscriptionDate": nextSubscriptionDate?.toIso8601String(),
      };

  SubscriptionModel copyWith({
    String? id,
    String? groupName,
    String? groupCode,
    ServiceModel? service,
    AdmineModel? admin,
    List<SubmembersModel>? members,
    List<JoinRequest>? joinRequests,
    bool? existingGroup,
    bool? activated,
    DateTime? nextSubscriptionDate,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? oneTimePayment,
  }) {
    return SubscriptionModel(
      id: id ?? this.id,
      groupName: groupName ?? this.groupName,
      groupCode: groupCode ?? this.groupCode,
      service: service ?? this.service,
      admin: admin ?? this.admin,
      members: members ?? this.members,
      joinRequests: joinRequests ?? this.joinRequests,
      existingGroup: existingGroup ?? this.existingGroup,
      activated: activated ?? this.activated,
      nextSubscriptionDate: nextSubscriptionDate ?? this.nextSubscriptionDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      oneTimePayment: oneTimePayment ?? this.oneTimePayment,
    );
  }

  @override
  String toString() {
    return 'SubscriptionModel(id: $id, groupName: $groupName, groupCode: $groupCode, service: $service, admin: $admin, members: $members, joinRequests: $joinRequests, existingGroup: $existingGroup, activated: $activated, nextSubscriptionDate: $nextSubscriptionDate, createdAt: $createdAt, updatedAt: $updatedAt, oneTimePayment: $oneTimePayment)';
  }

  @override
  bool operator ==(covariant SubscriptionModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.groupName == groupName &&
        other.groupCode == groupCode &&
        other.service == service &&
        other.admin == admin &&
        listEquals(other.members, members) &&
        listEquals(other.joinRequests, joinRequests) &&
        other.existingGroup == existingGroup &&
        other.activated == activated &&
        other.nextSubscriptionDate == nextSubscriptionDate &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.oneTimePayment == oneTimePayment;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        groupName.hashCode ^
        groupCode.hashCode ^
        service.hashCode ^
        admin.hashCode ^
        members.hashCode ^
        joinRequests.hashCode ^
        existingGroup.hashCode ^
        activated.hashCode ^
        nextSubscriptionDate.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        oneTimePayment.hashCode;
  }
}
