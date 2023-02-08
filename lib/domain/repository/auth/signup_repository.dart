import '../../model/auth/signup.dart';

abstract class SignupRepository{
  Future<Signup> login({
    required String email,
    required String phone,
    required String fullName,
    required String spec,
  });
}