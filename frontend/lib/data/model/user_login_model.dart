import 'package:dashboard/domain/entity/response/user_login_entity.dart';

class LoginModel extends Login {
  LoginModel({
    required String email,
    String? password,
    required String tokens,
    required String userRole,
  }) : super(
          email: email,
          password: password,
          tokens: tokens,
          userRole: userRole,
        );

  // Factory method to create LoginModel from JSON
  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      email: json['email'],
      password: json['password'],
      tokens: json['tokens'],
      userRole: json['userRole'],
    );
  }

  // Method to convert LoginModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'tokens': tokens,
      'userRole': userRole,
    };
  }
}
