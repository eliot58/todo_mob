abstract class LoginRepository {
  Future<dynamic> login({
    required String email,
    required String password
  });
}