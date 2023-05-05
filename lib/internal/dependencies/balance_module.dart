import 'package:todotodo/domain/state/balance/price_state.dart';
import 'package:todotodo/internal/dependencies/repository_module.dart';

class BalanceModule {
  static PriceState balanceState() {
    return PriceState(
      RepositoryModule.getBalanceRepository(),
    );
  }
}