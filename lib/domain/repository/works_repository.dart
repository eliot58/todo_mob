abstract class WorksRepository {
  Future<List<dynamic>> getWorks();
  Future<List<dynamic>> getQuantities();
  dynamic submitOrder({required int id});
}