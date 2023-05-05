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


  String address = "";

  String shape = "";

  String implement = "";

  String typePay = "";

  String typeDelivery = "";

  String price = "";

  String comment = "";

  String file = "";

  String fileurl = "";

  String date = "";

  String countWindow = "";


  String optshape = 'Выберите профиль';

  List<dynamic> shapes = [];

  String optimpl = 'Выберите фурнитуру';

  List<dynamic> impls = [];

  List<PlatformFile>? paths;

  @observable
  bool isLoading = false;

  @action
  Future<void> getOrder({required int id}) async {
    await quantityRepository.getOrder(id: id);
  }

  @action
  Future<void> createQuantity() async {
    await quantityRepository.createQuantity();
  }
}
