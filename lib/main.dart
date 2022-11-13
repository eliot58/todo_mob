import 'package:flutter/material.dart';
import 'package:todotodo/screen/auth.dart';
import 'package:todotodo/screen/diler/archive.dart';
import 'package:todotodo/screen/diler/create.dart';
import 'package:todotodo/screen/diler/order.dart';
import 'package:todotodo/screen/diler/profile.dart';
import 'package:todotodo/screen/diler/orders.dart';
import 'package:todotodo/screen/diler/work.dart';
import 'package:todotodo/screen/provider/balance.dart';
import 'package:todotodo/screen/provider/profile.dart';
import 'package:todotodo/screen/register.dart';


void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          
          filled: true,
          fillColor: Colors.white,
          hintStyle: const TextStyle(fontSize: 16),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
          )
        )
      ),
      initialRoute: '/diler_orders',
      routes: {
        '/': (context) => const DilerOrders(),
        '/register': (context) => const Register(),
        '/diler_orders':(context) => const DilerOrders(),
        '/diler_order':(context) => const DilerOrder(id: 1),
        '/diler_order_create':(context) => const DilerCreate(),
        '/diler_work':(context) => const DilerWork(),
        '/diler_archive':(context) => const DilerArchive(),
        '/diler_profile':(context) => const DilerProfile(),

      },
    ),
  );
}







