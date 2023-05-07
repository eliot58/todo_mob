import 'package:dio/dio.dart';

abstract class QuantityRepository {
  Future<dynamic> createQuantity({required int shape, required int implement, required int order, required String date, required int price, required String comment, required MultipartFile file});
  Future<dynamic> getOrder({required int id});
  Future<dynamic> getItems();
}
