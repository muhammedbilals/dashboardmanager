import 'package:dashboard/domain/entity/response/user_registration_entity.dart';

class UserRegistrationModel extends UserRegistration {
  String? address;
  String? country;

  UserRegistrationModel({
    super.firstName,
    super.lastName,
    super.email,
    super.mobileNumber,
    super.password,
    super.confirmPassword,
    this.address,
    this.country,
  });

  // Override the factory constructor to include new fields
  factory UserRegistrationModel.fromJson(Map<String, dynamic> json) {
    return UserRegistrationModel(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      mobileNumber: json['mobileNumber'] as String?,
      password: json['password'] as String?,
      confirmPassword: json['confirmPassword'] as String?,
      address: json['address'] as String?,
      country: json['country'] as String?,
    );
  }

  // Override the toJson method to include new fields
  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data.addAll({
      'address': address,
      'country': country,
    });
    return data;
  }

  // Override the validation method to add validation for the new fields
  @override
  Map<String, String?> validate() {
    Map<String, String?> errors = super.validate();

    if (address == null || address!.isEmpty) {
      errors['address'] = 'Address is required';
    }

    if (country == null || country!.isEmpty) {
      errors['country'] = 'Country is required';
    }

    return errors;
  }
}