import 'package:dashboard/domain/entity/response/user_registration_entity.dart';

class UserRegistrationModel extends UserRegistration {

  

  UserRegistrationModel({
    String? email,
    String? password,
    String? tokens,
  }) : super(
          email: email ,
          password: password ?? 'defaultPassword',
          tokens: tokens ,
        );

  // Factory constructor to create a UserRegistrationModel instance from JSON
  factory UserRegistrationModel.fromJson(Map<String, dynamic> json) {
    return UserRegistrationModel(
      email: json['email'] as String?,
      password: json['password'] as String? ?? 'defaultPassword',
      tokens: json['tokens'] as String? ,
    );
  }

}