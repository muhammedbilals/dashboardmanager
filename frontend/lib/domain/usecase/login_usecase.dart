import 'package:dashboard/core/error/failures.dart';
import 'package:dashboard/domain/entity/request/login_request.dart';
import 'package:dashboard/domain/entity/response/user_login_entity.dart';
import 'package:dashboard/domain/repository/auth_repository.dart';
import 'package:either_dart/either.dart';


class LoginUseCase {
  final AuthRepository authRepository;

  LoginUseCase({required this.authRepository});

  Future<Either<Failure, Login>> execute({required LoginRequest loginRequest}) async{
  return await  authRepository.login(logInRequest: loginRequest);
  }
}
