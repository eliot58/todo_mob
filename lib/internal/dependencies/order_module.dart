import 'package:todotodo/domain/state/order/order_state.dart';
import 'package:todotodo/internal/dependencies/repository_module.dart';

class OrderModule {
  static OrderState orderState() {
    return OrderState(
      RepositoryModule.getOrderRepository(),
    );
  }
}