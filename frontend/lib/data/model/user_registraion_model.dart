import 'package:dashboard/domain/entity/response/user_registration_entity.dart';

class UserRegistrationModel extends UserRegistration {

  

  UserRegistrationModel({
    String? email,
    String? password,
    String? tokens,
    String? userRole
  }) : super(
          email: email ,
          password: password ?? "",
          tokens: tokens ,
          userRole: userRole
        );


  factory UserRegistrationModel.fromJson(Map<String, dynamic> json) {
    return UserRegistrationModel(
      email: json['email'] as String?,
      password: json['password'] as String? ?? "",
      tokens: json['tokens'] as String? ,
      userRole: json['userRole'] as String?
    );
  }

}