import 'package:sharepact_app/api/model/chat_model.dart';

class ChatNotification {
  String? subject;
  String? type;
  Group? group;
  User? user;
  Message? message;
  String? name;

  ChatNotification({
    this.subject,
    this.type,
    this.group,
    this.user,
    this.message,
    this.name,
  });

  factory ChatNotification.fromJson(Map<String, dynamic> json) {
    return ChatNotification(
      subject: json['subject'] as String?,
      type: json['type'] as String?,
      group: json['group'] != null ? Group.fromJson(json['group']) : null,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      message:
          json['message'] != null ? Message.fromJson(json['message']) : null,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subject': subject,
      'type': type,
      'group': group?.toJson(),
      'user': user?.toJson(),
      'message': message?.toJson(),
      'name': name,
    };
  }
}

class Group {
  String? id;
  String? service;
  String? groupName;
  int? numberOfMembers;
  double? subscriptionCost;
  double? handlingFee;
  double? individualShare;
  String? groupCode;
  String? admin;
  List<Member>? members;
  List<dynamic>? joinRequests;
  bool? oneTimePayment;
  bool? existingGroup;
  bool? activated;
  String? latestMessageTime;
  String? createdAt;
  String? updatedAt;

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
    this.latestMessageTime,
    this.createdAt,
    this.updatedAt,
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      id: json['_id'] as String?,
      service: json['service'] as String?,
      groupName: json['groupName'] as String?,
      numberOfMembers: json['numberOfMembers'] as int?,
      subscriptionCost: (json['subscriptionCost'] as num?)?.toDouble(),
      handlingFee: (json['handlingFee'] as num?)?.toDouble(),
      individualShare: (json['individualShare'] as num?)?.toDouble(),
      groupCode: json['groupCode'] as String?,
      admin: json['admin'] as String?,
      members: (json['members'] as List<dynamic>?)
          ?.map((e) => Member.fromJson(e as Map<String, dynamic>))
          .toList(),
      joinRequests: json['joinRequests'] as List<dynamic>?,
      oneTimePayment: json['oneTimePayment'] as bool?,
      existingGroup: json['existingGroup'] as bool?,
      activated: json['activated'] as bool?,
      latestMessageTime: json['latestMessageTime'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'service': service,
      'groupName': groupName,
      'numberOfMembers': numberOfMembers,
      'subscriptionCost': subscriptionCost,
      'handlingFee': handlingFee,
      'individualShare': individualShare,
      'groupCode': groupCode,
      'admin': admin,
      'members': members?.map((e) => e.toJson()).toList(),
      'joinRequests': joinRequests,
      'oneTimePayment': oneTimePayment,
      'existingGroup': existingGroup,
      'activated': activated,
      'latestMessageTime': latestMessageTime,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

class Member {
  String? user;
  String? subscriptionStatus;
  bool? confirmStatus;
  bool? paymentActive;
  String? id;
  String? addedAt;

  Member({
    this.user,
    this.subscriptionStatus,
    this.confirmStatus,
    this.paymentActive,
    this.id,
    this.addedAt,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      user: json['user'] as String?,
      subscriptionStatus: json['subscriptionStatus'] as String?,
      confirmStatus: json['confirmStatus'] as bool?,
      paymentActive: json['paymentActive'] as bool?,
      id: json['_id'] as String?,
      addedAt: json['addedAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user,
      'subscriptionStatus': subscriptionStatus,
      'confirmStatus': confirmStatus,
      'paymentActive': paymentActive,
      '_id': id,
      'addedAt': addedAt,
    };
  }
}

class User {
  String? id;
  String? email;
  String? username;
  String? avatarUrl;
  bool? verified;
  String? role;
  String? deviceToken;
  NotificationConfig? notificationConfig;
  bool? deleted;
  String? createdAt;
  String? updatedAt;

  User({
    this.id,
    this.email,
    this.username,
    this.avatarUrl,
    this.verified,
    this.role,
    this.deviceToken,
    this.notificationConfig,
    this.deleted,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] as String?,
      email: json['email'] as String?,
      username: json['username'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      verified: json['verified'] as bool?,
      role: json['role'] as String?,
      deviceToken: json['deviceToken'] as String?,
      notificationConfig: json['notificationConfig'] != null
          ? NotificationConfig.fromJson(json['notificationConfig'])
          : null,
      deleted: json['deleted'] as bool?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'username': username,
      'avatarUrl': avatarUrl,
      'verified': verified,
      'role': role,
      'deviceToken': deviceToken,
      'notificationConfig': notificationConfig?.toJson(),
      'deleted': deleted,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

class NotificationConfig {
  bool? loginAlert;
  bool? passwordChanges;
  bool? newGroupCreation;
  bool? groupInvitation;
  bool? groupMessages;
  bool? subscriptionUpdates;
  bool? paymentReminders;
  bool? renewalAlerts;
  String? id;

  NotificationConfig({
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

  factory NotificationConfig.fromJson(Map<String, dynamic> json) {
    return NotificationConfig(
      loginAlert: json['loginAlert'] as bool?,
      passwordChanges: json['passwordChanges'] as bool?,
      newGroupCreation: json['newGroupCreation'] as bool?,
      groupInvitation: json['groupInvitation'] as bool?,
      groupMessages: json['groupMessages'] as bool?,
      subscriptionUpdates: json['subscriptionUpdates'] as bool?,
      paymentReminders: json['paymentReminders'] as bool?,
      renewalAlerts: json['renewalAlerts'] as bool?,
      id: json['_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'loginAlert': loginAlert,
      'passwordChanges': passwordChanges,
      'newGroupCreation': newGroupCreation,
      'groupInvitation': groupInvitation,
      'groupMessages': groupMessages,
      'subscriptionUpdates': subscriptionUpdates,
      'paymentReminders': paymentReminders,
      'renewalAlerts': renewalAlerts,
      '_id': id,
    };
  }
}

class Message {
  String? id;
  String? content;
  Sender? sender;
  String? group;
  String? replyTo;
  List<dynamic>? readBy;
  String? sentAt;

  Message({
    this.id,
    this.content,
    this.sender,
    this.group,
    this.replyTo,
    this.readBy,
    this.sentAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['_id'] as String?,
      content: json['content'] as String?,
      sender: json['sender'] != null ? Sender.fromJson(json['sender']) : null,
      group: json['group'] as String?,
      replyTo: json['replyTo'] as String?,
      readBy: json['readBy'] as List<dynamic>?,
      sentAt: json['sentAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'content': content,
      'sender': sender?.toJson(),
      'group': group,
      'replyTo': replyTo,
      'readBy': readBy,
      'sentAt': sentAt,
    };
  }
}
