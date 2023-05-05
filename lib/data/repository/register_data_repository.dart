import 'package:todotodo/data/api/api_util.dart';
import 'package:todotodo/domain/repository/register_repository.dart';

class RegisterDataRepository extends RegisterRepository {
  final ApiUtil apiUtil;

  RegisterDataRepository(this.apiUtil);

  @override
  Future<dynamic> register(
      {required String email,
      required String phone,
      required String spec,
      required String fullName}) {
    return apiUtil.register(
        email: email, phone: phone, fullName: fullName, spec: spec);
  }
}
