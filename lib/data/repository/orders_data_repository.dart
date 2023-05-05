import 'package:todotodo/data/api/api_util.dart';
import 'package:todotodo/domain/repository/orders_repository.dart';

class OrdersDataRepository extends OrdersRepository {
  final ApiUtil apiUtil;

  OrdersDataRepository(this.apiUtil);

  @override
  Future<List<dynamic>> getOrders() {
    return apiUtil.getOrders();
  }
}
