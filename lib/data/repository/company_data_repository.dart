import 'package:todotodo/data/api/api_util.dart';
import 'package:todotodo/domain/repository/company_repository.dart';

class CompanyDataRepository extends CompanyRepository {
  final ApiUtil apiUtil;

  CompanyDataRepository(this.apiUtil);

  @override
  Future<dynamic> getCompanyData({required int id}) {
    return apiUtil.getCompanyData(id: id);
  }
}
