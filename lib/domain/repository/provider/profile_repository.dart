import 'package:dio/dio.dart';

abstract class ProviderProfileRepository {
  Future<dynamic> getProviderProfile();
  Future<dynamic> saveProviderProfile({required String company, required String legalentity, required String productaddress, required String contactentity, required String contactphone, required String serviceentity, required String servicephone, required String serviceemail, required String description, required List<int> shapes,required List<int> implements,required List<int> regions, MultipartFile? logo});
}