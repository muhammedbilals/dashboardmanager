import 'package:dashboard/domain/entity/response/property_entity.dart';

class PropertyModel extends Property {
  PropertyModel({
    required int id,
    required String propertyName,
    required String propertyType,
    required String location,
    required int sizeSqFt,
    required int price,
    required int noOfBedrooms,
    required int noOfBathrooms,
  }) : super(
          id: id,
          propertyName: propertyName,
          propertyType: propertyType,
          location: location,
          sizeSqFt: sizeSqFt,
          price: price,
          noOfBedrooms: noOfBedrooms,
          noOfBathrooms: noOfBathrooms,
        );

  // Factory method to create a PropertyModel from JSON
  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    return PropertyModel(
      id: json['id'],
      propertyName: json['propertyName'],
      propertyType: json['propertyType'],
      location: json['location'],
      sizeSqFt: json['sizeSqFt'],
      price: json['price'],
      noOfBedrooms: json['noOfBedrooms'],
      noOfBathrooms: json['noOfBathrooms'],
    );
  }

  // Method to convert PropertyModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'propertyName': propertyName,
      'propertyType': propertyType,
      'location': location,
      'sizeSqFt': sizeSqFt,
      'price': price,
      'noOfBedrooms': noOfBedrooms,
      'noOfBathrooms': noOfBathrooms,
    };
  }
}
