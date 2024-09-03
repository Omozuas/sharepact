import 'dart:convert';

import 'package:sharepact_app/api/model/error_model.dart';

class NotificationConfigResponse {
  final int code;
  final String? message;
  final NotificationConfigData? data;
  final Errors? errors;
  final bool? status;
  final String? resource;

  NotificationConfigResponse({
    required this.code,
    this.message,
    this.data,
    this.errors,
    this.status,
    this.resource,
  });

  factory NotificationConfigResponse.fromJson(Map<String, dynamic> json) {
    return NotificationConfigResponse(
      code: json["code"],
      message: json["message"],
      data: json['data'] != null
          ? NotificationConfigData.fromJson(json['data'])
          : null,
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

  NotificationConfigResponse copyWith({
    int? code,
    String? message,
    dynamic data,
    Errors? errors,
    bool? status,
    String? resource,
  }) {
    return NotificationConfigResponse(
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
    return 'NotificationConfigResponse(code: $code, message: $message, data: $data, errors: $errors, status: $status, resource: $resource)';
  }

  @override
  bool operator ==(covariant NotificationConfigResponse other) {
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

NotificationConfigResponse notificationConfigResponseFromJson(String str) =>
    NotificationConfigResponse.fromJson(json.decode(str));

String notificationConfigResponseToJson(NotificationConfigResponse data) =>
    json.encode(data.toJson());

class NotificationConfigData {
  bool? loginAlert;
  bool? passwordChanges;
  bool? newGroupCreation;
  bool? groupInvitation;
  bool? groupMessages;
  bool? subscriptionUpdates;
  bool? paymentReminders;
  bool? renewalAlerts;
  String? id;

  NotificationConfigData({
    this.loginAlert,
    this.passwordChanges,
    this.newGroupCreation,
    this.groupInvitation,
    this.groupMessages,
    this.subscriptionUpdates,
    this.paymentReminders,
    this.renewalAlerts,
    this.id,
  });

  factory NotificationConfigData.fromJson(Map<String, dynamic> json) =>
      NotificationConfigData(
        loginAlert: json["loginAlert"],
        passwordChanges: json["passwordChanges"],
        newGroupCreation: json["newGroupCreation"],
        groupInvitation: json["groupInvitation"],
        groupMessages: json["groupMessages"],
        subscriptionUpdates: json["subscriptionUpdates"],
        paymentReminders: json["paymentReminders"],
        renewalAlerts: json["renewalAlerts"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "loginAlert": loginAlert,
        "passwordChanges": passwordChanges,
        "newGroupCreation": newGroupCreation,
        "groupInvitation": groupInvitation,
        "groupMessages": groupMessages,
        "subscriptionUpdates": subscriptionUpdates,
        "paymentReminders": paymentReminders,
        "renewalAlerts": renewalAlerts,
        "_id": id,
      };
}
