import 'package:todotodo/domain/state/orders/orders_state.dart';
import 'package:todotodo/internal/dependencies/repository_module.dart';

class OrdersModule {
  static OrdersState ordersState() {
    return OrdersState(
      RepositoryModule.getOrdersRepository(),
    );
  }
}