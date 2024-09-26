import 'package:dashboard/core/error/failures.dart';
import 'package:dashboard/domain/entity/response/property_entity.dart';
import 'package:dashboard/domain/repository/property_repository.dart';
import 'package:either_dart/either.dart';


class GetPropertyByIdUseCase {
  final PropertyRepository propertyRepository;

  GetPropertyByIdUseCase({required this.propertyRepository});

  Future<Either<Failure, Property?>> execute({required int id}) async {
    return await propertyRepository.getPropertyById(id: id);
  }
}