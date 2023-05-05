import 'package:mobx/mobx.dart';
import 'package:todotodo/domain/repository/works_repository.dart';

part 'works_state.g.dart';

class WorksState = WorksStateBase with _$WorksState;

abstract class WorksStateBase with Store {
  WorksStateBase(this.worksRepository);

  final WorksRepository worksRepository;

  @observable
  List<dynamic> works = [];

  @observable
  List<dynamic> quantities = [];

  @observable
  bool isLoading = false;

  @action
  Future<void> getWorks() async {
    isLoading = true;
    final data = await worksRepository.getWorks();
    works = data;
    isLoading = false;
  }


  @action
  Future<void> getWorksAndQuantities() async {
    isLoading = true;
    final data = await worksRepository.getWorks();
    works = data;
    isLoading = false;
  }
}
