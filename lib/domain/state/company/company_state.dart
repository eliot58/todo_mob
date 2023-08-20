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
    logourl = data["company"]["logo"];
    company = data["company"]["company"];
    address = data["company"]["product_address"];
    contactentity = data["company"]["contact_entity"];
    contactphone = data["company"]["contact_phone"];
    serviceentity = data["company"]["service_entity"];
    serviceemail = data["company"]["service_email"];
    servicephone = data["company"]["service_phone"];
    shapes = data["company"]["shapes"].join(", ");
    implements = data["company"]["implements"].join(", ");
    regions = data["company"]["regions"].join(", ");
    description = data["company"]["description"];
    reviews = data["reviews"];
    isLoading = false;
  }
}
