import 'dart:developer';

import 'package:dashboard/core/error/failures.dart';
import 'package:dashboard/data/datasource/auth_remote_datasource.dart';
import 'package:dashboard/domain/entity/request/login_request.dart';
import 'package:dashboard/domain/entity/request/registration_request.dart';
import 'package:dashboard/domain/entity/response/user_login_entity.dart';
import 'package:dashboard/domain/entity/response/user_registration_entity.dart';
import 'package:dashboard/domain/repository/auth_repository.dart';
import 'package:either_dart/either.dart';


class AuthRepositoryImpl implements AuthRepository {
  final AuthApiRemoteDataSource remoteDataSource;
  

  AuthRepositoryImpl(
      {required this.remoteDataSource});

  @override
  Future<Either<Failure, Login>> login(
      {required LoginRequest logInRequest}) async {
  
      try {
        final authEnity =
            await remoteDataSource.loginWithApi(logInRequest: logInRequest);
        return Right(authEnity);
      } catch (e) {
        log(e.toString());
        if (e is ServerFailure) {
          return Left(e);
        } else {
          return const Left(ServerFailure(errorMessage: 'Login Failed'));
        }
      }
  }

  @override
  Future<Either<Failure, UserRegistration>> registration(
      {required RegistraionRequest signUpRequest}) async {
 
      try {
        final authEnity =
            await remoteDataSource.signUpWithApi(signUpRequest: signUpRequest);
        log(authEnity.email.toString());
        return Right(authEnity);
      } catch (e) {
        log(e.toString());
        if (e is ServerFailure) {
          return Left(e);
        } else {
          return const Left(
              ServerFailure(errorMessage: 'SignUp Failed '));
        }
      }
    
  }
}
