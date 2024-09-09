import 'dart:convert';

NotificationModdel notificationModdelFromJson(String str) =>
    NotificationModdel.fromJson(json.decode(str));

String notificationModdelToJson(NotificationModdel data) =>
    json.encode(data.toJson());

class NotificationModdel {
  int? code;
  String? message;
  List<Datum>? data;

  NotificationModdel({
    this.code,
    this.message,
    this.data,
  });

  // Modified fromJson to handle null data and return an empty list if data is null
  factory NotificationModdel.fromJson(Map<String, dynamic> json) =>
      NotificationModdel(
        code: json["code"],
        message: json["message"],
        data: json["data"] != null
            ? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x)))
            : [], // Return empty list if data is null
      );

  // Modified toJson to handle null data and avoid calling .map() on null
  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data != null
            ? List<dynamic>.from(data!.map((x) => x.toJson()))
            : [], // Return empty list if data is null
      };
}

class Datum {
  String? id;
  String? subject;
  String? textContent;
  String? htmlContent;
  String? user;
  bool? read;
  DateTime? createdAt;
  int? v;

  Datum({
    this.id,
    this.subject,
    this.textContent,
    this.htmlContent,
    this.user,
    this.read,
    this.createdAt,
    this.v,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        subject: json["subject"],
        textContent: json["textContent"],
        htmlContent: json["htmlContent"],
        user: json["user"],
        read: json["read"],
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : null, // Handle null createdAt
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "subject": subject,
        "textContent": textContent,
        "htmlContent": htmlContent,
        "user": user,
        "read": read,
        "createdAt": createdAt?.toIso8601String(),
        "__v": v,
      };
}
