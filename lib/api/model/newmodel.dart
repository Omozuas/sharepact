// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CustomException implements Exception {
  final int code;
  final String? message;

  CustomException({
    required this.code,
    this.message,
  });

  CustomException copyWith({
    int? code,
    String? message,
  }) {
    return CustomException(
      code: code ?? this.code,
      message: message ?? this.message,
    );
  }

  @override
  String toString() => 'CustomException(code: $code, message: $message)';

  @override
  bool operator ==(covariant CustomException other) {
    if (identical(this, other)) return true;

    return other.code == code && other.message == message;
  }

  @override
  int get hashCode => code.hashCode ^ message.hashCode;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'message': message,
    };
  }

  factory CustomException.fromMap(Map<String, dynamic> map) {
    return CustomException(
      code: map['code'] as int,
      message: map['message'] != null ? map['message'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomException.fromJson(String source) =>
      CustomException.fromMap(json.decode(source) as Map<String, dynamic>);
}
