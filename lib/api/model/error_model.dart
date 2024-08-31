import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Errors {
  List<String>? email;
  List<String>? password;

  Errors({
    this.email,
    this.password,
  });

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
        email: json["email"] != null
            ? List<String>.from(json["email"].map((x) => x))
            : null,
        password: json["password"] != null
            ? List<String>.from(json["password"].map((x) => x))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "email":
            email != null ? List<dynamic>.from(email!.map((x) => x)) : null,
        "password": password != null
            ? List<dynamic>.from(password!.map((x) => x))
            : null,
      };

  Errors copyWith({
    List<String>? email,
    List<String>? password,
  }) {
    return Errors(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  String toString() => 'Errors(email: $email, password: $password)';

  @override
  bool operator ==(covariant Errors other) {
    if (identical(this, other)) return true;

    return listEquals(other.email, email) &&
        listEquals(other.password, password);
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode;
}
