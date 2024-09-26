import 'package:dashboard/core/error/failures.dart';
import 'package:dashboard/domain/entity/response/property_entity.dart';
import 'package:dashboard/domain/repository/property_repository.dart';
import 'package:either_dart/either.dart';

class GetPropertiesUseCase {
  final PropertyRepository propertyRepository;

  GetPropertiesUseCase({required this.propertyRepository});

  Future<Either<Failure, List<Property>>> execute() async {
    return await propertyRepository.getProperties();
  }
}
