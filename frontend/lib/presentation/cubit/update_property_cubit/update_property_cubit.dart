import 'package:bloc/bloc.dart';
import 'package:dashboard/domain/entity/request/property_request.dart';
import 'package:dashboard/domain/repository/property_repository.dart';
import 'package:dashboard/presentation/cubit/update_property_cubit/update_property_state.dart';


class UpdatePropertyCubit extends Cubit<PropertyState> {
  final PropertyRepository propertyRepository;

  UpdatePropertyCubit({required this.propertyRepository}) : super(PropertyInitial());



  // Update Property Method
  void updateProperty(int id ,PropertyRequest property) async {
    emit(PropertyUpdateLoading()); // Emit loading state
    try {
      final result = await propertyRepository.updateProperty(id: id, property: property);

      result.fold(
        (failure) => emit(PropertyUpdateFailure("Update Failed")),
        (success) => emit(PropertyUpdateSuccess())
      );
    } catch (e) {
      emit(PropertyUpdateFailure('Unexpected error occurred while updating property.'));
    }
  }
}
