import 'package:dashboard/core/error/failures.dart';
import 'package:dashboard/domain/entity/request/property_request.dart';
import 'package:dashboard/domain/entity/response/property_entity.dart';
import 'package:dashboard/domain/repository/property_repository.dart';
import 'package:either_dart/either.dart';

class CreatePropertyUseCase {
  final PropertyRepository propertyRepository;

  CreatePropertyUseCase({required this.propertyRepository});

  Future<Either<Failure, Property>> execute({required PropertyRequest propertyRequest}) async {
    return await propertyRepository.createProperty(property: propertyRequest);
  }
}
