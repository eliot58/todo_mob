import 'package:mobx/mobx.dart';
import 'package:todotodo/domain/repository/company_repository.dart';

part 'company_state.g.dart';

class CompanyState = CompanyStateBase with _$CompanyState;

abstract class CompanyStateBase with Store {
  CompanyStateBase(this.companyRepository);

  final CompanyRepository companyRepository;

  dynamic logourl;
  String company = '';
  String address = '';
  String contactentity = '';
  String contactphone = '';
  String serviceentity = '';
  String serviceemail = '';
  String servicephone = '';
  String shapes = '';
  String implements = '';
  String regions = '';
  String description = '';

  List<dynamic> reviews = [];

  @observable
  bool isLoading = false;

  @action
  Future<void> getComapnyData(int id) async {
    isLoading = true;
    final data = await companyRepository.getCompanyData(id: id);

    isLoading = false;
  }
}
