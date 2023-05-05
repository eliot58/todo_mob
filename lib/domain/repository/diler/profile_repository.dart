import 'package:dio/dio.dart';

abstract class DilerProfileRepository {
  Future<dynamic> getDilerProfile();
  Future<dynamic> saveDilerProfile({required String email, required String phone, required String fullName, required String organization, required String warehouseAddress, required int region, MultipartFile? logo});
}