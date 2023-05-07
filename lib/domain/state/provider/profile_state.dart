import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';
import 'package:todotodo/domain/repository/provider/profile_repository.dart';

part 'profile_state.g.dart';

class ProfileState = ProfileStateBase with _$ProfileState;

abstract class ProfileStateBase with Store {
  ProfileStateBase(this.profileRepository);

  final ProviderProfileRepository profileRepository;

  final TextEditingController company = TextEditingController();
  final TextEditingController legalentity = TextEditingController();
  final TextEditingController productaddress = TextEditingController();
  final TextEditingController contactentity = TextEditingController();
  final TextEditingController contactphone = TextEditingController();
  final TextEditingController serviceentity = TextEditingController();
  final TextEditingController servicephone = TextEditingController();
  final TextEditingController serviceemail = TextEditingController();
  final TextEditingController description = TextEditingController();

  List<String> shapes = [];
  List<String> implements = [];
  List<String> regions = [];

  List<String> selectedShapes = [];
  List<String> selectedImpl = [];
  List<String> selectedRegions = [];

  Map<String, int> selectedShapesId = {};
  Map<String, int> selectedImplementsId = {};
  Map<String, int> selectedRegionsId = {};

  dynamic logourl;

  @observable
  List<PlatformFile>? logopath;

  @observable
  bool isPicked = false;

  @observable
  bool isLoading = false;

  @action
  Future<void> getProfile() async {
    isLoading = true;
    final data = await profileRepository.getProviderProfile();
    logourl = data['logo'];
    company.text = data['company'];
    company.selection = TextSelection.fromPosition(TextPosition(offset: company.text.length));
    legalentity.text = data['legal_entity'];
    legalentity.selection = TextSelection.fromPosition(TextPosition(offset: legalentity.text.length));
    productaddress.text = data['product_address'];
    productaddress.selection = TextSelection.fromPosition(TextPosition(offset: productaddress.text.length));
    contactentity.text = data['contact_entity'];
    contactentity.selection = TextSelection.fromPosition(TextPosition(offset: contactentity.text.length));
    contactphone.text = data['contact_phone'];
    contactphone.selection = TextSelection.fromPosition(TextPosition(offset: contactphone.text.length));
    serviceentity.text = data['service_entity'];
    serviceentity.selection = TextSelection.fromPosition(TextPosition(offset: serviceentity.text.length));
    servicephone.text = data['service_phone'];
    servicephone.selection = TextSelection.fromPosition(TextPosition(offset: servicephone.text.length));
    serviceemail.text = data['service_email'];
    serviceemail.selection = TextSelection.fromPosition(TextPosition(offset: serviceemail.text.length));
    description.text = data['description'];
    description.selection = TextSelection.fromPosition(TextPosition(offset: description.text.length));
    for (var shape in data["shapes_select"]) {
      shapes.add(shape["data"]);
      selectedShapesId[shape["data"]] = shape["id"];
    }
    for (var implement in data["implements_select"]) {
      implements.add(implement["data"]);
      selectedImplementsId[implement["data"]] = implement["id"];
    }
    for (var region in data["regions_select"]) {
      regions.add(region["data"]);
      selectedRegionsId[region["data"]] = region["id"];
    }
    selectedShapes.addAll([for (var shape in data["shapes"]) shapes[shape - 1]]);
    selectedImpl.addAll([for (var implement in data["implements"]) implements[implement - 1]]);
    selectedRegions.addAll([for (var region in data["regions"]) regions[region - 1]]);
    isLoading = false;
  }

  @action
  pickImg() async {
    try {
      logopath = (await FilePicker.platform.pickFiles(
        withData: true,
        type: FileType.custom,
        allowMultiple: false,
        onFileLoading: (FilePickerStatus status) => print(status),
        allowedExtensions: ['png', 'jpg', 'jpeg', 'heic'],
      ))
          ?.files;
    } on PlatformException catch (e) {
      log('Unsupported operation$e');
    } catch (e) {
      log(e.toString());
    }
    if (logopath != null) {
      isPicked = true;
    }
  }

  Future<void> saveProfile() async {
    profileRepository.saveProviderProfile(
        company: company.text,
        legalentity: legalentity.text,
        productaddress: productaddress.text,
        contactentity: contactentity.text,
        contactphone: contactphone.text,
        serviceentity: serviceentity.text,
        servicephone: servicephone.text,
        serviceemail: serviceemail.text,
        description: description.text,
        shapes: [for (var shape in selectedShapes) selectedShapesId[shape]!],
        implements: [for (var impl in selectedImpl) selectedImplementsId[impl]!],
        regions: [for (var region in selectedRegions) selectedRegionsId[region]!]);
  }
}
