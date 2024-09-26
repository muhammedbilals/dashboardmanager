import 'package:dashboard/core/error/failures.dart';
import 'package:dashboard/domain/entity/request/property_request.dart';
import 'package:dashboard/domain/entity/response/property_entity.dart';
import 'package:dashboard/domain/repository/property_repository.dart';
import 'package:either_dart/either.dart';

class UpdatePropertyUseCase {
  final PropertyRepository propertyRepository;

  UpdatePropertyUseCase({required this.propertyRepository});

  Future<Either<Failure, Property?>> execute({required int id, required PropertyRequest propertyRequest}) async {
    return await propertyRepository.updateProperty(id: id, property: propertyRequest);
  }
}
