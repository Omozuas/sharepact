import 'dart:convert';

import 'package:sharepact_app/api/model/error_model.dart';

GroupdetailsResponse groupdetailsResponseFromJson(String str) =>
    GroupdetailsResponse.fromJson(json.decode(str));

String groupdetailsResponseToJson(GroupdetailsResponse data) =>
    json.encode(data.toJson());

class GroupdetailsResponse {
  final int? code;
  final String? message;
  final Groupdetails? data;
  final Errors? errors;
  final bool? status;
  final String? resource;
  GroupdetailsResponse({
    this.code,
    this.message,
    this.data,
    this.errors,
    this.status,
    this.resource,
  });

  factory GroupdetailsResponse.fromJson(Map<String, dynamic> json) =>
      GroupdetailsResponse(
        code: json["code"],
        message: json["message"],
        data: json["data"] != null ? Groupdetails.fromJson(json["data"]) : null,
        errors: json["errors"] != null ? Errors.fromJson(json["errors"]) : null,
        status: json["status"],
        resource: json["resource"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data?.toJson(),
        "errors": errors?.toJson(),
        "status": status,
        "resource": resource,
      };
}

class Groupdetails {
  final String? id;
  final String? service;
  final String? groupName;
  final int? numberOfMembers;
  final int? subscriptionCost;
  final int? handlingFee;
  final double? individualShare;
  final String? groupCode;
  final Admin? admin;
  final List<Member>? members;
  final List<JoinRequest>? joinRequests;
  final bool? oneTimePayment;
  final bool? existingGroup;
  final bool? activated;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final DateTime? nextSubscriptionDate;
  final String? serviceName;
  final String? serviceLogo;
  final String? serviceDescription;
  Groupdetails(
      {this.id,
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
      this.oneTimePayment,
      this.existingGroup,
      this.activated,
      this.createdAt,
      this.updatedAt,
      this.v,
      this.nextSubscriptionDate,
      this.serviceName,
      this.serviceLogo,
      this.serviceDescription});

  factory Groupdetails.fromJson(Map<String, dynamic> json) => Groupdetails(
      id: json["_id"] as String?,
      service: json["service"] as String?,
      groupName: json["groupName"] as String?,
      numberOfMembers: json["numberOfMembers"] as int?,
      subscriptionCost: json["subscriptionCost"] as int?,
      handlingFee: json["handlingFee"] as int?,
      individualShare: json["individualShare"] != null
          ? (json["individualShare"] as num).toDouble()
          : null,
      groupCode: json["groupCode"] as String?,
      admin: json["admin"] != null
          ? Admin.fromJson(json["admin"])
          : null, // Null check
      // Handle nullable lists
      members: json["members"] != null
          ? List<Member>.from(json["members"].map((x) => Member.fromJson(x)))
          : [],
      joinRequests: json["joinRequests"] != null
          ? List<JoinRequest>.from(
              json["joinRequests"].map((x) => JoinRequest.fromJson(x)))
          : [], // Properly handle empty or null joinRequests
      oneTimePayment: json["oneTimePayment"] as bool?,
      existingGroup: json["existingGroup"] as bool?,
      activated: json["activated"] as bool?,
      createdAt:
          json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null,
      updatedAt:
          json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : null,
      v: json["__v"] as int?,
      nextSubscriptionDate: json["nextSubscriptionDate"] != null
          ? DateTime.parse(json["nextSubscriptionDate"])
          : null,
      serviceName: json["serviceName"] as String?,
      serviceLogo: json["serviceLogo"] as String?,
      serviceDescription: json["serviceDescription"] as String?);

  Map<String, dynamic> toJson() => {
        "_id": id,
        "service": service,
        "groupName": groupName,
        "numberOfMembers": numberOfMembers,
        "subscriptionCost": subscriptionCost,
        "handlingFee": handlingFee,
        "individualShare": individualShare,
        "groupCode": groupCode,
        "admin": admin?.toJson(), // Null safe
        "members": members != null
            ? List<Member>.from(members!.map((x) => x.toJson()))
            : [],
        "joinRequests": joinRequests != null
            ? List<dynamic>.from(joinRequests!.map((x) => x.toJson()))
            : [],
        "oneTimePayment": oneTimePayment,
        "existingGroup": existingGroup,
        "activated": activated,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "nextSubscriptionDate": nextSubscriptionDate?.toIso8601String(),
        "serviceName": serviceName,
        "serviceLogo": serviceLogo,
        "serviceDescription": serviceDescription
      };
}

class Admin {
  final String? id;
  final String? username;
  final String? avatarUrl;

  Admin({
    this.id,
    this.username,
    this.avatarUrl,
  });

  factory Admin.fromJson(Map<String, dynamic> json) => Admin(
        id: json["_id"] as String?,
        username: json["username"] as String?,
        avatarUrl: json["avatarUrl"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "avatarUrl": avatarUrl,
      };
}

class JoinRequest {
  final Admin? user;
  final String? message;
  final String? id;

  JoinRequest({
    this.user,
    this.message,
    this.id,
  });

  factory JoinRequest.fromJson(Map<String, dynamic> json) {
    return JoinRequest(
      user: json["user"] != null
          ? Admin.fromJson(json["user"])
          : null, // Ensure proper null handling
      message: json["message"] as String?,
      id: json["_id"] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "message": message,
        "_id": id,
      };
}

class Member {
  final Admin? user;
  final String? subscriptionStatus;
  final bool? confirmStatus;
  final bool? paymentActive;
  final String? id;
  final DateTime? lastInvoiceSentAt;

  Member({
    this.user,
    this.subscriptionStatus,
    this.confirmStatus,
    this.paymentActive,
    this.id,
    this.lastInvoiceSentAt,
  });

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        user: json["user"] != null
            ? Admin.fromJson(json["user"])
            : null, // Null check
        subscriptionStatus: json["subscriptionStatus"] as String?,
        confirmStatus: json["confirmStatus"] as bool?,
        paymentActive: json["paymentActive"] as bool?,
        id: json["_id"] as String?,
        lastInvoiceSentAt: json["lastInvoiceSentAt"] != null
            ? DateTime.parse(json["lastInvoiceSentAt"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(), // Null safe
        "subscriptionStatus": subscriptionStatus,
        "confirmStatus": confirmStatus,
        "paymentActive": paymentActive,
        "_id": id,
        "lastInvoiceSentAt": lastInvoiceSentAt?.toIso8601String(),
      };
}
