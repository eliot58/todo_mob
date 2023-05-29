import 'package:mobx/mobx.dart';
import 'package:todotodo/domain/repository/register_repository.dart';

part 'register_state.g.dart';

class RegisterState = RegisterStateBase with _$RegisterState;

abstract class RegisterStateBase with Store {
  RegisterStateBase(this.registerRepository);

  final RegisterRepository registerRepository;

  @observable
  bool? registerData;

  @observable
  bool isLoading = false;

  @observable
  String? uservalidator;

  @observable
  String? phonevalidator;

  @action
  Future<void> register({required String email, required String phone, required String spec, required String fullName}) async {
    isLoading = true;
    final data = await registerRepository.register(email: email, phone: phone, spec: spec, fullName: fullName);
    if (data != null) {
      if (data.containsKey("detail")) {
        if (data["detail"] == "Success Sign-Up") {
          uservalidator = null;
          phonevalidator = null;
          registerData = true;
        } else if (data["detail"] == "Invalid Credentials") {
          uservalidator = null;
          phonevalidator = null;
          registerData = false;
        }
      } else {
        uservalidator = data.containsKey("email") ? data["email"][0] : null;
        phonevalidator = data.containsKey("phone") ? data["phone"][0] : null;
      }
    }
    isLoading = false;
  }
}
