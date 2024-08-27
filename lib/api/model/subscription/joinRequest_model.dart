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
