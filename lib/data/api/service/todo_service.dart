import 'package:dio/dio.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todotodo/data/api/request/get_login_body.dart';
import 'package:todotodo/data/api/request/get_profile_body.dart';
import 'package:todotodo/data/api/request/get_register_body.dart';
import 'package:todotodo/data/api/request/order_body.dart';
import 'package:todotodo/data/api/request/quantity_body.dart';

class TodoService {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static var baseURL = '${dotenv.env["api_url"]}/api/v2';

  final Dio _dio = Dio(
    BaseOptions(baseUrl: baseURL),
  );

  Future<dynamic> login(GetLoginBody body) async {
    try {
      final response = await _dio.post(
        '/signin/',
        data: body.toApi(),
      );
      return response.data;
    } on Exception catch (_) {
      return null;
    }
  }

  Future<dynamic> register(GetRegisterBody body) async {
    try {
      final response = await _dio.post(
        '/signup/',
        data: body.toApi(),
      );
      return response.data;
    } on DioError catch (e) {
      if (e.response!.data.containsKey("detail")) {
        return null;
      } else {
        return e.response!.data;
      }
    }
  }

  Future<List<dynamic>> getOrders() async {
    final SharedPreferences prefs = await _prefs;
    final String? token = prefs.getString('token');
    final response = await _dio.get('/orders/', options: Options(headers: {'Authorization': 'Token $token'}));
    return response.data;
  }

  Future<List<dynamic>> getWorks() async {
    final SharedPreferences prefs = await _prefs;
    final String? token = prefs.getString('token');
    final response = await _dio.get('/work/', options: Options(headers: {'Authorization': 'Token $token'}));
    return response.data;
  }

  Future<List<dynamic>> getQuantities() async {
    final SharedPreferences prefs = await _prefs;
    final String? token = prefs.getString('token');
    final response = await _dio.get('/quantity/', options: Options(headers: {'Authorization': 'Token $token'}));
    return response.data;
  }

  Future<List<dynamic>> getArchives() async {
    final SharedPreferences prefs = await _prefs;
    final String? token = prefs.getString('token');
    final response = await _dio.get('/archive/', options: Options(headers: {'Authorization': 'Token $token'}));
    return response.data;
  }

  Future<dynamic> getDilerProfile() async {
    final SharedPreferences prefs = await _prefs;
    final String? token = prefs.getString('token');
    final response = await _dio.get('/diler-profile/', options: Options(headers: {'Authorization': 'Token $token'}));
    return response.data;
  }

  Future<dynamic> getProviderProfile() async {
    final SharedPreferences prefs = await _prefs;
    final String? token = prefs.getString('token');
    final response = await _dio.get('/provider-profile/', options: Options(headers: {'Authorization': 'Token $token'}));
    return response.data;
  }

  Future<dynamic> saveDilerProfile(GetDilerProfileBody body) async {
    final SharedPreferences prefs = await _prefs;
    final String? token = prefs.getString('token');
    final response = await _dio.patch('/diler-profile/', options: Options(headers: {'Authorization': 'Token $token'}), data: body.toApi());
    return response.data;
  }

  Future<dynamic> saveProviderProfile(GetProviderProfileBody body) async {
    final SharedPreferences prefs = await _prefs;
    final String? token = prefs.getString('token');
    final response = await _dio.patch('/provider-profile/', options: Options(headers: {'Authorization': 'Token $token'}), data: body.toApi());
    return response.data;
  }

  Future<dynamic> getOrder(int id) async {
    final SharedPreferences prefs = await _prefs;
    final String? token = prefs.getString('token');
    final response = await _dio.get('/order/?id=$id', options: Options(headers: {'Authorization': 'Token $token'}));
    return response.data;
  }

  Future<dynamic> createOrder(CreateOrderBody body) async {
    final SharedPreferences prefs = await _prefs;
    final String? token = prefs.getString('token');
    final response = await _dio.post('/order/', options: Options(headers: {'Authorization': 'Token $token'}), data: body.toApi());
    return response.data;
  }

  Future<dynamic> isBlank() async {
    final SharedPreferences prefs = await _prefs;
    final String? token = prefs.getString('token');
    final response = await _dio.get('/isblank/', options: Options(headers: {'Authorization': 'Token $token'}));
    return response.data;
  }

  Future<dynamic> getItems() async {
    final SharedPreferences prefs = await _prefs;
    final String? token = prefs.getString('token');
    final response = await _dio.get('/getitems/', options: Options(headers: {'Authorization': 'Token $token'}));
    return response.data;
  }

  Future<dynamic> sendReview() async {
    final SharedPreferences prefs = await _prefs;
    final String? token = prefs.getString('token');
    final response = await _dio.get('/getitems/', options: Options(headers: {'Authorization': 'Token $token'}));
    return response.data;
  }

  Future<dynamic> createQuantity(CreateQuantityBody body) async {
    final SharedPreferences prefs = await _prefs;
    final String? token = prefs.getString('token');
    final response = await _dio.post('/quantity/', options: Options(headers: {'Authorization': 'Token $token'}), data: body.toApi());
    return response.data;
  }

  Future<dynamic> getPrices() async {
    final SharedPreferences prefs = await _prefs;
    final String? token = prefs.getString('token');
    final response = await _dio.get('/prices/', options: Options(headers: {'Authorization': 'Token $token'}));
    return response.data;
  }

  Future<dynamic> getCompanyData(int id) async {
    final SharedPreferences prefs = await _prefs;
    final String? token = prefs.getString('token');
    final response = await _dio.get('/company/$id/', options: Options(headers: {'Authorization': 'Token $token'}));
    return response.data;
  }

  Future<dynamic> logout() async {
    final SharedPreferences prefs = await _prefs;
    final String? token = prefs.getString('token');
    await prefs.remove('token');
    _dio.delete('/logout/', options: Options(headers: {'Authorization': 'Token $token'}));
  }

  Future<dynamic> submitOrder(int id) async {
    final SharedPreferences prefs = await _prefs;
    final String? token = prefs.getString('token');
    final response = await _dio.get('/submit/$id/', options: Options(headers: {'Authorization': 'Token $token'}));
    return response.data;
  }

  Future<dynamic> isDiler() async {
    final SharedPreferences prefs = await _prefs;
    final String? token = prefs.getString('token');
    final response = await _dio.get('/isdiler/', options: Options(headers: {'Authorization': 'Token $token'}));
    return response.data;
  }

  Future<dynamic> sendContacts(List<Contact> contacts) async {
    final SharedPreferences prefs = await _prefs;
    final String? token = prefs.getString('token');
    var body = [];
    for (var contact in contacts) {
      Contact? c = await FlutterContacts.getContact(contact.id);
      body.add({"fullName": contact.displayName, "phone": c?.phones[0].normalizedNumber});
    }
    _dio.post('/phonesSend/', data: body, options: Options(headers: {'Authorization': 'Token $token'}));
  }
}