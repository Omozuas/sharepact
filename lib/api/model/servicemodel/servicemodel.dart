import 'dart:convert';

SingleServiceResponsModel singleServiceResponsModelFromJson(String str) =>
    SingleServiceResponsModel.fromJson(json.decode(str));

String singleServiceResponsModelToJson(SingleServiceResponsModel data) =>
    json.encode(data.toJson());

class SingleServiceResponsModel {
  int? code;
  String? message;
  SingleService? data;

  SingleServiceResponsModel({
    this.code,
    this.message,
    this.data,
  });

  factory SingleServiceResponsModel.fromJson(Map<String, dynamic> json) =>
      SingleServiceResponsModel(
        code: json["code"],
        message: json["message"],
        data:
            json["data"] != null ? SingleService.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data?.toJson(),
      };
}

class SingleService {
  String? id;
  String? serviceName;
  String? serviceDescription;
  List<SubscriptionPlan>? subscriptionPlans;
  String? currency;
  int? handlingFees;
  String? logoUrl;
  String? categoryId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  SingleService({
    this.id,
    this.serviceName,
    this.serviceDescription,
    this.subscriptionPlans,
    this.currency,
    this.handlingFees,
    this.logoUrl,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory SingleService.fromJson(Map<String, dynamic> json) => SingleService(
        id: json["_id"],
        serviceName: json["serviceName"],
        serviceDescription: json["serviceDescription"],
        subscriptionPlans: json["subscriptionPlans"] != null
            ? List<SubscriptionPlan>.from(json["subscriptionPlans"]
                .map((x) => SubscriptionPlan.fromJson(x)))
            : [],
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
        "subscriptionPlans": subscriptionPlans != null
            ? List<dynamic>.from(subscriptionPlans!.map((x) => x.toJson()))
            : [],
        "currency": currency,
        "handlingFees": handlingFees,
        "logoUrl": logoUrl,
        "categoryId": categoryId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class SubscriptionPlan {
  SubscriptionPlan({
    required this.planName,
    required this.description,
    required this.price,
  });

  String? planName;
  List<String>? description;
  int? price;

  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) =>
      SubscriptionPlan(
        planName: json["planName"],
        description: List<String>.from(json["description"].map((x) => x)),
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "planName": planName,
        "description": List<dynamic>.from(description!.map((x) => x)),
        "price": price,
      };
}
