import 'package:bloc/bloc.dart';
import 'package:dashboard/core/error/failures.dart';
import 'package:dashboard/domain/entity/request/property_request.dart';
import 'package:dashboard/domain/entity/response/property_entity.dart';
import 'package:dashboard/domain/repository/property_repository.dart';
import 'package:dashboard/presentation/cubit/create_property_cubit/create_property_state.dart';
import 'package:either_dart/src/either.dart';

class CreatePropertyCubit extends Cubit<PropertyState> {
  final PropertyRepository propertyRepository;

  CreatePropertyCubit({required this.propertyRepository}) : super(PropertyCreateInitial());

  // void fetchProperties() async {
  //   emit(PropertyLoading()); // Emit loading state
  //   try {
  //     Either<Failure, List<Property>> fetchedProperties =
  //         await propertyRepository.getProperties();

  //     fetchedProperties.fold(
  //         (failure) =>
  //             emit(PropertyFailure("")), // On failure, emit failure state
  //         (properties) => emit(
  //             PropertySuccess(properties)) // On success, emit success state
  //         );
  //   } catch (e) {
  //     emit(PropertyFailure(
  //         'Unexpected error occurred.')); // Emit failure on exception
  //   }
  // }



  // Create Property Method
  void createProperty(PropertyRequest property) async {
    emit(PropertyCreateLoading()); // Emit loading state
    try {
      final result =
          await propertyRepository.createProperty(property: property);

      result.fold(
        (failure) => emit(PropertyCreateFailure("Create Failed")),
        (success) => emit(PropertyCreateSuccess())
      );
    } catch (e) {
      emit(PropertyCreateFailure(
          'Unexpected error occurred while creating property.'));
    }
  }

}
