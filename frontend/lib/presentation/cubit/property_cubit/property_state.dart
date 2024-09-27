import 'package:dashboard/domain/entity/response/property_entity.dart';
import 'package:equatable/equatable.dart';

abstract class PropertyState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PropertyInitial extends PropertyState {}

class PropertyLoading extends PropertyState {}

class PropertySuccess extends PropertyState {
  final List<Property> properties;

  PropertySuccess(this.properties);

  @override
  List<Object?> get props => [properties];
}

class PropertyFailure extends PropertyState {
  final String errorMessage;

  PropertyFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
