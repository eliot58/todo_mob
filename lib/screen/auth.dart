import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Widget _logo(){
    return Container(
      padding: const EdgeInsets.only(top: 40, bottom: 40),
      child: Image.asset("assets/img/todotodo_logo.png")
    );
  }

  dynamic passwordvalidator;

  final _formKey = GlobalKey<FormState>();

  _isauth() async {
    final SharedPreferences prefs = await _prefs;
    final String? token = prefs.getString('token');
    if (token != null){
      return true;
    }
    return false;
  }
  
  @override
  Widget build(BuildContext context) {
    if (_isauth()){
      Navigator.pushReplacementNamed(context, 'diler_order');
    }
    return Scaffold(
      backgroundColor: const Color(0xff07995c),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Center(
          child: Column(
            children: <Widget>[
              _logo(),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: TextFormField(
                    controller: _emailController,
                    obscureText: false,
                    style: const TextStyle(fontSize: 16),
                    decoration: const InputDecoration(
                      hintText: 'Введите E-mail'
                    ),
                  ),
                )
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    style: const TextStyle(fontSize: 16),
                    validator: (value) {
                      return passwordvalidator;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Введите пароль'
                    ),
                  ),
                )
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
                  onPressed: () async {
                    final SharedPreferences prefs = await _prefs;
                    try {
                      var response = await Dio().post('http://127.0.0.1:8000/api/v1/auth/token/login/', data: {'username': _emailController.text, 'password': _passwordController.text});
                      await prefs.setString('token', response.data['token']);
                      setState(() {
                        passwordvalidator = null;
                      });
                    } catch (e) {
                      setState(() {
                        passwordvalidator = 'неверный логин или пароль';
                      });
                    }
                    if (_formKey.currentState!.validate()){
                      Navigator.pushReplacementNamed(context, '/diler_order');
                    }
                  },
                  child: const Text('Войти', style: TextStyle(color: Colors.black)),
                )
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: TextButton(
                  onPressed: (){},
                  child: const Text('О сервисе', style: TextStyle(color: Colors.white),),
                )
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: TextButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/register');
                  },
                  child: const Text('Зарегистрироваться', style: TextStyle(color: Colors.white),),
                )
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: TextButton(
                  onPressed: (){},
                  child: const Text('Восстановить пароль', style: TextStyle(color: Colors.white),),
                )
              )
            ],
          )
          )
        )
      )
    );
  }
}
