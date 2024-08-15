class CreateUserRequest {
  final String email;
  final String password;
  final String name;

  CreateUserRequest(
      {required this.email, required this.password, required this.name});
}
