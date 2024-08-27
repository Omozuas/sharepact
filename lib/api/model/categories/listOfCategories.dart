class CategoriesModel {
  String? id;
  String? categoryName;
  String? imageUrl;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  CategoriesModel({
    this.id,
    this.categoryName,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      CategoriesModel(
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
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
      };
}
