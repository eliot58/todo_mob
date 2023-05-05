import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todotodo/data/api/request/get_login_body.dart';
import 'package:todotodo/data/api/request/get_profile_body.dart';
import 'package:todotodo/data/api/request/get_register_body.dart';
import 'package:todotodo/data/api/request/order_body.dart';

class TodoService {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static const baseURL = 'http://127.0.0.1:8000/api/v2';

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
    final response = await _dio.get('/works/', options: Options(headers: {'Authorization': 'Token $token'}));
    return response.data;
  }

  Future<List<dynamic>> getArchives() async {
    final SharedPreferences prefs = await _prefs;
    final String? token = prefs.getString('token');
    final response = await _dio.get('/works/', options: Options(headers: {'Authorization': 'Token $token'}));
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
    final response = await _dio.get('/diler-profile/', options: Options(headers: {'Authorization': 'Token $token'}));
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

  Future<dynamic> createQuantity() async {
    final SharedPreferences prefs = await _prefs;
    final String? token = prefs.getString('token');
    final response = await _dio.get('/getitems/', options: Options(headers: {'Authorization': 'Token $token'}));
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
    final response = await _dio.get('/prices/', options: Options(headers: {'Authorization': 'Token $token'}));
    return response.data;
  }
}
