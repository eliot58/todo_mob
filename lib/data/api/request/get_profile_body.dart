import 'package:dio/dio.dart';

class GetDilerProfileBody {
  final String fullName;
  final String phone;
  final String email;
  final String organization;
  final String warehouseAddress;
  final int region;
  final MultipartFile? logo;

  GetDilerProfileBody({required this.email, required this.phone, required this.fullName, required this.organization, required this.warehouseAddress, required this.region, this.logo});

  FormData toApi() {
    return FormData.fromMap({'email': email, 'phone': phone, "fullName": fullName, "organization": organization, "warehouse_address": warehouseAddress, "region": region, "logo": logo});
  }
}

class GetProviderProfileBody {
  final String company;
  final String legalentity;
  final String productaddress;
  final String contactentity;
  final String contactphone;
  final String serviceentity;
  final String servicephone;
  final String serviceemail;
  final String description;
  final List<int> shapes;
  final List<int> implements;
  final List<int> regions;
  final MultipartFile? logo;

  GetProviderProfileBody(
      {required this.company,
      required this.legalentity,
      required this.productaddress,
      required this.contactentity,
      required this.contactphone,
      required this.serviceentity,
      required this.servicephone,
      required this.serviceemail,
      required this.description,
      required this.shapes,
      required this.implements,
      required this.regions,
      this.logo});

  FormData toApi() {
    return FormData.fromMap({"company": company, "legal_entity": legalentity, "product_address": productaddress, "contact_entity": contactentity, "contact_phone": contactphone, "service_entity": serviceentity, "service_phone": servicephone, "service_email": serviceemail, "shapes": shapes, "implements": implements, "regions": regions, "description": description, "logo": logo});
  }
}
