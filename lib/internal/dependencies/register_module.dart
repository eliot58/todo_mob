import 'package:todotodo/domain/state/register/register_state.dart';
import 'package:todotodo/internal/dependencies/repository_module.dart';

class RegisterModule {
  static RegisterState registerState() {
    return RegisterState(
      RepositoryModule.getRegisterRepository(),
    );
  }
}