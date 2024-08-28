class ServiceModel {
  String? id;
  String? serviceName;
  String? logoUrl;

  ServiceModel({
    this.id,
    this.serviceName,
    this.logoUrl,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
        id: json["_id"],
        serviceName: json["serviceName"],
        logoUrl: json["logoUrl"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "serviceName": serviceName,
        "logoUrl": logoUrl,
      };
}
