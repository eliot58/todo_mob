import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todotodo/presentation/auth/login.dart';
import 'package:todotodo/presentation/diler/orders.dart';
import 'package:todotodo/presentation/provider/orders.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  Widget homepage = const Login();
  final String? token = prefs.getString('token');
  if (token != null){
    try {
      var response =  await Dio().get('http://127.0.0.1:8000/api/v2/isdiler/', options: Options(headers: {'Authorization': 'Token $token'}));
      if (response.data['success']){
        homepage = const DilerOrders();
      }
      else {
        homepage = const ProviderOrders();
      }
    } on Exception catch (_) {
      await prefs.remove('token');
      homepage = const Login();
    }
  }
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: homepage
    )
  );
}