class Property {
  final int id;
  final String propertyName;
  final String propertyType;
  final String location;
  final int sizeSqFt;
  final int price;
  final int noOfBedrooms;
  final int noOfBathrooms;

  Property({
    required this.id,
    required this.propertyName,
    required this.propertyType,
    required this.location,
    required this.sizeSqFt,
    required this.price,
    required this.noOfBedrooms,
    required this.noOfBathrooms,
  });
}
