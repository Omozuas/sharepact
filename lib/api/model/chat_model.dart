import 'dart:convert';

// class Message {
//   final String id;
//   final String content;
//   final Sender sender;
//   final String group;
//   final String? replyTo;
//   final List<dynamic> readBy;
//   final DateTime sentAt;
//   final int version;

//   Message({
//     required this.id,
//     required this.content,
//     required this.sender,
//     required this.group,
//     this.replyTo,
//     required this.readBy,
//     required this.sentAt,
//     required this.version,
//   });

//   factory Message.fromJson(Map<String, dynamic> json) {
//     return Message(
//       id: json['_id'],
//       content: json['content'],
//       sender: Sender.fromJson(json['sender']),
//       group: json['group'],
//       replyTo: json['replyTo'],
//       readBy: json['readBy'],
//       sentAt: DateTime.parse(json['sentAt']),
//       version: json['__v'],
//     );
//   }
//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "content": content,
//         "sender": sender.toJson(),
//         "group": group,
//         "replyTo": replyTo,
//         "readBy": readBy,
//         "sentAt": sentAt.toIso8601String(),
//         "__v": version,
//       };
// }

// class Sender {
//   final String id;
//   final String email;
//   final String username;

//   Sender({
//     required this.id,
//     required this.email,
//     required this.username,
//   });

//   factory Sender.fromJson(Map<String, dynamic> json) {
//     return Sender(
//       id: json['_id'],
//       email: json['email'],
//       username: json['username'],
//     );
//   }
//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "email": email,
//         "username": username,
//       };
// }

// class User {
//   final String id;
//   final String email;
//   final String username;
//   final String avatarUrl;
//   final bool verified;
//   final String role;
//   final NotificationConfig notificationConfig;
//   final bool deleted;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final int version;

//   User({
//     required this.id,
//     required this.email,
//     required this.username,
//     required this.avatarUrl,
//     required this.verified,
//     required this.role,
//     required this.notificationConfig,
//     required this.deleted,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.version,
//   });

//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['_id'],
//       email: json['email'],
//       username: json['username'],
//       avatarUrl: json['avatarUrl'],
//       verified: json['verified'],
//       role: json['role'],
//       notificationConfig: NotificationConfig.fromJson(json['notificationConfig']),
//       deleted: json['deleted'],
//       createdAt: DateTime.parse(json['createdAt']),
//       updatedAt: DateTime.parse(json['updatedAt']),
//       version: json['__v'],
//     );

//   }
//    Map<String, dynamic> toJson() => {
//         "_id": id,
//         "email": email,
//         "username": username,
//         "avatarUrl": avatarUrl,
//         "verified": verified,
//         "role": role,
//         "notificationConfig": notificationConfig.toJson(),
//         "deleted": deleted,
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//         "__v": version,
//       };
// }

// class NotificationConfig {
//   final bool loginAlert;
//   final bool passwordChanges;
//   final bool newGroupCreation;
//   final bool groupInvitation;
//   final bool groupMessages;
//   final bool subscriptionUpdates;
//   final bool paymentReminders;
//   final bool renewalAlerts;
//   final String id;

//   NotificationConfig({
//     required this.loginAlert,
//     required this.passwordChanges,
//     required this.newGroupCreation,
//     required this.groupInvitation,
//     required this.groupMessages,
//     required this.subscriptionUpdates,
//     required this.paymentReminders,
//     required this.renewalAlerts,
//     required this.id,
//   });

//   factory NotificationConfig.fromJson(Map<String, dynamic> json) {
//     return NotificationConfig(
//       loginAlert: json['loginAlert'],
//       passwordChanges: json['passwordChanges'],
//       newGroupCreation: json['newGroupCreation'],
//       groupInvitation: json['groupInvitation'],
//       groupMessages: json['groupMessages'],
//       subscriptionUpdates: json['subscriptionUpdates'],
//       paymentReminders: json['paymentReminders'],
//       renewalAlerts: json['renewalAlerts'],
//       id: json['_id'],
//     );
//   }
//    Map<String, dynamic> toJson() => {
//         "loginAlert": loginAlert,
//         "passwordChanges": passwordChanges,
//         "newGroupCreation": newGroupCreation,
//         "groupInvitation": groupInvitation,
//         "groupMessages": groupMessages,
//         "subscriptionUpdates": subscriptionUpdates,
//         "paymentReminders": paymentReminders,
//         "renewalAlerts": renewalAlerts,
//         "_id": id,
//       };
// }

// MessageResponse  messageResponseFromJson(String str) => MessageResponse.fromJson(json.decode(str));

// String messageResponseToJson(MessageResponse data) => json.encode(data.toJson());
// class MessageResponse {
//   final List<Message> messages;
//   final String nextCursor;
//   final User user;

//   MessageResponse({
//     required this.messages,
//     required this.nextCursor,
//     required this.user,
//   });

//    factory MessageResponse.fromJson(Map<String, dynamic> json) => MessageResponse(
//         messages: List<Message>.from(json["messages"].map((x) => Message.fromJson(x))),
//         nextCursor: json["nextCursor"],
//         user: User.fromJson(json["user"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
//         "nextCursor": nextCursor,
//         "user": user.toJson(),
//     };
// }

class Message {
  final String? id;
  final String? content;
  final Sender? sender;
  final String? group;
  final String? replyTo;
  final List<dynamic> readBy;
  final DateTime? sentAt;

  Message({
    this.id,
    this.content,
    this.sender,
    this.group,
    this.replyTo,
    this.readBy = const [],
    this.sentAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['_id'],
      content: json['content'],
      sender: json['sender'] != null ? Sender.fromJson(json['sender']) : null,
      group: json['group'],
      replyTo: json['replyTo'],
      readBy: json['readBy'] ?? [],
      sentAt: json['sentAt'] != null ? DateTime.parse(json['sentAt']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "content": content,
        "sender": sender?.toJson(),
        "group": group,
        "replyTo": replyTo,
        "readBy": readBy,
        "sentAt": sentAt?.toIso8601String(),
      };
}

class Sender {
  final String? id;
  final String? email;
  final String? username;
  final String? avatarUrl;

  Sender({this.id, this.email, this.username, this.avatarUrl});

  factory Sender.fromJson(Map<String, dynamic> json) {
    return Sender(
        id: json['_id'],
        email: json['email'],
        username: json['username'],
        avatarUrl: json["avatarUrl"]);
  }

  Map<String, dynamic> toJson() =>
      {"_id": id, "email": email, "username": username, "avatarUrl": avatarUrl};
}

class User {
  final String? id;
  final String? email;
  final String? username;
  final String? avatarUrl;
  final bool? verified;
  final String? role;
  final NotificationConfig? notificationConfig;
  final bool? deleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? version;

  User({
    this.id,
    this.email,
    this.username,
    this.avatarUrl,
    this.verified,
    this.role,
    this.notificationConfig,
    this.deleted,
    this.createdAt,
    this.updatedAt,
    this.version,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      email: json['email'],
      username: json['username'],
      avatarUrl: json['avatarUrl'],
      verified: json['verified'],
      role: json['role'],
      notificationConfig: json['notificationConfig'] != null
          ? NotificationConfig.fromJson(json['notificationConfig'])
          : null,
      deleted: json['deleted'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      version: json['__v'],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "username": username,
        "avatarUrl": avatarUrl,
        "verified": verified,
        "role": role,
        "notificationConfig": notificationConfig?.toJson(),
        "deleted": deleted,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": version,
      };
}

class NotificationConfig {
  final bool? loginAlert;
  final bool? passwordChanges;
  final bool? newGroupCreation;
  final bool? groupInvitation;
  final bool? groupMessages;
  final bool? subscriptionUpdates;
  final bool? paymentReminders;
  final bool? renewalAlerts;
  final String? id;

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
      loginAlert: json['loginAlert'],
      passwordChanges: json['passwordChanges'],
      newGroupCreation: json['newGroupCreation'],
      groupInvitation: json['groupInvitation'],
      groupMessages: json['groupMessages'],
      subscriptionUpdates: json['subscriptionUpdates'],
      paymentReminders: json['paymentReminders'],
      renewalAlerts: json['renewalAlerts'],
      id: json['_id'],
    );
  }

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

MessageResponse messageResponseFromJson(String str) =>
    MessageResponse.fromJson(json.decode(str));

String messageResponseToJson(MessageResponse data) =>
    json.encode(data.toJson());

class MessageResponse {
  final List<Message> messages;
  final String? nextCursor;
  final User? user;

  MessageResponse({
    this.messages = const [],
    this.nextCursor,
    this.user,
  });

  factory MessageResponse.fromJson(Map<String, dynamic> json) {
    var messageList = (json['messages'] as List)
        .map((messageJson) => Message.fromJson(messageJson))
        .toList();

    return MessageResponse(
      messages: messageList,
      nextCursor: json['nextCursor'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
        "nextCursor": nextCursor,
        "user": user?.toJson(),
      };
}

//single chat

// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

SingleChat singleChatFromJson(String str) =>
    SingleChat.fromJson(json.decode(str));

String singleChatToJson(SingleChat data) => json.encode(data.toJson());

class SingleChat {
  Message? msg;
  User? user;

  SingleChat({
    this.msg,
    this.user,
  });

  factory SingleChat.fromJson(Map<String, dynamic> json) => SingleChat(
        // Parse the 'msg' and 'user' as individual objects
        msg: json["messages"] != null
            ? Message.fromJson(json["messages"])
            : null,
        user: json["user"] != null ? User.fromJson(json["user"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "messages": msg?.toJson(),
        "user": user?.toJson(),
      };
}

// class Msg {
//   String? content;
//  Sender? sender;
//   String? group;
//   dynamic replyTo;
//   List<dynamic>? readBy;
//   String? id;
//   DateTime? sentAt;
//   int? v;

//   Msg({
//     this.content,
//     this.sender,
//     this.group,
//     this.replyTo,
//     this.readBy,
//     this.id,
//     this.sentAt,
//     this.v,
//   });

//   factory Msg.fromJson(Map<String, dynamic> json) => Msg(
//         content: json["content"],
//         sender: json['sender'] != null ? Sender.fromJson(json['sender']) : null,
//         group: json["group"],
//         replyTo: json["replyTo"],
//         readBy: json["readBy"] != null
//             ? List<dynamic>.from(json["readBy"].map((x) => x))
//             : [],
//         id: json["_id"],
//         sentAt: json["sentAt"] != null ? DateTime.parse(json["sentAt"]) : null,
//         v: json["__v"],
//       );

//   Map<String, dynamic> toJson() => {
//         "content": content,
//          "sender": sender?.toJson(),
//         "group": group,
//         "replyTo": replyTo,
//         "readBy":
//             readBy != null ? List<dynamic>.from(readBy!.map((x) => x)) : [],
//         "_id": id,
//         "sentAt": sentAt?.toIso8601String(),
//         "__v": v,
//       };
// }
