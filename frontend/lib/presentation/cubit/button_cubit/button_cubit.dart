import 'package:bloc/bloc.dart';
import 'package:dashboard/presentation/cubit/button_cubit/button_state.dart';




///This buttonCubit can used for showing state of the button [ButtonState]
class ButtonCubit extends Cubit<ButtonState> {
  ButtonCubit() : super(const ButtonValidated(isValidated: false));

  void validateTextfield(bool isValidated) {
    emit(ButtonValidated(isValidated: isValidated));
    print('data updated $isValidated');
  }
  void setLoading(ButtonStatus buttonStatus) {
    emit(state.copyWith(buttonStatus: buttonStatus));
  }

}
