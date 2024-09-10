import 'dart:convert';

import 'package:sharepact_app/api/model/error_model.dart';
import 'package:sharepact_app/api/model/groupDetails/groupdetails.dart';

GroupJoinRequestResponse groupJoinRequestResponseFromJson(String str) =>
    GroupJoinRequestResponse.fromJson(json.decode(str));

String groupJoinRequestResponseToJson(GroupJoinRequestResponse data) =>
    json.encode(data.toJson());

class GroupJoinRequestResponse {
  final int? code;
  final String? message;
  final List<JoinRequest>? data;
  final Errors? errors;
  final bool? status;
  final String? resource;
  GroupJoinRequestResponse({
    this.code,
    this.message,
    this.data,
    this.errors,
    this.status,
    this.resource,
  });

  factory GroupJoinRequestResponse.fromJson(Map<String, dynamic> json) =>
      GroupJoinRequestResponse(
        code: json["code"],
        message: json["message"],
        data: json["data"] != null
            ? List<JoinRequest>.from(
                json["data"].map((x) => JoinRequest.fromJson(x)))
            : [], // Properly handle empty or null joinRequests,
        errors: json["errors"] != null ? Errors.fromJson(json["errors"]) : null,
        status: json["status"],
        resource: json["resource"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data != null
            ? List<dynamic>.from(data!.map((x) => x.toJson()))
            : [],
        "errors": errors?.toJson(),
        "status": status,
        "resource": resource,
      };
}
