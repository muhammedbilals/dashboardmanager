class Property {
  int? id;
  String? propertyName;
  String? propertyType;
  String? location;
  int? sizeSqFt;
  int? price;
  int? noOfBedrooms;
  int? noOfBathrooms;

  Property({
    this.id,
    this.propertyName,
    this.propertyType,
    this.location,
    this.sizeSqFt,
    this.price,
    this.noOfBedrooms,
    this.noOfBathrooms,
  });

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      id: json['id'] as int?,
      propertyName: json['propertyName'] as String?,
      propertyType: json['propertyType'] as String?,
      location: json['location'] as String?,
      sizeSqFt: json['sizeSqFt'] as int?,
      price: json['price'] as int?,
      noOfBedrooms: json['noOfBedrooms'] as int?,
      noOfBathrooms: json['noOfBathrooms'] as int?,
    );
  }

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