import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:todotodo/domain/repository/quantity_repository.dart';

part 'quantity_state.g.dart';

class QuantityState = QuantityStateBase with _$QuantityState;

abstract class QuantityStateBase with Store {
  QuantityStateBase(this.quantityRepository);

  final QuantityRepository quantityRepository;

  final TextEditingController dateController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController commentController = TextEditingController();

  Map<String, String> delivery = {"0": "Адрес клиента", "1": "Мой склад", "2": "Самовывоз"};

  Map<String, int> shapesId = {};

  Map<String, int> implementsId = {};

  String address = "";

  String shape = "";

  String implement = "";

  String price = "";

  String comment = "";

  String file = "";

  String fileurl = "";

  String date = "";

  String countWindow = "";

  String optshape = 'Выберите профиль';

  List<dynamic> shapes = ['Выберите профиль'];

  String optimpl = 'Выберите фурнитуру';

  List<dynamic> impls = ['Выберите фурнитуру'];

  List<PlatformFile>? paths;

  @observable
  bool isLoading = false;

  @action
  Future<void> getOrder({required int id}) async {
    isLoading = true;
    final data = await quantityRepository.getOrder(id: id);
    address = data["address"];
    shape = data["shape"];
    implement = data["implement"];
    price = data["price"].toString();
    comment = data["comment"];
    file = data["file"].split("/").last;
    fileurl = data["file"];
    date = data["date"];
    countWindow = data["amount_window"].toString();
    final items = await quantityRepository.getItems();
    for (var shape in items["shapes_select"]) {
      shapes.add(shape["data"]);
      shapesId[shape["data"]] = shape["id"];
    }
    for (var implement in items["implements_select"]) {
      impls.add(implement["data"]);
      implementsId[implement["data"]] = implement["id"];
    }
    isLoading = false;
  }

  @action
  createQuantity({required int orderId}) async {
    await quantityRepository.createQuantity(shape: shapesId[optshape]!, implement: implementsId[optimpl]!, order: orderId, date: dateController.text, price: int.parse(priceController.text), comment: comment, file: MultipartFile.fromBytes(paths!.first.bytes!, filename: paths!.first.name));
  }
}
