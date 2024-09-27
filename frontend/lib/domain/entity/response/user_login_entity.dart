class Login {
  final String email;
  final String? password;
  final String tokens;
  final String userRole;

  Login({
    required this.email,
    this.password,
    required this.tokens,
    required this.userRole,
  });
}