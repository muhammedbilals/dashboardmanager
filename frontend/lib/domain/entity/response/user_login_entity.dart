class Login {
  String? email;
  String? password;

  Login({
    this.email,
    this.password,
  });

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      email: json['email'] as String?,
      password: json['password'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }

  // Validation method
  Map<String, String?> validate() {
    Map<String, String?> errors = {};

    if (email == null || email!.isEmpty) {
      errors['email'] = 'Email is required';
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email!)) {
      errors['email'] = 'Invalid email format';
    }

    if (password == null || password!.isEmpty) {
      errors['password'] = 'Password is required';
    }

    return errors;
  }
}