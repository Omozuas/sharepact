// To parse this JSON data, do
//
//     final GroupResponseList = GroupResponseListFromJson(jsonString);

import 'dart:convert';

GroupResponseList groupResponseListFromJson(String str) =>
    GroupResponseList.fromJson(json.decode(str));

String groupResponseListToJson(GroupResponseList data) =>
    json.encode(data.toJson());

class GroupResponseList {
  final int? code;
  final String? message;
  final GroupData? data;

  GroupResponseList({
    this.code,
    this.message,
    this.data,
  });

  factory GroupResponseList.fromJson(Map<String, dynamic> json) =>
      GroupResponseList(
        code: json["code"],
        message: json["message"],
        data: GroupData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data?.toJson(),
      };
}

class GroupData {
  final List<Group>? groups;
  final Pagination? pagination;

  GroupData({
    this.groups,
    this.pagination,
  });

  factory GroupData.fromJson(Map<String, dynamic> json) => GroupData(
        groups: json["groups"] != null
            ? List<Group>.from(json["groups"].map((x) => Group.fromJson(x)))
            : [], // Return an empty list if null
        pagination: json["pagination"] != null
            ? Pagination.fromJson(json["pagination"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "groups": groups != null
            ? List<dynamic>.from(groups!.map((x) => x.toJson()))
            : [], // Return an empty list if null
        "pagination": pagination?.toJson(),
      };
}

class Group {
  final String? id;
  final Service? service;
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
  final int? unreadMessages;
  final LatestMessage? latestMessage;
  final dynamic latestMessageTime;
  final DateTime? nextSubscriptionDate;

  Group({
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
    this.oneTimePayment,
    this.existingGroup,
    this.activated,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.unreadMessages,
    this.latestMessage,
    this.latestMessageTime,
    this.nextSubscriptionDate,
  });

  factory Group.fromJson(Map<String, dynamic> json) => Group(
        id: json["_id"] ?? '', // Provide a fallback empty string if null
        service: json["service"] != null
            ? Service.fromJson(json["service"])
            : null, // Handle nullable service
        groupName: json["groupName"] ?? '', // Fallback for missing groupName
        numberOfMembers: json["numberOfMembers"] ?? 0,
        subscriptionCost: json["subscriptionCost"] ?? 0,
        handlingFee: json["handlingFee"] ?? 0,
        individualShare: json["individualShare"] != null
            ? json["individualShare"].toDouble()
            : 0.0,
        groupCode: json["groupCode"] ?? '',
        admin: json["admin"] != null ? Admin.fromJson(json["admin"]) : null,
        members: json["members"] != null
            ? List<Member>.from(json["members"].map((x) => Member.fromJson(x)))
            : [], // Handle empty members list
        joinRequests: json["joinRequests"] != null
            ? List<JoinRequest>.from(
                json["joinRequests"].map((x) => JoinRequest.fromJson(x)))
            : [], // Handle empty joinRequests list
        oneTimePayment: json["oneTimePayment"] ?? false,
        existingGroup: json["existingGroup"] ?? false,
        activated: json["activated"] ?? false,
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
        v: json["__v"] ?? 0,
        unreadMessages: json["unreadMessages"] ?? 0,
        latestMessage: json['latestMessage'] != null
            ? LatestMessage.fromJson(json["latestMessage"])
            : null,
        latestMessageTime: json["latestMessageTime"] ?? '',
        nextSubscriptionDate: json["nextSubscriptionDate"] != null
            ? DateTime.parse(json["nextSubscriptionDate"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "service": service?.toJson(),
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
        "oneTimePayment": oneTimePayment,
        "existingGroup": existingGroup,
        "activated": activated,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "unreadMessages": unreadMessages,
        "latestMessage": latestMessage?.toJson(),
        "latestMessageTime": latestMessageTime,
        "nextSubscriptionDate": nextSubscriptionDate?.toIso8601String(),
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
        id: json["_id"],
        username: json["username"],
        avatarUrl: json["avatarUrl"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "avatarUrl": avatarUrl,
      };
}

class JoinRequest {
  String? user;
  String? message;
  String? id;

  JoinRequest({
    this.user,
    this.message,
    this.id,
  });

  factory JoinRequest.fromJson(Map<String, dynamic> json) => JoinRequest(
        user: json["user"],
        message: json["message"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "message": message,
        "_id": id,
      };
}

class LatestMessage {
  String? id;
  String? content;
  Sender? sender;
  String? group;
  dynamic replyTo;
  List<dynamic>? readBy;
  DateTime? sentAt;
  int? v;

  LatestMessage({
    this.id,
    this.content,
    this.sender,
    this.group,
    this.replyTo,
    this.readBy,
    this.sentAt,
    this.v,
  });

  factory LatestMessage.fromJson(Map<String, dynamic> json) => LatestMessage(
        id: json["_id"],
        content: json["content"],
        sender: Sender.fromJson(json["sender"]),
        group: json["group"],
        replyTo: json["replyTo"],
        readBy: List<dynamic>.from(json["readBy"].map((x) => x)),
        sentAt: DateTime.parse(json["sentAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "content": content,
        "sender": sender?.toJson(),
        "group": group,
        "replyTo": replyTo,
        "readBy": List<dynamic>.from(readBy!.map((x) => x)),
        "sentAt": sentAt?.toIso8601String(),
        "__v": v,
      };
}

class Sender {
  String? id;
  String? email;
  String? username;

  Sender({
    this.id,
    this.email,
    this.username,
  });

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
        id: json["_id"],
        email: json["email"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "username": username,
      };
}

class Member {
  final String? user;
  final SubscriptionStatus? subscriptionStatus;
  final bool? confirmStatus;
  final bool? paymentActive;
  final String? id;
  final DateTime? addedAt;
  final DateTime? lastInvoiceSentAt;

  Member({
    this.user,
    this.subscriptionStatus,
    this.confirmStatus,
    this.paymentActive,
    this.id,
    this.addedAt,
    this.lastInvoiceSentAt,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      user: json["user"],
      subscriptionStatus: json["subscriptionStatus"] != null
          ? subscriptionStatusValues.map[json["subscriptionStatus"]]
          : null, // Safely handle null
      confirmStatus: json["confirmStatus"] ?? false, // Default to false if null
      paymentActive: json["paymentActive"] ?? false, // Default to false if null
      id: json["_id"],
      addedAt: json["addedAt"] != null ? DateTime.parse(json["addedAt"]) : null,
      lastInvoiceSentAt: json["lastInvoiceSentAt"] != null
          ? DateTime.parse(json["lastInvoiceSentAt"])
          : null, // Safely parse date or set null
    );
  }

  Map<String, dynamic> toJson() => {
        "user": user,
        "subscriptionStatus":
            subscriptionStatusValues.reverse[subscriptionStatus],
        "confirmStatus": confirmStatus,
        "paymentActive": paymentActive,
        "_id": id,
        "addedAt": addedAt?.toIso8601String(),
        "lastInvoiceSentAt": lastInvoiceSentAt?.toIso8601String(),
      };
}

enum SubscriptionStatus { ACTIVE, INACTIVE }

final subscriptionStatusValues = EnumValues({
  "active": SubscriptionStatus.ACTIVE,
  "inactive": SubscriptionStatus.INACTIVE
});

class Service {
  String? id;
  String? serviceName;
  String? logoUrl;

  Service({
    this.id,
    this.serviceName,
    this.logoUrl,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["_id"],
        serviceName: json["serviceName"],
        logoUrl: json["logoUrl"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "serviceName": serviceName,
        "logoUrl": logoUrl,
      };
}

class Pagination {
  int? totalItems;
  int? totalPages;
  int? currentPage;

  Pagination({
    this.totalItems,
    this.totalPages,
    this.currentPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        totalItems: json["totalItems"],
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
      );

  Map<String, dynamic> toJson() => {
        "totalItems": totalItems,
        "totalPages": totalPages,
        "currentPage": currentPage,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
