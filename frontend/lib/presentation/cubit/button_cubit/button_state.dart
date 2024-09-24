import 'package:equatable/equatable.dart';

class ButtonState extends Equatable {
  final bool isValidated;
  final ButtonStatus buttonStatus;

  const ButtonState(
      {this.buttonStatus = ButtonStatus.idle, required this.isValidated,});

  @override
  List<Object?> get props => [isValidated, buttonStatus];

  ButtonState copyWith({
    bool? isValidated,
    ButtonStatus? buttonStatus,
    bool? error,
  }) {
    return ButtonState(
        isValidated: isValidated ?? this.isValidated,
        buttonStatus: buttonStatus ?? this.buttonStatus,
      );
  }
}

///Throw button state with [ButtonValidated] when api changes
class ButtonValidated extends ButtonState {
  const ButtonValidated(
      {required bool isValidated, ButtonStatus buttonStatus = ButtonStatus.idle})
      : super(isValidated: isValidated, buttonStatus: buttonStatus);

  @override
  List<Object?> get props => [isValidated, buttonStatus];
}

///Status of Buttons
enum ButtonStatus { idle, loading, error }
