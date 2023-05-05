import 'package:todotodo/data/api/api_util.dart';
import 'package:todotodo/data/api/service/todo_service.dart';

class ApiModule {
  static late ApiUtil apiUtil;

  static ApiUtil getapiUtil() {
    apiUtil = ApiUtil(TodoService());
    return apiUtil;
  }
}