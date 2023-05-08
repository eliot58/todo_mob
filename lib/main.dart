import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todotodo/data/api/service/todo_service.dart';
import 'package:todotodo/presentation/auth/login.dart';
import 'package:todotodo/presentation/diler/orders.dart';
import 'package:todotodo/presentation/provider/orders.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  Widget homepage = const Login();
  final String? token = prefs.getString('token');
  final todoService = TodoService();
  if (token != null) {
    try {
      final data = await todoService.isDiler();
      if (data['success']) {
        homepage = const DilerOrders();
      } else {
        homepage = const ProviderOrders();
      }
    } on Exception catch (_) {
      await prefs.remove('token');
      homepage = const Login();
    }
  }
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: homepage));
}
