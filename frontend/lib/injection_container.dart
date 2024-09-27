import 'package:dashboard/data/datasource/auth_remote_datasource.dart';
import 'package:dashboard/data/datasource/property_remote_datasource.dart';
import 'package:dashboard/data/repository/auth_repostory_impl.dart';
import 'package:dashboard/data/repository/property_repository_impl.dart';
import 'package:dashboard/domain/repository/auth_repository.dart';
import 'package:dashboard/domain/repository/property_repository.dart';
import 'package:dashboard/domain/usecase/get_all_property_usecase.dart';
import 'package:dashboard/domain/usecase/login_usecase.dart';
import 'package:dashboard/domain/usecase/registration_usecase.dart';
import 'package:dashboard/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:dashboard/presentation/cubit/create_property_cubit/create_property_cubit.dart';
import 'package:dashboard/presentation/cubit/property_cubit/property_cubit.dart';
import 'package:dashboard/presentation/cubit/update_property_cubit/update_property_cubit.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

// Create an instance of GetIt for dependency injection
final sl = GetIt.instance;

// Initialize dependencies
Future<void> init() async {
  // Register Auth related dependencies
  sl.registerFactory(
    () => AuthCubit(authRepository: sl()), // Register AuthCubit as a factory
  );
  sl.registerLazySingleton(() => LoginUseCase(
      authRepository: sl())); // Register LoginUseCase as a singleton
  sl.registerLazySingleton(() => RegistrationUsecase(
      authRepository: sl())); // Register RegistrationUseCase as a singleton
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
      remoteDataSource:
          sl())); // Register AuthRepository with its implementation
  sl.registerLazySingleton<AuthApiRemoteDataSource>(() =>
      AuthApiRemoteDataSourceImpl(
          httpClient: sl())); // Register remote data source for Auth API

  // Check if all registered services are ready
  sl.allReady().then((_) {
    // Access services to ensure they are initialized
    sl<LoginUseCase>();
    sl<AuthRepository>();
    sl<AuthApiRemoteDataSource>();
    sl<http.Client>(); // Ensure the http.Client is also initialized
    debugPrint(
        "Auths API Dependency injection completed successfully."); // Log success
  }).catchError((error) {
    debugPrint(
        "Auths API Error during dependency injection: $error"); // Log error
  });

  // Register Property related dependencies
  sl.registerFactory(
    () => PropertyCubit(
        propertyRepository: sl()), // Register PropertyCubit as a factory
  );
  sl.registerFactory(
    () => CreatePropertyCubit(
        propertyRepository: sl()), // Register CreatePropertyCubit as a factory
  );
  sl.registerFactory(
    () => UpdatePropertyCubit(
        propertyRepository: sl()), // Register UpdatePropertyCubit as a factory
  );
  sl.registerLazySingleton(() => GetPropertiesUseCase(
      propertyRepository:
          sl())); // Register GetPropertiesUseCase as a singleton
  // sl.registerLazySingleton(() => RegistrationUsecase(authRepository: sl())); // (Commented out) Registration use case, possibly unused
  sl.registerLazySingleton<PropertyRepository>(() => PropertyRepositoryImpl(
      remoteDataSource:
          sl())); // Register PropertyRepository with its implementation
  sl.registerLazySingleton<PropertyApiRemoteDataSource>(() =>
      PropertyApiRemoteDataSourceImpl(
          httpClient: sl())); // Register remote data source for Property API

  // Check if all registered services are ready for Property related services
  sl.allReady().then((_) {
    // Access services to ensure they are initialized
    sl<LoginUseCase>();
    sl<PropertyRepository>();
    sl<PropertyApiRemoteDataSource>();
    sl<http.Client>(); // Ensure the http.Client is also initialized
    debugPrint(
        "Property API Dependency injection completed successfully."); // Log success
  }).catchError((error) {
    debugPrint(
        "Property API Error during dependency injection: $error"); // Log error
  });

  // Register external dependencies
  sl.registerLazySingleton<http.Client>(
      () => http.Client()); // Register HTTP client as a singleton
}
