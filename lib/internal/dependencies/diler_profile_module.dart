import 'package:todotodo/domain/state/diler/profile_state.dart';
import 'package:todotodo/internal/dependencies/repository_module.dart';

class DilerProfileModule {
  static ProfileState profileState() {
    return ProfileState(
      RepositoryModule.getDilerProfileRepository(),
    );
  }
}