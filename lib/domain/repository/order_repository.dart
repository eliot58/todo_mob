import 'package:dio/dio.dart';

abstract class OrderRepository {
  Future<dynamic> getOrder({required int id});
  Future<dynamic> createOrder({required int shape, required int implement,required String address, required String typePay, required String typeDelivery, required int amountwindow, required int price, required String comment, required MultipartFile file});
  Future<dynamic> isBlank();
  Future<dynamic> getItems();
  Future<dynamic> submitOrder({required int id});
}
