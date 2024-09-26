import 'package:dashboard/core/error/failures.dart';
import 'package:dashboard/domain/entity/request/property_request.dart';
import 'package:dashboard/domain/entity/response/property_entity.dart';
import 'package:either_dart/either.dart';



abstract class PropertyRepository {
  Future<Either<Failure, Property?>> getPropertyById({required int id});
  Future<Either<Failure, List<Property>>> getProperties();
  Future<Either<Failure, Property>> createProperty({required PropertyRequest property});
  Future<Either<Failure, Property?>> updateProperty({required int id, required PropertyRequest property});
  Future<Either<Failure, Property?>> deleteProperty({required int id});
}