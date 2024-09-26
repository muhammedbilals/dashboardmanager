import 'dart:convert';
import 'dart:developer';
import 'package:dashboard/core/error/failures.dart';
import 'package:dashboard/domain/entity/request/login_request.dart';
import 'package:dashboard/domain/entity/request/registration_request.dart';
import 'package:dashboard/domain/entity/response/user_login_entity.dart';
import 'package:dashboard/domain/entity/response/user_registration_entity.dart';
import 'package:http/http.dart' as http;

abstract class AuthApiRemoteDataSource {
  Future<Login> loginWithApi({required LoginRequest logInRequest});
  Future<UserRegistration> signUpWithApi({required RegistraionRequest signUpRequest});
}

class AuthApiRemoteDataSourceImpl implements AuthApiRemoteDataSource {
  final http.Client httpClient;

  AuthApiRemoteDataSourceImpl({required this.httpClient});

  @override
  Future<Login> loginWithApi({required LoginRequest logInRequest}) async {
    var headers = {
      "Content-Type": "application/json",
      "calling_entity": "WEB_UI"
    };
    var body = {"email": logInRequest.email, "password": logInRequest.password};

    final url =
        Uri.parse('https://partnerapi.megmo.in/partner-service/login/login/v2');
    final response =
        await httpClient.post(url, headers: headers, body: jsonEncode(body));
    final decodedBody = json.decode(response.body);
    if (response.statusCode == 200) {
      log(decodedBody.toString());
      return Login.fromJson(decodedBody);
    } else {
      log(decodedBody['message']);

      throw ServerFailure(errorMessage: decodedBody['message']);
    }
  }

  @override
  Future<UserRegistration> signUpWithApi(
      {required RegistraionRequest signUpRequest}) async {
    var headers = {
      "Content-Type": "application/json",
      "calling_entity": "WEB_UI"
    };
    

    final url = Uri.parse(
        'https://partnerapi.megmo.in/partner-service/login/register/v2');
    final response =
        await httpClient.post(url, headers: headers, body: jsonEncode(signUpRequest.toJson()));
    final decodedBody = json.decode(response.body);

    if (response.statusCode == 200) {
      return UserRegistration.fromJson(decodedBody);
    } else {
      log(decodedBody['message']);
      throw ServerFailure(errorMessage: decodedBody['message']);
    }
  }
}
