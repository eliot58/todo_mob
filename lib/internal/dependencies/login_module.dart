import 'package:todotodo/domain/state/login/login_state.dart';
import 'package:todotodo/internal/dependencies/repository_module.dart';

class LoginModule {
  static LoginState loginState() {
    return LoginState(
      RepositoryModule.getLoginRepository(),
    );
  }
}