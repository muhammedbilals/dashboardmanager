import 'package:bloc/bloc.dart';
import 'package:dashboard/core/error/failures.dart';
import 'package:dashboard/domain/entity/request/property_request.dart';
import 'package:dashboard/domain/entity/response/property_entity.dart';
import 'package:dashboard/domain/repository/property_repository.dart';
import 'package:dashboard/presentation/cubit/property_cubit/property_state.dart';
import 'package:either_dart/src/either.dart';

class PropertyCubit extends Cubit<PropertyState> {
  final PropertyRepository propertyRepository;

  PropertyCubit({required this.propertyRepository}) : super(PropertyInitial());

  void fetchProperties() async {
    emit(PropertyLoading()); // Emit loading state
    try {
      Either<Failure, List<Property>> fetchedProperties =
          await propertyRepository.getProperties();

      fetchedProperties.fold(
          (failure) =>
              emit(PropertyFailure("")), // On failure, emit failure state
          (properties) => emit(
              PropertySuccess(properties)) // On success, emit success state
          );
    } catch (e) {
      emit(PropertyFailure(
          'Unexpected error occurred.')); // Emit failure on exception
    }
  }



  // // Create Property Method
  // void createProperty(PropertyRequest property) async {
  //   emit(PropertyCreateLoading()); // Emit loading state
  //   try {
  //     final result =
  //         await propertyRepository.createProperty(property: property);

  //     result.fold(
  //       (failure) => emit(PropertyCreateFailure("Create Failed")),
  //       (success) {
  //         if (success == true) {
  //           fetchProperties(); // Refetch properties after successful creation
  //           emit(PropertyCreateSuccess());
  //         } else {
  //           emit(PropertyCreateFailure('Failed to create property.'));
  //         }
  //       },
  //     );
  //   } catch (e) {
  //     emit(PropertyFailure(
  //         'Unexpected error occurred while creating property.'));
  //   }
  // }

// Delete Property Method
  void deleteProperty(int id) async {
    emit(PropertyLoading()); // Emit loading state
    try {
      final result = await propertyRepository.deleteProperty(id: id);

      result.fold(
        (failure) => emit(PropertyFailure("Delete Failed")),
        (success) {
          if (success == true) {
            fetchProperties(); // Refetch properties after successful deletion
          } else {
            emit(PropertyFailure('Failed to delete property.'));
          }
        },
      );
    } catch (e) {
      emit(PropertyFailure('Unexpected error occurred while deleting property.'));
    }
  }
  // Update Property Method
  void updateProperty(int id ,PropertyRequest property) async {
    emit(PropertyLoading()); // Emit loading state
    try {
      final result = await propertyRepository.updateProperty(id: id, property: property);

      result.fold(
        (failure) => emit(PropertyFailure("Update Failed")),
        (success) {
          if (success == true) {
            fetchProperties(); // Refetch properties after successful update
          } else {
            emit(PropertyFailure('Failed to update property.'));
          }
        },
      );
    } catch (e) {
      emit(PropertyFailure('Unexpected error occurred while updating property.'));
    }
  }
}
