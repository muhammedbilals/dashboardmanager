import 'package:dashboard/domain/entity/response/user_login_entity.dart';

class ExtendedLoginModel extends Login {
  bool? rememberMe;

  ExtendedLoginModel({
    super.email,
    super.password,
    this.rememberMe,
  });

  // Factory method to handle JSON conversion, including the new field
  factory ExtendedLoginModel.fromJson(Map<String, dynamic> json) {
    return ExtendedLoginModel(
      email: json['email'] as String?,
      password: json['password'] as String?,
      rememberMe: json['rememberMe'] as bool?,
    );
  }

  // Overriding the toJson method to include new fields
  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data['rememberMe'] = rememberMe;
    return data;
  }

  // Overriding the validation method to include the new field's validation
  @override
  Map<String, String?> validate() {
    Map<String, String?> errors = super.validate();

    if (rememberMe == null) {
      errors['rememberMe'] = 'Remember me option is required';
    }

    return errors;
  }
}