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



class PropertyCreateInitial extends PropertyState {}


class PropertyCreateLoading extends PropertyState {}


class PropertyCreateSuccess extends PropertyState {


  PropertyCreateSuccess();

  @override
  List<Object?> get props => [];
}


class PropertyCreateFailure extends PropertyState {
  final String errorMessage;

  PropertyCreateFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
class PropertyDeleteLoading extends PropertyState {}


class PropertyDeleteSuccess extends PropertyState {


  PropertyDeleteSuccess();

  @override
  List<Object?> get props => [];
}


class PropertyDeleteFailure extends PropertyState {
  final String errorMessage;

  PropertyDeleteFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
