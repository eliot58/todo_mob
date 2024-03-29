import 'package:dio/dio.dart';
import 'package:todotodo/data/api/api_util.dart';
import 'package:todotodo/domain/repository/order_repository.dart';

class OrderDataRepository extends OrderRepository {
  final ApiUtil apiUtil;

  OrderDataRepository(this.apiUtil);

  @override
  Future<dynamic> getOrder({required int id}) {
    return apiUtil.getOrder(id: id);
  }

  @override
  Future<dynamic> createOrder({required int shape, required int implement,required String address, required String typePay, required String typeDelivery, required int amountwindow, required int price, required String comment, required MultipartFile file}) {
    return apiUtil.createOrder(shape: shape, implement: implement,address: address, typeDelivery: typeDelivery, typePay: typePay, amountwindow: amountwindow, price: price, comment: comment, file: file);
  }

  @override
  Future<dynamic> isBlank() {
    return apiUtil.isBlank();
  }

  @override
  Future<dynamic> getItems() {
    return apiUtil.getItems();
  }

  @override
  Future<dynamic> submitOrder({required int id}) {
    return apiUtil.submitOrder(id: id);
  }
}
