import 'package:todotodo/domain/state/company/company_state.dart';
import 'package:todotodo/internal/dependencies/repository_module.dart';

class CompanyModule {
  static CompanyState companyState() {
    return CompanyState(
      RepositoryModule.getCompanyRepository(),
    );
  }
}