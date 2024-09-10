import 'dart:convert';

GetAllBanks getAllBanksFromJson(String str) =>
    GetAllBanks.fromJson(json.decode(str));

String getAllBanksToJson(GetAllBanks data) => json.encode(data.toJson());

class GetAllBanks {
  int? code;
  String? message;
  List<Datum>? data;

  GetAllBanks({
    this.code,
    this.message,
    this.data,
  });

  factory GetAllBanks.fromJson(Map<String, dynamic> json) => GetAllBanks(
        code: json["code"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  int? id;
  String? code;
  String? name;

  Datum({
    this.id,
    this.code,
    this.name,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        code: json["code"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
      };
}
