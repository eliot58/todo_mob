import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todotodo/data/api/service/todo_service.dart';
import 'package:todotodo/firebase_options.dart';
import 'package:todotodo/presentation/auth/login.dart';
import 'package:todotodo/presentation/diler/orders.dart';
import 'package:todotodo/presentation/provider/orders.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load(fileName: ".env");
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
  runApp(ScreenUtilInit(
    designSize: const Size(375, 812),
    builder: (context, child) {
      return MaterialApp(debugShowCheckedModeBanner: false, home: child);
    },
    child: homepage,
  ));
}
