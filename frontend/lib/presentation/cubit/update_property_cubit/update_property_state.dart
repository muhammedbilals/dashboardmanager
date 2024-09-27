import 'package:dashboard/domain/entity/response/property_entity.dart';
import 'package:equatable/equatable.dart';

abstract class PropertyState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PropertyInitial extends PropertyState {}



class PropertyUpdateInitial extends PropertyState {}


class PropertyUpdateLoading extends PropertyState {}


class PropertyUpdateSuccess extends PropertyState {


  PropertyUpdateSuccess();

  @override
  List<Object?> get props => [];
}


class PropertyUpdateFailure extends PropertyState {
  final String errorMessage;

  PropertyUpdateFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
