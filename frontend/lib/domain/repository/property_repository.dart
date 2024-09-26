import 'package:dashboard/core/error/failures.dart';
import 'package:dashboard/domain/entity/response/request/login_request.dart';
import 'package:dashboard/domain/entity/response/request/registration_request.dart';
import 'package:dashboard/domain/entity/response/user_login_entity.dart';
import 'package:dashboard/domain/entity/response/user_registration_entity.dart';
import 'package:either_dart/either.dart';


abstract class AuthRepository{
  Future<Either<Failure, Login>> login({required LoginRequest logInRequest});
  Future<Either<Failure, UserRegistration>> registration({ required RegistraionRequest signUpRequest});
}