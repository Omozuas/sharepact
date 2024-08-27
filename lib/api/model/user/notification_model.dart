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

  factory NotificationConfig.fromJson(Map<String, dynamic> json) =>
      NotificationConfig(
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
