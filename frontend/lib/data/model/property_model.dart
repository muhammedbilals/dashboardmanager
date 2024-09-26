import 'package:dashboard/domain/entity/response/property_entity.dart';

class ResidentialProperty extends Property {
  String? neighborhood;
  bool? hasGarage;
  bool? hasGarden;

  ResidentialProperty({
    super.id,
    super.propertyName,
    super.propertyType,
    super.location,
    super.sizeSqFt,
    super.price,
    super.noOfBedrooms,
    super.noOfBathrooms,
    this.neighborhood,
    this.hasGarage,
    this.hasGarden,
  });

  // Override the factory constructor to include new fields
  factory ResidentialProperty.fromJson(Map<String, dynamic> json) {
    return ResidentialProperty(
      id: json['id'] as int?,
      propertyName: json['propertyName'] as String?,
      propertyType: json['propertyType'] as String?,
      location: json['location'] as String?,
      sizeSqFt: json['sizeSqFt'] as int?,
      price: json['price'] as int?,
      noOfBedrooms: json['noOfBedrooms'] as int?,
      noOfBathrooms: json['noOfBathrooms'] as int?,
      neighborhood: json['neighborhood'] as String?,
      hasGarage: json['hasGarage'] as bool?,
      hasGarden: json['hasGarden'] as bool?,
    );
  }

  // Override toJson to include new fields
  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data.addAll({
      'neighborhood': neighborhood,
      'hasGarage': hasGarage,
      'hasGarden': hasGarden,
    });
    return data;
  }
}