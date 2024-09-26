import 'dart:developer';

import 'package:dashboard/core/error/failures.dart';
import 'package:dashboard/core/platform/network_info.dart';
import 'package:dashboard/data/datasource/auth_remote_datasource.dart';
import 'package:dashboard/domain/entity/request/login_request.dart';
import 'package:dashboard/domain/entity/request/registration_request.dart';
import 'package:dashboard/domain/entity/response/user_login_entity.dart';
import 'package:dashboard/domain/entity/response/user_registration_entity.dart';
import 'package:dashboard/domain/repository/auth_repository.dart';
import 'package:either_dart/either.dart';


class AuthRepositoryImpl implements AuthRepository {
  final AuthApiRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, Login>> login(
      {required LoginRequest logInRequest}) async {
    if (await networkInfo.isConnected == true) {
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
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, UserRegistration>> registration(
      {required RegistraionRequest signUpRequest}) async {
    if (await networkInfo.isConnected == true) {
      try {
        final authEnity =
            await remoteDataSource.signUpWithApi(signUpRequest: signUpRequest);
        
        return Right(authEnity);
      } catch (e) {
        log(e.toString());
        if (e is ServerFailure) {
          return Left(e);
        } else {
          return const Left(
              ServerFailure(errorMessage: 'SignUp Failed'));
        }
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}
