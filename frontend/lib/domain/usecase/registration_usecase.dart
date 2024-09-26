import 'package:dashboard/core/error/failures.dart';
import 'package:dashboard/domain/entity/request/registration_request.dart';
import 'package:dashboard/domain/entity/response/user_registration_entity.dart';
import 'package:dashboard/domain/repository/auth_repository.dart';
import 'package:either_dart/either.dart';


class LoginUseCase {
  final AuthRepository authRepository;

  LoginUseCase({required this.authRepository});

  Future<Either<Failure, UserRegistration>> execute({required RegistraionRequest loginRequest}) async{
  return await  authRepository.registration(signUpRequest: loginRequest);
  }
}
