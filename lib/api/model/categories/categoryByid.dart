import 'dart:convert';

CategorybyidResponsModel categorybyidResponsModelFromJson(String str) =>
    CategorybyidResponsModel.fromJson(json.decode(str));

String welcomeToJson(CategorybyidResponsModel data) =>
    json.encode(data.toJson());

class CategorybyidResponsModel {
  int? code;
  String? message;
  Data? data;

  CategorybyidResponsModel({
    this.code,
    this.message,
    this.data,
  });

  factory CategorybyidResponsModel.fromJson(Map<String, dynamic> json) =>
      CategorybyidResponsModel(
        code: json["code"],
        message: json["message"],
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  Category? category;
  List<Service>? services;

  Data({
    this.category,
    this.services,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        category: json["category"] != null
            ? Category.fromJson(json["category"])
            : null,
        services: json["services"] != null
            ? List<Service>.from(
                json["services"].map((x) => Service.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "category": category?.toJson(),
        "services": List<dynamic>.from(services!.map((x) => x.toJson())),
      };
}

class Category {
  String? id;
  String? categoryName;
  String? imageUrl;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Category({
    this.id,
    this.categoryName,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["_id"],
        categoryName: json["categoryName"],
        imageUrl: json["imageUrl"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "categoryName": categoryName,
        "imageUrl": imageUrl,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class Service {
  String? id;
  String? serviceName;
  String? serviceDescription;
  String? currency;
  int? handlingFees;
  String? logoUrl;
  String? categoryId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Service({
    this.id,
    this.serviceName,
    this.serviceDescription,
    this.currency,
    this.handlingFees,
    this.logoUrl,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["_id"],
        serviceName: json["serviceName"],
        serviceDescription: json["serviceDescription"],
        currency: json["currency"],
        handlingFees: json["handlingFees"],
        logoUrl: json["logoUrl"],
        categoryId: json["categoryId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "serviceName": serviceName,
        "serviceDescription": serviceDescription,
        "currency": currency,
        "handlingFees": handlingFees,
        "logoUrl": logoUrl,
        "categoryId": categoryId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
