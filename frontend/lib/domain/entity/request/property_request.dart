class PropertyRequest {
  String? propertyName;
  String? propertyType;
  String? location;
  int? sizeSqFt;
  int? price;
  int? noOfBedrooms;
  int? noOfBathrooms;

  PropertyRequest({
    this.propertyName,
    this.propertyType,
    this.location,
    this.sizeSqFt,
    this.price,
    this.noOfBedrooms,
    this.noOfBathrooms,
  });

  // Factory method to create an instance from a JSON map
  factory PropertyRequest.fromJson(Map<String, dynamic> json) {
    return PropertyRequest(
      propertyName: json['propertyName'] as String?,
      propertyType: json['propertyType'] as String?,
      location: json['location'] as String?,
      sizeSqFt: json['sizeSqFt'] as int?,
      price: json['price'] as int?,
      noOfBedrooms: json['noOfBedrooms'] as int?,
      noOfBathrooms: json['noOfBathrooms'] as int?,
    );
  }

  // Method to convert the instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
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