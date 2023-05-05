import 'package:mobx/mobx.dart';
import 'package:todotodo/domain/repository/archive_repository.dart';

part 'archive_state.g.dart';

class ArchiveState = ArchiveStateBase with _$ArchiveState;

abstract class ArchiveStateBase with Store {
  ArchiveStateBase(this.archivesRepository);

  final ArchivesRepository archivesRepository;

  @observable
  List<dynamic> archives = [];

  @observable
  bool isLoading = false;

  double productQuality = 0.0;

  double deliveryQuality = 0.0;

  double supplierLoyalty = 0.0;

  

  @action
  Future<void> getArchives() async {
    isLoading = true;
    final data = await archivesRepository.getArchives();
    archives = data;
    isLoading = false;
  }

  @action
  Future<void> sendReview({required int id}) async {
    await archivesRepository.sendReview();
  }

}
