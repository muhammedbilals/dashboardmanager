import 'package:email_validator/email_validator.dart';

///Used for validating Textfield

class TextfieldValidation {
  ///Checks if the email is valid
  static bool isEmail(String input) => EmailValidator.validate(input);

  ///Check if the Phone number is valid
  static bool isPhone(String input) =>
      RegExp(r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$')
          .hasMatch(input);

  ///Check if the password is valid
  static bool isPassword(String? input) {
    if (input != null && input.length < 7) {
      return true;
    } else {
      return false;
    }
  }

  ///check if the textfield is empty
  static bool isEmpty(String? input) {
    if (input != null && input.length < 3) {
      return true;
    } else {
      return false;
    }
  }

  ///checks if the pincode is valid
  static bool isPincode(String input) =>
      RegExp('[1-9]{1}[0-9]{5}|[1-9]{1}[0-9]{3}\\s[0-9]{3}').hasMatch(input);
}
