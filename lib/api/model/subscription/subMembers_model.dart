// ignore_for_file: public_member_api_docs, sort_constructors_first
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

  @override
  String toString() {
    return 'SubmembersModel(user: $user, subscriptionStatus: $subscriptionStatus, confirmStatus: $confirmStatus, id: $id)';
  }

  @override
  bool operator ==(covariant SubmembersModel other) {
    if (identical(this, other)) return true;

    return other.user == user &&
        other.subscriptionStatus == subscriptionStatus &&
        other.confirmStatus == confirmStatus &&
        other.id == id;
  }

  @override
  int get hashCode {
    return user.hashCode ^
        subscriptionStatus.hashCode ^
        confirmStatus.hashCode ^
        id.hashCode;
  }

  SubmembersModel copyWith({
    String? user,
    String? subscriptionStatus,
    bool? confirmStatus,
    String? id,
  }) {
    return SubmembersModel(
      user: user ?? this.user,
      subscriptionStatus: subscriptionStatus ?? this.subscriptionStatus,
      confirmStatus: confirmStatus ?? this.confirmStatus,
      id: id ?? this.id,
    );
  }
}
