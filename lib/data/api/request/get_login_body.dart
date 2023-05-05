
class GetLoginBody {
  final String email;
  final String password;

  GetLoginBody({
    required this.email,
    required this.password,
  });

  Map<String, String> toApi() {
    return {
      'email': email,
      'password': password
    };
  }
}