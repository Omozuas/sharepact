class SubmembersModel {
  String? user;
  String? subscriptionStatus;
  bool? confirmStatus;
  String? id;

  SubmembersModel({
    this.user,
    this.subscriptionStatus,
    this.confirmStatus,
    this.id,
  });

  factory SubmembersModel.fromJson(Map<String, dynamic> json) =>
      SubmembersModel(
        user: json["user"],
        subscriptionStatus: json["subscriptionStatus"],
        confirmStatus: json["confirmStatus"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "subscriptionStatus": subscriptionStatus,
        "confirmStatus": confirmStatus,
        "_id": id,
      };
}
