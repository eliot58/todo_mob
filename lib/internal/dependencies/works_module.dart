import 'package:todotodo/domain/state/works/works_state.dart';
import 'package:todotodo/internal/dependencies/repository_module.dart';

class WorksModule {
  static WorksState worksState() {
    return WorksState(
      RepositoryModule.getWorksRepository(),
    );
  }
}