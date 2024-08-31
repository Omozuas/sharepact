// ignore_for_file: public_member_api_docs, sort_constructors_first
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

  ServiceModel copyWith({
    String? id,
    String? serviceName,
    String? logoUrl,
  }) {
    return ServiceModel(
      id: id ?? this.id,
      serviceName: serviceName ?? this.serviceName,
      logoUrl: logoUrl ?? this.logoUrl,
    );
  }

  @override
  String toString() =>
      'ServiceModel(id: $id, serviceName: $serviceName, logoUrl: $logoUrl)';

  @override
  bool operator ==(covariant ServiceModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.serviceName == serviceName &&
        other.logoUrl == logoUrl;
  }

  @override
  int get hashCode => id.hashCode ^ serviceName.hashCode ^ logoUrl.hashCode;
}
