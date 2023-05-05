import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todotodo/domain/repository/login_repository.dart';

part 'login_state.g.dart';

class LoginState = LoginStateBase with _$LoginState;

abstract class LoginStateBase with Store {
  LoginStateBase(this.loginRepository);

  final LoginRepository loginRepository;

  @observable
  dynamic loginData;

  @observable
  bool remember = false;

  @observable
  bool passwordObscure = true;

  @observable
  String? passwordvalidator;

  @observable
  bool isLoading = false;

  @action
  Future<void> login({
    required String email,
    required String password,
  }) async {
    isLoading = true;
    final data = await loginRepository.login(email: email, password: password);
    loginData = data;
    if (data == null) {
      passwordvalidator = "неверный логин или пароль";
    } else {
      passwordvalidator = null;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', data["token"]!);
    }
    isLoading = false;
  }

  @action
  obscureChange() {
    passwordObscure = !passwordObscure;
  }
}
