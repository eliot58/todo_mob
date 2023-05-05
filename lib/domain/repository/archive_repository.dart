abstract class ArchivesRepository {
  Future<List<dynamic>> getArchives();
  Future<dynamic> sendReview();
}