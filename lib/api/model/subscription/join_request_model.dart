// ignore_for_file: public_member_api_docs, sort_constructors_first
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

  @override
  String toString() => 'JoinRequest(user: $user, message: $message, id: $id)';

  @override
  bool operator ==(covariant JoinRequest other) {
    if (identical(this, other)) return true;

    return other.user == user && other.message == message && other.id == id;
  }

  @override
  int get hashCode => user.hashCode ^ message.hashCode ^ id.hashCode;

  JoinRequest copyWith({
    String? user,
    String? message,
    String? id,
  }) {
    return JoinRequest(
      user: user ?? this.user,
      message: message ?? this.message,
      id: id ?? this.id,
    );
  }
}
