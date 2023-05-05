import 'package:todotodo/data/api/api_util.dart';
import 'package:todotodo/domain/repository/archive_repository.dart';

class ArchivesDataRepository extends ArchivesRepository {
  final ApiUtil apiUtil;

  ArchivesDataRepository(this.apiUtil);

  @override
  Future<List<dynamic>> getArchives() {
    return apiUtil.getArchives();
  }

  @override
  Future<dynamic> sendReview() {
    return apiUtil.sendReview();
  }
}
