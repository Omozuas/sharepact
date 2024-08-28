import 'dart:convert';

import 'package:sharepact_app/api/model/error_model.dart';
import 'package:sharepact_app/api/model/subscription/admin.dart';
import 'package:sharepact_app/api/model/subscription/joinRequest_model.dart';
import 'package:sharepact_app/api/model/subscription/ServiceModel.dart';
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
}

SubscriptionResponseModel subscriptionResponseModelFromJson(String str) =>
    SubscriptionResponseModel.fromJson(json.decode(str));

String subscriptionResponseModelToJson(SubscriptionResponseModel data) =>
    json.encode(data.toJson());

class SubscriptionModel {
  String? id;
  String? planName;

  String? groupName;
  String? subscriptionPlan;
  final numberOfMembers;
  final subscriptionCost;
  final handlingFee;
  final individualShare;
  final totalCost;
  String? groupCode;
  ServiceModel? service;
  AdmineModel? admin;
  List<SubmembersModel>? members;
  List<JoinRequest>? joinRequests;
  bool? existingGroup;
  bool? activated;
  DateTime? createdAt;
  DateTime? updatedAt;
  final v;

  SubscriptionModel({
    this.id,
    this.planName,
    this.service,
    this.groupName,
    this.subscriptionPlan,
    this.numberOfMembers,
    this.subscriptionCost,
    this.handlingFee,
    this.individualShare,
    this.totalCost,
    this.groupCode,
    this.admin,
    this.members,
    this.joinRequests,
    this.existingGroup,
    this.activated,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) =>
      SubscriptionModel(
        id: json["_id"],
        planName: json["planName"],
        service: ServiceModel.fromJson(json["service"]),
        groupName: json["groupName"],
        subscriptionPlan: json["subscriptionPlan"],
        numberOfMembers: json["numberOfMembers"],
        subscriptionCost: json["subscriptionCost"],
        handlingFee: json["handlingFee"],
        individualShare: json["individualShare"],
        totalCost: json["totalCost"],
        groupCode: json["groupCode"],
        admin: AdmineModel.fromJson(json["admin"]),
        members: json["members"] != null
            ? List<SubmembersModel>.from(
                json["members"].map((x) => SubmembersModel.fromJson(x)))
            : [], // Provide an empty list if null
        joinRequests: json["joinRequests"] != null
            ? List<JoinRequest>.from(
                json["joinRequests"].map((x) => JoinRequest.fromJson(x)))
            : [],
        existingGroup: json["existingGroup"],
        activated: json["activated"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "planName": planName,
        "service": service,
        "groupName": groupName,
        "subscriptionPlan": subscriptionPlan,
        "numberOfMembers": numberOfMembers,
        "subscriptionCost": subscriptionCost,
        "handlingFee": handlingFee,
        "individualShare": individualShare,
        "totalCost": totalCost,
        "groupCode": groupCode,
        "admin": admin,
        "members": List<dynamic>.from(members!.map((x) => x.toJson())),
        "joinRequests":
            List<dynamic>.from(joinRequests!.map((x) => x.toJson())),
        "existingGroup": existingGroup,
        "activated": activated,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
