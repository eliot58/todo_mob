import '../../model/auth/signin.dart';

abstract class SigninRepository{
  Future<Signin> login({
    required String email,
    required String password,
  });
}