class UserRegistration {
  String? firstName;
  String? lastName;
  String? email;
  String? mobileNumber;
  String? password;
  String? confirmPassword;

  UserRegistration({
    this.firstName,
    this.lastName,
    this.email,
    this.mobileNumber,
    this.password,
    this.confirmPassword,
  });

  factory UserRegistration.fromJson(Map<String, dynamic> json) {
    return UserRegistration(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      mobileNumber: json['mobileNumber'] as String?,
      password: json['password'] as String?,
      confirmPassword: json['confirmPassword'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'mobileNumber': mobileNumber,
      'password': password,
      'confirmPassword': confirmPassword,
    };
  }

  // Validation method
  Map<String, String?> validate() {
    Map<String, String?> errors = {};

    if (firstName == null || firstName!.isEmpty) {
      errors['firstName'] = 'First name is required';
    }

    if (lastName == null || lastName!.isEmpty) {
      errors['lastName'] = 'Last name is required';
    }

    if (email == null || email!.isEmpty) {
      errors['email'] = 'Email is required';
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email!)) {
      errors['email'] = 'Invalid email format';
    }

    if (mobileNumber == null || mobileNumber!.isEmpty) {
      errors['mobileNumber'] = 'Mobile number is required';
    } else if (!RegExp(r'^\+?[0-9]{10,14}$').hasMatch(mobileNumber!)) {
      errors['mobileNumber'] = 'Invalid mobile number format';
    }

    if (password == null || password!.isEmpty) {
      errors['password'] = 'Password is required';
    } else if (password!.length < 8) {
      errors['password'] = 'Password must be at least 8 characters long';
    }

    if (confirmPassword == null || confirmPassword!.isEmpty) {
      errors['confirmPassword'] = 'Confirm password is required';
    } else if (confirmPassword != password) {
      errors['confirmPassword'] = 'Passwords do not match';
    }

    return errors;
  }
}