import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todotodo/domain/repository/orders_repository.dart';

part 'orders_state.g.dart';

class OrdersState = OrdersStateBase with _$OrdersState;

abstract class OrdersStateBase with Store {
  OrdersStateBase(this.ordersRepository);

  final OrdersRepository ordersRepository;

  @observable
  List<dynamic> orders = [];
  
  late List<dynamic> immutableorders;

  @observable
  bool isLoading = false;

  search(s, ss) {
    s = s.toLowerCase();
    ss = ss.toLowerCase();
    return s.indexOf(ss) != -1 ? true : false;
  }

  @action
  Future<void> getOrders() async {
    isLoading = true;
    final data = await ordersRepository.getOrders();
    orders = data;
    immutableorders = data;
    isLoading = false;
  }

  @action
  Future<void> deleteOrder(index) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    Dio().delete('http://127.0.0.1:8000/api/v2/order/${orders[index]["id"]}/', options: Options(headers: {'Authorization': 'Token $token'}));
  }

  @action
  searchInOrders(value) async {
    isLoading = true;
    orders = immutableorders.where((element) => search(element['shape'], value) || search(element['implement'], value) || search(element['address'], value)).toList();
    isLoading = false;
  }

  @action
  whereByPrice(startPrice, endPrice) {
    orders = orders.where((element) => element['price'] >= startPrice && element['price'] <= endPrice).toList();
  }

  @action
  reverseOrders(){
    orders = List.from(orders.reversed);
  }
}
