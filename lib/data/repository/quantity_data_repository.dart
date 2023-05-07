import 'package:dio/dio.dart';
import 'package:todotodo/data/api/api_util.dart';
import 'package:todotodo/domain/repository/quantity_repository.dart';

class QuantityDataRepository extends QuantityRepository {
  final ApiUtil apiUtil;

  QuantityDataRepository(this.apiUtil);

  @override
  Future<dynamic> createQuantity({required int shape, required int implement, required int order, required String date, required int price, required String comment, required MultipartFile file}) {
    return apiUtil.createQuantity(shape: shape, implement: implement, order: order, date: date, price: price, comment: comment, file: file);
  }

  @override
  Future<dynamic> getOrder({required int id}) {
    return apiUtil.getOrder(id: id);
  }

  @override
  Future<dynamic> getItems() {
    return apiUtil.getItems();
  }
  
}
