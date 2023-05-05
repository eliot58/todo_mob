import 'package:dio/dio.dart';
import 'package:todotodo/data/api/api_util.dart';
import 'package:todotodo/domain/repository/diler/profile_repository.dart';

class DilerProfileDataRepository extends DilerProfileRepository {
  final ApiUtil apiUtil;

  DilerProfileDataRepository(this.apiUtil);

  @override
  Future<dynamic> getDilerProfile() {
    return apiUtil.getDilerProfile();
  }

  @override
  Future<dynamic> saveDilerProfile({required String email, required String phone, required String fullName, required String organization, required String warehouseAddress, required int region, MultipartFile? logo}) {
    return apiUtil.saveDilerProfile(email: email, phone: phone, fullName: fullName, organization: organization, warehouseAddress: warehouseAddress, region: region, logo: logo);
  }

}

