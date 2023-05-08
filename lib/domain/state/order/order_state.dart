import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:todotodo/domain/repository/order_repository.dart';

part 'order_state.g.dart';

class OrderState = OrderStateBase with _$OrderState;

abstract class OrderStateBase with Store {
  OrderStateBase(this.orderRepository);

  final OrderRepository orderRepository;

  final TextEditingController addressController = TextEditingController();
  final TextEditingController windowCountController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController commentController = TextEditingController();

  String optpay = 'Вид оплаты';

  var pays = ['Вид оплаты', 'Карта', 'Безнал'];

  String optdel = 'Вид доставки';

  var dels = ['Вид доставки', 'Адрес клиента', 'Мой склад', 'Самовывоз'];

  String optshape = 'Выберите профиль';

  String optimpl = 'Выберите фурнитуру';

  List<String> shapes = ['Выберите профиль'];

  List<String> implements = ['Выберите фурнитуру'];

  Map<String, int> shapesId = {};

  Map<String, int> implementsId = {};

  List<PlatformFile>? paths;

  dynamic order;

  late dynamic immutableorder;

  @observable
  bool isLoading = false;

  @observable
  bool isBlank = true;

  @action
  Future<void> isBlankcheck() async {
    isLoading = true;
    final data = await orderRepository.isBlank();
    if (data["isblanked"]) {
      final items = await orderRepository.getItems();
      for (var shape in items["shapes_select"]) {
        shapes.add(shape["data"]);
        shapesId[shape["data"]] = shape["id"];
      }
      for (var implement in items["implements_select"]) {
        implements.add(implement["data"]);
        implementsId[implement["data"]] = implement["id"];
      }
    } else {
      isBlank = false;
    }
    isLoading = false;
  }

  @action
  Future<void> getOrder({required int id}) async {
    isLoading = true;
    final data = await orderRepository.getOrder(id: id);
    order = data;
    immutableorder = data;
    isLoading = false;
  }

  @action
  Future<void> createOrder() async {
    await orderRepository.createOrder(
        shape: shapesId[optshape]!,
        implement: implementsId[optimpl]!,
        address: addressController.text,
        typePay: optpay == 'Карта' ? "C" : "N",
        typeDelivery: (dels.indexOf(optdel) - 1).toString(),
        amountwindow: int.parse(windowCountController.text),
        price: int.parse(priceController.text),
        comment: commentController.text,
        files: [for (var path in paths ?? []) MultipartFile.fromBytes(path.bytes, filename: path.name)]);
  }

  search(s, ss) {
    s = s.toLowerCase();
    ss = ss.toLowerCase();
    return s.indexOf(ss) != -1 ? true : false;
  }

  @action
  searchInQuantities(value) async {
    isLoading = true;
    order = immutableorder["quantity_set"].where((element) => search(element['shape'], value) || search(element['implement'], value) || search(element['address'], value)).toList();
    isLoading = false;
  }

  @action
  whereByPrice(startPrice, endPrice) {
    order = order["quantity_set"].where((element) => element['price'] >= startPrice && element['price'] <= endPrice).toList();
  }

  @action
  reverseQuantities() {
    order = List.from(order["quantity_set"].reversed);
  }
  
  @action
  Future<void> submitOrder({required int id}) async {
    await orderRepository.submitOrder(id: id);
  }
}
