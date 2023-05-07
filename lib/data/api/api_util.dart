import 'package:dio/dio.dart';
import 'package:todotodo/data/api/request/get_login_body.dart';
import 'package:todotodo/data/api/request/get_profile_body.dart';
import 'package:todotodo/data/api/request/get_register_body.dart';
import 'package:todotodo/data/api/request/order_body.dart';
import 'package:todotodo/data/api/request/quantity_body.dart';
import 'package:todotodo/data/api/service/todo_service.dart';

class ApiUtil {
  final TodoService todoService;

  ApiUtil(this.todoService);

  Future<dynamic> login({
    required String email,
    required String password,
  }) async {
    final body = GetLoginBody(email: email, password: password);
    final result = await todoService.login(body);
    return result;
  }

  Future<dynamic> register({required String email, required String phone, required String fullName, required String spec}) async {
    final body = GetRegisterBody(email: email, phone: phone, fullName: fullName, spec: spec);
    final result = await todoService.register(body);
    return result;
  }

  Future<List<dynamic>> getOrders() async {
    final result = await todoService.getOrders();
    return result;
  }

  Future<List<dynamic>> getWorks() async {
    final result = await todoService.getWorks();
    return result;
  }

  Future<List<dynamic>> getQuantities() async {
    final result = await todoService.getWorks();
    return result;
  }

  Future<List<dynamic>> getArchives() async {
    final result = await todoService.getArchives();
    return result;
  }

  Future<dynamic> getDilerProfile() async {
    final result = await todoService.getDilerProfile();
    return result;
  }

  Future<dynamic> getProviderProfile() async {
    final result = await todoService.getProviderProfile();
    return result;
  }

  Future<dynamic> saveDilerProfile({required String email, required String phone, required String fullName, required String organization, required String warehouseAddress, required int region, MultipartFile? logo}) async {
    final body = GetDilerProfileBody(email: email, phone: phone, fullName: fullName, organization: organization, warehouseAddress: warehouseAddress, region: region, logo: logo);
    final result = await todoService.saveDilerProfile(body);
    return result;
  }

  Future<dynamic> saveProviderProfile(
      {required String company,
      required String legalentity,
      required String productaddress,
      required String contactentity,
      required String contactphone,
      required String serviceentity,
      required String servicephone,
      required String serviceemail,
      required String description,
      required List<int> shapes,
      required List<int> implements,
      required List<int> regions,
      MultipartFile? logo}) async {
    final body = GetProviderProfileBody(
        company: company,
        legalentity: legalentity,
        productaddress: productaddress,
        contactentity: contactentity,
        contactphone: contactphone,
        serviceentity: serviceentity,
        servicephone: servicephone,
        serviceemail: serviceemail,
        description: description,
        shapes: shapes,
        implements: implements,
        regions: regions,
        logo: logo);
    final result = await todoService.saveProviderProfile(body);
    return result;
  }

  Future<dynamic> getOrder({required int id}) async {
    final result = await todoService.getOrder(id);
    return result;
  }

  Future<dynamic> createOrder({required int shape, required int implement, required String address, required String typePay, required String typeDelivery, required int amountwindow, required int price, required String comment, required List<MultipartFile> files}) async {
    final body = CreateOrderBody(shape: shape, implement: implement, address: address, typePay: typePay, typeDelivery: typeDelivery, amountwindow: amountwindow, price: price, comment: comment, files: files);
    final result = await todoService.createOrder(body);
    return result;
  }

  Future<dynamic> isBlank() async {
    final result = await todoService.isBlank();
    return result;
  }

  Future<dynamic> getItems() async {
    final result = await todoService.getItems();
    return result;
  }

  Future<dynamic> sendReview() async {
    final result = await todoService.sendReview();
    return result;
  }

  Future<dynamic> createQuantity({required int shape, required int implement, required int order, required String date, required int price, required String comment, required MultipartFile file}) async {
    final body = CreateQuantityBody(shape: shape, implement: implement, order: order, price: price, comment: comment, file: file, date: date);
    final result = await todoService.createQuantity(body);
    return result;
  }

  Future<dynamic> getPrices() async {
    final result = await todoService.getPrices();
    return result;
  }

  Future<dynamic> getCompanyData({required int id}) async {
    final result = await todoService.getCompanyData(id);
    return result;
  }

  Future<dynamic> submitOrder({required int id}) async {
    final result = await todoService.getOrder(id);
    return result;
  }
}
