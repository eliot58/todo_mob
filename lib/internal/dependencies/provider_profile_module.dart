import 'package:todotodo/domain/state/provider/profile_state.dart';
import 'package:todotodo/internal/dependencies/repository_module.dart';

class ProviderProfileModule {
  static ProfileState profileState() {
    return ProfileState(
      RepositoryModule.getProviderProfileRepository(),
    );
  }
}