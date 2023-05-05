import 'package:mobx/mobx.dart';
import 'package:todotodo/domain/repository/balance_repository.dart';

part 'price_state.g.dart';

class PriceState = PriceStateBase with _$PriceState;

abstract class PriceStateBase with Store {
  PriceStateBase(this.balanceRepository);

  final BalanceRepository balanceRepository;

  List<dynamic> prices = [];

  @observable
  bool isLoading = false;

  @action
  Future<void> getPrices() async {
    isLoading = true;
    final data = await balanceRepository.getPrices();
    prices = data;
    isLoading = false;
  }
}
