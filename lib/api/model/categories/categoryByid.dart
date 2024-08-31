// // ignore_for_file: public_member_api_docs, sort_constructors_first

// import 'package:flutter/foundation.dart';

// import 'package:sharepact_app/api/model/categories/listOfCategories.dart';
// import 'dart:convert';

// CategorybyidResponsModel categorybyidResponsModelFromJson(String str) =>
//     CategorybyidResponsModel.fromJson(json.decode(str));

// String categorybyidResponsModelToJson(CategorybyidResponsModel data) =>
//     json.encode(data.toJson());

// class CategorybyidResponsModel {
//   int? code;
//   String? message;
//   CategorybyidModel? data;

//   CategorybyidResponsModel({
//     this.code,
//     this.message,
//     this.data,
//   });

//   factory CategorybyidResponsModel.fromJson(Map<String, dynamic> json) =>

//       CategorybyidResponsModel(
//         code: json["code"],
//         message: json["message"],
//         data: CategorybyidModel.fromJson(json["data"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "code": code,
//         "message": message,
//         "data": data?.toJson(),
//       };
// }

// class CategorybyidModel {
//   CategoriesModel? category;
//   List<ServiceDetailsModel>? services;

//   CategorybyidModel({
//     this.category,
//     this.services,
//   });

//   factory CategorybyidModel.fromJson(Map<String, dynamic> json) =>
//       CategorybyidModel(
//         category: CategoriesModel?.fromJson(json["category"]),
//         services: List<ServiceDetailsModel>.from(
//             json["services"].map((x) => ServiceDetailsModel.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "category": category?.toJson(),
//         "services": List<dynamic>.from(services!.map((x) => x.toJson())),
//       };

//   CategorybyidModel copyWith({
//     CategoriesModel? category,
//     List<ServiceDetailsModel>? services,
//   }) {
//     return CategorybyidModel(
//       category: category ?? this.category,
//       services: services ?? this.services,
//     );
//   }

//   @override
//   String toString() =>
//       'CategorybyidModel(category: $category, services: $services)';

//   @override
//   bool operator ==(covariant CategorybyidModel other) {
//     if (identical(this, other)) return true;

//     return other.category == category && listEquals(other.services, services);
//   }

//   @override
//   int get hashCode => category.hashCode ^ services.hashCode;
// }

// class ServiceDetailsModel {
//   String? id;
//   String? serviceName;
//   String? serviceDescription;
//   List<SubscriptionPlan>? subscriptionPlans;
//   String? currency;
//   int? handlingFees;
//   String? logoUrl;
//   String? categoryId;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   int? v;

//   ServiceDetailsModel({
//     this.id,
//     this.serviceName,
//     this.serviceDescription,
//     this.subscriptionPlans,
//     this.currency,
//     this.handlingFees,
//     this.logoUrl,
//     this.categoryId,
//     this.createdAt,
//     this.updatedAt,
//     this.v,
//   });

//   factory ServiceDetailsModel.fromJson(Map<String, dynamic> json) =>
//       ServiceDetailsModel(
//         id: json["_id"],
//         serviceName: json["serviceName"],
//         serviceDescription: json["serviceDescription"],
//         subscriptionPlans: List<SubscriptionPlan>.from(
//             json["subscriptionPlans"].map((x) => SubscriptionPlan.fromJson(x))),
//         currency: json["currency"],
//         handlingFees: json["handlingFees"],
//         logoUrl: json["logoUrl"],
//         categoryId: json["categoryId"],
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "serviceName": serviceName,
//         "serviceDescription": serviceDescription,
//         "subscriptionPlans":
//             List<dynamic>.from(subscriptionPlans!.map((x) => x.toJson())),
//         "currency": currency,
//         "handlingFees": handlingFees,
//         "logoUrl": logoUrl,
//         "categoryId": categoryId,
//         "createdAt": createdAt?.toIso8601String(),
//         "updatedAt": updatedAt?.toIso8601String(),
//         "__v": v,
//       };

//   ServiceDetailsModel copyWith({
//     String? id,
//     String? serviceName,
//     String? serviceDescription,
//     List<SubscriptionPlan>? subscriptionPlans,
//     String? currency,
//     int? handlingFees,
//     String? logoUrl,
//     String? categoryId,
//     DateTime? createdAt,
//     DateTime? updatedAt,
//     int? v,
//   }) {
//     return ServiceDetailsModel(
//       id: id ?? this.id,
//       serviceName: serviceName ?? this.serviceName,
//       serviceDescription: serviceDescription ?? this.serviceDescription,
//       subscriptionPlans: subscriptionPlans ?? this.subscriptionPlans,
//       currency: currency ?? this.currency,
//       handlingFees: handlingFees ?? this.handlingFees,
//       logoUrl: logoUrl ?? this.logoUrl,
//       categoryId: categoryId ?? this.categoryId,
//       createdAt: createdAt ?? this.createdAt,
//       updatedAt: updatedAt ?? this.updatedAt,
//       v: v ?? this.v,
//     );
//   }

//   @override
//   String toString() {
//     return 'ServiceDetailsModel(id: $id, serviceName: $serviceName, serviceDescription: $serviceDescription, subscriptionPlans: $subscriptionPlans, currency: $currency, handlingFees: $handlingFees, logoUrl: $logoUrl, categoryId: $categoryId, createdAt: $createdAt, updatedAt: $updatedAt, v: $v)';
//   }

//   @override
//   bool operator ==(covariant ServiceDetailsModel other) {
//     if (identical(this, other)) return true;

//     return other.id == id &&
//         other.serviceName == serviceName &&
//         other.serviceDescription == serviceDescription &&
//         listEquals(other.subscriptionPlans, subscriptionPlans) &&
//         other.currency == currency &&
//         other.handlingFees == handlingFees &&
//         other.logoUrl == logoUrl &&
//         other.categoryId == categoryId &&
//         other.createdAt == createdAt &&
//         other.updatedAt == updatedAt &&
//         other.v == v;
//   }

//   @override
//   int get hashCode {
//     return id.hashCode ^
//         serviceName.hashCode ^
//         serviceDescription.hashCode ^
//         subscriptionPlans.hashCode ^
//         currency.hashCode ^
//         handlingFees.hashCode ^
//         logoUrl.hashCode ^
//         categoryId.hashCode ^
//         createdAt.hashCode ^
//         updatedAt.hashCode ^
//         v.hashCode;
//   }
// }

// class SubscriptionPlan {
//   PlanName? planName;
//   List<Description>? description;
//   int? price;

//   SubscriptionPlan({
//     this.planName,
//     this.description,
//     this.price,
//   });

//   factory SubscriptionPlan.fromJson(Map<String, dynamic> json) =>
//       SubscriptionPlan(
//         planName: planNameValues.map[json["planName"]],
//         description: List<Description>.from(
//             json["description"].map((x) => descriptionValues.map[x])),
//         price: json["price"],
//       );

//   Map<String, dynamic> toJson() => {
//         "planName": planNameValues.reverse[planName],
//         "description": List<dynamic>.from(
//             description!.map((x) => descriptionValues.reverse[x])),
//         "price": price,
//       };

//   SubscriptionPlan copyWith({
//     PlanName? planName,
//     List<Description>? description,
//     int? price,
//   }) {
//     return SubscriptionPlan(
//       planName: planName ?? this.planName,
//       description: description ?? this.description,
//       price: price ?? this.price,
//     );
//   }

//   @override
//   String toString() =>
//       'SubscriptionPlan(planName: $planName, description: $description, price: $price)';

//   @override
//   bool operator ==(covariant SubscriptionPlan other) {
//     if (identical(this, other)) return true;

//     return other.planName == planName &&
//         listEquals(other.description, description) &&
//         other.price == price;
//   }

//   @override
//   int get hashCode => planName.hashCode ^ description.hashCode ^ price.hashCode;
// }

// enum Description {
//   // ignore: constant_identifier_names
//   CUSTOMIZABLE,
//   // ignore: constant_identifier_names
//   FAST,
//   // ignore: constant_identifier_names
//   FASTER,
//   // ignore: constant_identifier_names
//   FREE_OF_ADS,
//   // ignore: constant_identifier_names
//   PRIORITY_SUPPORT
// }

// final descriptionValues = EnumValues({
//   "Customizable": Description.CUSTOMIZABLE,
//   "Fast": Description.FAST,
//   "Faster": Description.FASTER,
//   "Free of ads": Description.FREE_OF_ADS,
//   "Priority support": Description.PRIORITY_SUPPORT
// });

// enum PlanName {
//   // ignore: constant_identifier_names
//   PREMIUM,
//   // ignore: constant_identifier_names
//   STANDARD
// }

// final planNameValues =
//     EnumValues({"Premium": PlanName.PREMIUM, "Standard": PlanName.STANDARD});

// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }

// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

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
  List<SubscriptionPlan>? subscriptionPlans;
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
    this.subscriptionPlans,
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
        subscriptionPlans: List<SubscriptionPlan>.from(
            json["subscriptionPlans"].map((x) => SubscriptionPlan.fromJson(x))),
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
        "subscriptionPlans":
            List<dynamic>.from(subscriptionPlans!.map((x) => x.toJson())),
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
  PlanName? planName;
  List<Description>? description;
  int? price;

  SubscriptionPlan({
    this.planName,
    this.description,
    this.price,
  });

  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) =>
      SubscriptionPlan(
        planName: planNameValues.map[json["planName"]],
        description: List<Description>.from(
            json["description"].map((x) => descriptionValues.map[x])),
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "planName": planNameValues.reverse[planName],
        "description": List<dynamic>.from(
            description!.map((x) => descriptionValues.reverse[x])),
        "price": price,
      };
}

enum Description { CUSTOMIZABLE, FAST, FASTER, FREE_OF_ADS, PRIORITY_SUPPORT }

final descriptionValues = EnumValues({
  "Customizable": Description.CUSTOMIZABLE,
  "Fast": Description.FAST,
  "Faster": Description.FASTER,
  "Free of ads": Description.FREE_OF_ADS,
  "Priority support": Description.PRIORITY_SUPPORT
});

enum PlanName { PREMIUM, STANDARD }

final planNameValues =
    EnumValues({"Premium": PlanName.PREMIUM, "Standard": PlanName.STANDARD});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
