import 'package:bloc/bloc.dart';
import 'package:dashboard/core/error/failures.dart';
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
      Either<Failure, List<Property>> fetchedProperties = await propertyRepository.getProperties();

      fetchedProperties.fold(
        (failure) => emit(PropertyFailure("")), // On failure, emit failure state
        (properties) => emit(PropertySuccess(properties))    // On success, emit success state
      );
    } catch (e) {
      emit(PropertyFailure('Unexpected error occurred.')); // Emit failure on exception
    }
  }
}
