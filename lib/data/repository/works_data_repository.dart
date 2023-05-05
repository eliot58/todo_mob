import 'package:todotodo/data/api/api_util.dart';
import 'package:todotodo/domain/repository/works_repository.dart';

class WorksDataRepository extends WorksRepository {
  final ApiUtil apiUtil;

  WorksDataRepository(this.apiUtil);

  @override
  Future<List<dynamic>> getWorks() {
    return apiUtil.getWorks();
  }
}
