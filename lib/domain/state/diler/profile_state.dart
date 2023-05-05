import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';
import 'package:todotodo/domain/repository/diler/profile_repository.dart';

part 'profile_state.g.dart';

class ProfileState = ProfileStateBase with _$ProfileState;

abstract class ProfileStateBase with Store {
  ProfileStateBase(this.profileRepository);

  final DilerProfileRepository profileRepository;

  final TextEditingController companyController = TextEditingController();

  final TextEditingController fullNameController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController addressController = TextEditingController();

  String dropdownvalue = "Мой регион";

  List<dynamic> regions = ["Мой регион"];

  Map<String, int> regionsId = {};

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
    final data = await profileRepository.getDilerProfile();
    logourl = data['logo'];
    companyController.text = data['organization'];
    companyController.selection = TextSelection.fromPosition(TextPosition(offset: companyController.text.length));
    fullNameController.text = data['fullName'];
    fullNameController.selection = TextSelection.fromPosition(TextPosition(offset: fullNameController.text.length));
    phoneController.text = data['phone'];
    phoneController.selection = TextSelection.fromPosition(TextPosition(offset: phoneController.text.length));
    emailController.text = data['email'];
    emailController.selection = TextSelection.fromPosition(TextPosition(offset: emailController.text.length));
    addressController.text = data['warehouse_address'];
    addressController.selection = TextSelection.fromPosition(TextPosition(offset: addressController.text.length));
    for (var region in data["regions"]) {
      regions.add(region["data"]);
      regionsId[region["data"]] = region["id"];
    }
    dropdownvalue = data['region'] == null ? "Мой регион" : regions[data["region"]];
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
    profileRepository.saveDilerProfile(
        email: emailController.text,
        phone: phoneController.text,
        organization: companyController.text,
        warehouseAddress: addressController.text,
        region: regionsId[dropdownvalue]!,
        fullName: fullNameController.text,
        logo: isPicked ? MultipartFile.fromBytes(logopath!.first.bytes!, filename: logopath!.first.name) : null);
  }
}
