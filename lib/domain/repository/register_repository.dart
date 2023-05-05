abstract class RegisterRepository {
  Future<dynamic> register({
    required String email,
    required String phone,
    required String spec,
    required String fullName
  });
}