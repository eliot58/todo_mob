import 'package:dio/dio.dart';
import 'package:todotodo/data/api/api_util.dart';
import 'package:todotodo/domain/repository/provider/profile_repository.dart';

class ProviderProfileDataRepository extends ProviderProfileRepository {
  final ApiUtil apiUtil;

  ProviderProfileDataRepository(this.apiUtil);

  @override
  Future<dynamic> getProviderProfile() {
    return apiUtil.getProviderProfile();
  }

  @override
  Future<dynamic> saveProviderProfile({required String company, required String legalentity, required String productaddress, required String contactentity, required String contactphone, required String serviceentity, required String servicephone, required String serviceemail, required String description, required List<String> shapes,required List<String> implements,required List<String> regions, MultipartFile? logo}) {
    return apiUtil.getProviderProfile();
  }
}