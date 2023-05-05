import 'package:todotodo/domain/state/archive/archive_state.dart';
import 'package:todotodo/internal/dependencies/repository_module.dart';

class ArchivesModule {
  static ArchiveState archivesState() {
    return ArchiveState(
      RepositoryModule.getArchivesRepository(),
    );
  }
}