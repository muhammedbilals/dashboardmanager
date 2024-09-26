import 'dart:developer';

import 'package:dashboard/core/error/failures.dart';
import 'package:dashboard/core/platform/network_info.dart';
import 'package:dashboard/data/datasource/property_remote_datasource.dart';
import 'package:dashboard/domain/entity/request/property_request.dart';
import 'package:dashboard/domain/entity/response/property_entity.dart';
import 'package:dashboard/domain/repository/property_repository.dart';
import 'package:either_dart/either.dart';

class PropertyRepositoryImpl implements PropertyRepository {
  final PropertyApiRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  PropertyRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Property?>> getPropertyById({required int id}) async {
    if (await networkInfo.isConnected == true) {
      try {
        final property = await remoteDataSource.getPropertyById(id: id);
        return Right(property);
      } catch (e) {
        log(e.toString());
        if (e is ServerFailure) {
          return Left(e);
        } else {
          return const Left(ServerFailure(errorMessage: 'Failed to fetch property by ID'));
        }
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, List<Property>>> getProperties() async {
    if (await networkInfo.isConnected == true) {
      try {
        final properties = await remoteDataSource.getProperties();
        return Right(properties);
      } catch (e) {
        log(e.toString());
        if (e is ServerFailure) {
          return Left(e);
        } else {
          return const Left(ServerFailure(errorMessage: 'Failed to fetch properties'));
        }
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, Property>> createProperty({required PropertyRequest property}) async {
    if (await networkInfo.isConnected == true) {
      try {
        final result = await remoteDataSource.createProperty(propertyRequest: property);
        return Right(result);
      } catch (e) {
        log(e.toString());
        if (e is ServerFailure) {
          return Left(e);
        } else {
          return const Left(ServerFailure(errorMessage: 'Failed to create property'));
        }
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, Property?>> updateProperty({required int id, required PropertyRequest property}) async {
    if (await networkInfo.isConnected == true) {
      try {
        final result = await remoteDataSource.updateProperty(id: id, propertyRequest: property);
        return Right(result);
      } catch (e) {
        log(e.toString());
        if (e is ServerFailure) {
          return Left(e);
        } else {
          return const Left(ServerFailure(errorMessage: 'Failed to update property'));
        }
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, Property?>> deleteProperty({required int id}) async {
    if (await networkInfo.isConnected == true) {
      try {
        final property = await remoteDataSource.deleteProperty(id: id);
        return Right(property);
      } catch (e) {
        log(e.toString());
        if (e is ServerFailure) {
          return Left(e);
        } else {
          return const Left(ServerFailure(errorMessage: 'Failed to delete property'));
        }
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}
