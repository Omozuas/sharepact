class NotificationBody {
  String? subject;
  String? type;
  User? user;
  String? notificationMessage;
  String? name;

  NotificationBody({
    this.subject,
    this.type,
    this.user,
    this.notificationMessage,
    this.name,
  });

  factory NotificationBody.fromJson(Map<String, dynamic> json) {
    return NotificationBody(
      subject: json['subject'] as String?,
      type: json['type'] as String?,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      notificationMessage: json['notificationMessage'] as String?,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subject': subject,
      'type': type,
      'user': user?.toJson(),
      'notificationMessage': notificationMessage,
      'name': name,
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
