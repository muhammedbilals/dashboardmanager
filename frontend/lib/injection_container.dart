import 'package:dashboard/data/datasource/auth_remote_datasource.dart';
import 'package:dashboard/data/repository/auth_repostory_impl.dart';
import 'package:dashboard/domain/repository/auth_repository.dart';
import 'package:dashboard/domain/usecase/login_usecase.dart';
import 'package:dashboard/domain/usecase/registration_usecase.dart';
import 'package:dashboard/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;



final sl = GetIt.instance;


Future<void> init() async {


  sl.registerFactory(
    () => AuthCubit(authRepository: sl()),
  );   
  sl.registerLazySingleton(() => LoginUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => RegistrationUsecase(authRepository: sl()));
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<AuthApiRemoteDataSource>(
      () => AuthApiRemoteDataSourceImpl(httpClient: sl()));

  sl.allReady().then((_) {
    sl<LoginUseCase>();
    sl<AuthRepository>();
    sl<AuthApiRemoteDataSource>();
    sl<http.Client>();
    debugPrint("Auths API Dependency injection completed successfully.");
  }).catchError((error) {
    debugPrint("Auths API Error during dependency injection: $error");
  });

  //external
  sl.registerLazySingleton<http.Client>(() => http.Client());
}
