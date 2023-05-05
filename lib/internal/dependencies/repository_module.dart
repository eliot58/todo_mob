import 'package:todotodo/data/repository/archives_data_repository.dart';
import 'package:todotodo/data/repository/balance_data_repository.dart';
import 'package:todotodo/data/repository/company_data_repository.dart';
import 'package:todotodo/data/repository/diler/profile_data_repository.dart';
import 'package:todotodo/data/repository/login_data_repository.dart';
import 'package:todotodo/data/repository/order_data_repository.dart';
import 'package:todotodo/data/repository/orders_data_repository.dart';
import 'package:todotodo/data/repository/provider/profile_data_repository.dart';
import 'package:todotodo/data/repository/quantity_data_repository.dart';
import 'package:todotodo/data/repository/register_data_repository.dart';
import 'package:todotodo/data/repository/works_data_repository.dart';
import 'package:todotodo/domain/repository/archive_repository.dart';
import 'package:todotodo/domain/repository/balance_repository.dart';
import 'package:todotodo/domain/repository/company_repository.dart';
import 'package:todotodo/domain/repository/diler/profile_repository.dart';
import 'package:todotodo/domain/repository/login_repository.dart';
import 'package:todotodo/domain/repository/order_repository.dart';
import 'package:todotodo/domain/repository/orders_repository.dart';
import 'package:todotodo/domain/repository/provider/profile_repository.dart';
import 'package:todotodo/domain/repository/quantity_repository.dart';
import 'package:todotodo/domain/repository/register_repository.dart';
import 'package:todotodo/domain/repository/works_repository.dart';

import 'api_module.dart';

class RepositoryModule {
  static late LoginRepository loginRepository;
  static late RegisterRepository registerRepository;
  static late OrdersRepository ordersRepository;
  static late WorksRepository worksRepository;
  static late ArchivesRepository archivesRepository;
  static late DilerProfileRepository dilerProfileRepository;
  static late ProviderProfileRepository providerProfileRepository;
  static late OrderRepository orderRepository;
  static late QuantityRepository quantityRepository;
  static late BalanceRepository balanceRepository;
  static late CompanyRepository companyRepository;

  static LoginRepository getLoginRepository() {
    loginRepository = LoginDataRepository(
      ApiModule.getapiUtil(),
    );
    return loginRepository;
  }

  static RegisterRepository getRegisterRepository() {
    registerRepository = RegisterDataRepository(
      ApiModule.getapiUtil(),
    );
    return registerRepository;
  }

  static OrdersRepository getOrdersRepository() {
    ordersRepository = OrdersDataRepository(
      ApiModule.getapiUtil(),
    );
    return ordersRepository;
  }

  static WorksRepository getWorksRepository() {
    worksRepository = WorksDataRepository(
      ApiModule.getapiUtil(),
    );
    return worksRepository;
  }

  static ArchivesRepository getArchivesRepository() {
    archivesRepository = ArchivesDataRepository(
      ApiModule.getapiUtil(),
    );
    return archivesRepository;
  }


  static OrderRepository getOrderRepository() {
    orderRepository = OrderDataRepository(
      ApiModule.getapiUtil(),
    );
    return orderRepository;
  }

  static DilerProfileRepository getDilerProfileRepository() {
    dilerProfileRepository = DilerProfileDataRepository(
      ApiModule.getapiUtil(),
    );
    return dilerProfileRepository;
  }


  static ProviderProfileRepository getProviderProfileRepository() {
    providerProfileRepository = ProviderProfileDataRepository(
      ApiModule.getapiUtil(),
    );
    return providerProfileRepository;
  }


  static QuantityRepository getQuantityRepository() {
    quantityRepository = QuantityDataRepository(
      ApiModule.getapiUtil(),
    );
    return quantityRepository;
  }


  static BalanceRepository getBalanceRepository() {
    balanceRepository = BalanceDataRepository(
      ApiModule.getapiUtil(),
    );
    return balanceRepository;
  }


  static CompanyRepository getCompanyRepository() {
    companyRepository = CompanyDataRepository(
      ApiModule.getapiUtil(),
    );
    return companyRepository;
  }
}
