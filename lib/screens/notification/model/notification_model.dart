// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

enum NotificationType { Login, Password, Group, Invitation, Message, Payment }

class NotificationModel {
  bool isNew;
  String icon;
  String title;
  String time;
  NotificationType? type;
  NotificationModel({
    required this.isNew,
    required this.icon,
    required this.title,
    required this.time,
    required this.type,
  });

  NotificationModel copyWith({
    bool? isNew,
    String? icon,
    String? title,
    String? time,
    NotificationType? type,
  }) {
    return NotificationModel(
      isNew: isNew ?? this.isNew,
      icon: icon ?? this.icon,
      title: title ?? this.title,
      time: time ?? this.time,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isNew': isNew,
      'icon': icon,
      'title': title,
      'time': time,
      // 'type': type.toMap(),
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      isNew: map['isNew'] as bool,
      icon: map['icon'] as String,
      title: map['title'] as String,
      time: map['time'] as String,
      type: map['type'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NotificationModel(isNew: $isNew, icon: $icon, title: $title, time: $time, type: $type)';
  }

  @override
  bool operator ==(covariant NotificationModel other) {
    if (identical(this, other)) return true;

    return other.isNew == isNew &&
        other.icon == icon &&
        other.title == title &&
        other.time == time &&
        other.type == type;
  }

  @override
  int get hashCode {
    return isNew.hashCode ^
        icon.hashCode ^
        title.hashCode ^
        time.hashCode ^
        type.hashCode;
  }
}
