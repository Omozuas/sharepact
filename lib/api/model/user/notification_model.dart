// ignore_for_file: public_member_api_docs, sort_constructors_first
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

  NotificationConfig copyWith({
    bool? loginAlert,
    bool? passwordChanges,
    bool? newGroupCreation,
    bool? groupInvitation,
    bool? groupMessages,
    bool? subscriptionUpdates,
    bool? paymentReminders,
    bool? renewalAlerts,
    String? id,
  }) {
    return NotificationConfig(
      loginAlert: loginAlert ?? this.loginAlert,
      passwordChanges: passwordChanges ?? this.passwordChanges,
      newGroupCreation: newGroupCreation ?? this.newGroupCreation,
      groupInvitation: groupInvitation ?? this.groupInvitation,
      groupMessages: groupMessages ?? this.groupMessages,
      subscriptionUpdates: subscriptionUpdates ?? this.subscriptionUpdates,
      paymentReminders: paymentReminders ?? this.paymentReminders,
      renewalAlerts: renewalAlerts ?? this.renewalAlerts,
      id: id ?? this.id,
    );
  }

  @override
  String toString() {
    return 'NotificationConfig(loginAlert: $loginAlert, passwordChanges: $passwordChanges, newGroupCreation: $newGroupCreation, groupInvitation: $groupInvitation, groupMessages: $groupMessages, subscriptionUpdates: $subscriptionUpdates, paymentReminders: $paymentReminders, renewalAlerts: $renewalAlerts, id: $id)';
  }

  @override
  bool operator ==(covariant NotificationConfig other) {
    if (identical(this, other)) return true;

    return other.loginAlert == loginAlert &&
        other.passwordChanges == passwordChanges &&
        other.newGroupCreation == newGroupCreation &&
        other.groupInvitation == groupInvitation &&
        other.groupMessages == groupMessages &&
        other.subscriptionUpdates == subscriptionUpdates &&
        other.paymentReminders == paymentReminders &&
        other.renewalAlerts == renewalAlerts &&
        other.id == id;
  }

  @override
  int get hashCode {
    return loginAlert.hashCode ^
        passwordChanges.hashCode ^
        newGroupCreation.hashCode ^
        groupInvitation.hashCode ^
        groupMessages.hashCode ^
        subscriptionUpdates.hashCode ^
        paymentReminders.hashCode ^
        renewalAlerts.hashCode ^
        id.hashCode;
  }
}
