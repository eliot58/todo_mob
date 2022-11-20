import 'package:flutter/material.dart';
import 'package:todotodo/index.dart';


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
      initialRoute: '/',
      routes: {
        '/': (context) => const Auth()
      },
    ),
  );
}
