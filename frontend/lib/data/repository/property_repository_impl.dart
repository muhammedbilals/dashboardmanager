import 'dart:developer';
import 'package:dashboard/core/error/failures.dart';
import 'package:dashboard/data/datasource/property_remote_datasource.dart';
import 'package:dashboard/domain/entity/request/property_request.dart';
import 'package:dashboard/domain/entity/response/property_entity.dart';
import 'package:dashboard/domain/repository/property_repository.dart';
import 'package:either_dart/either.dart';

class PropertyRepositoryImpl implements PropertyRepository {
  final PropertyApiRemoteDataSource remoteDataSource;


  PropertyRepositoryImpl({
    required this.remoteDataSource,
    
  });

  @override
  Future<Either<Failure, Property?>> getPropertyById({required int id}) async {
   
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
    
  }

  @override
  Future<Either<Failure, List<Property>>> getProperties() async {
   
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
    
  }

  @override
  Future<Either<Failure, Property>> createProperty({required PropertyRequest property}) async {

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
  }

  @override
  Future<Either<Failure, Property?>> updateProperty({required int id, required PropertyRequest property}) async {

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
  
  }

  @override
  Future<Either<Failure, bool>> deleteProperty({required int id}) async {

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
  
  }
}
