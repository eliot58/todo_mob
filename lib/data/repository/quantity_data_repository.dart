import 'package:todotodo/data/api/api_util.dart';
import 'package:todotodo/domain/repository/quantity_repository.dart';

class QuantityDataRepository extends QuantityRepository {
  final ApiUtil apiUtil;

  QuantityDataRepository(this.apiUtil);

  @override
  Future<dynamic> createQuantity() {
    return apiUtil.createQuantity();
  }

  @override
  Future<dynamic> getOrder({required int id}) {
    return apiUtil.getOrder(id: id);
  }
}
