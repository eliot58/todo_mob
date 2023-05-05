import 'package:todotodo/data/api/api_util.dart';
import 'package:todotodo/domain/repository/login_repository.dart';

class LoginDataRepository extends LoginRepository {
  final ApiUtil apiUtil;

  LoginDataRepository(this.apiUtil);

  @override
  Future<dynamic> login(
      {required String email, required String password}) {
    return apiUtil.login(email: email, password: password);
  }
}
