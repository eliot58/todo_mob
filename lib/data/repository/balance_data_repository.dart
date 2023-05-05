import 'package:todotodo/data/api/api_util.dart';
import 'package:todotodo/domain/repository/balance_repository.dart';

class BalanceDataRepository extends BalanceRepository {
  final ApiUtil apiUtil;

  BalanceDataRepository(this.apiUtil);

  @override
  Future<dynamic> getPrices() {
    return apiUtil.getPrices();
  }
}
