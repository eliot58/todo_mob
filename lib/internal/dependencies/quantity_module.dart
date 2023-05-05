import 'package:todotodo/domain/state/quantity/quantity_state.dart';
import 'package:todotodo/internal/dependencies/repository_module.dart';

class QuantityModule {
  static QuantityState quantityState() {
    return QuantityState(
      RepositoryModule.getQuantityRepository(),
    );
  }
}