class RegistraionRequest {
  String? email;
  String? password;
  String? mobileNumber;

  RegistraionRequest({
    this.email,
    this.password,
    this.mobileNumber,
  });

  // Factory constructor for creating an instance from a JSON map
  factory RegistraionRequest.fromJson(Map<String, dynamic> json) {
    return RegistraionRequest(
      email: json['email'] as String?,
      password: json['password'] as String?,
      mobileNumber: json['mobileNumber'] as String?,
    );
  }

  // Method to convert the instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'mobileNumber': mobileNumber,
    };
  }
}