import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todotodo/auth/reg.dart';
import 'package:todotodo/diler/orders.dart';
import 'package:todotodo/provider/orders.dart';
import 'package:url_launcher/url_launcher.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool rememberme = false;

  dynamic passwordvalidator;

  final _formKey = GlobalKey<FormState>();
  
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Widget _logo(){
    return Container(
      padding: const EdgeInsets.only(top: 40, bottom: 40),
      child: Image.asset("assets/img/todotodo_logo.png")
    );
  }

  _isauth() async {
    final SharedPreferences prefs = await _prefs;
    final String? token = prefs.getString('token');
    if (token != null){
      var response =  await Dio().get('https://xn----gtbdlmdrgbq5j.xn--p1ai/api/v1/isdiler/', options: Options(headers: {'Authorization': 'Token $token'}));
      if (response.data['success']){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const DilerOrders()));
      }
      else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const ProviderOrders()));
      }
    }
  }

  _islogin() async {
    final SharedPreferences prefs = await _prefs;
    final String? login = prefs.getString('login');
    final String? pass = prefs.getString('pass');
    if (login != null && pass != null){
      _emailController.text = login;
      _passwordController.text = pass;
    }
  }

  @override
  void initState() {
    super.initState();
    _isauth();
    _islogin();
  }
  
  @override
  Widget build(BuildContext context) {
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
                  child: TextFormField(
                    controller: _emailController,
                    obscureText: false,
                    style: const TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                      hintText: 'Введите E-mail',
                      filled: true,
                      fillColor: Colors.white,
                      hintStyle: const TextStyle(fontSize: 16),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                      )
                    ),
                  ),
                )
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    style: const TextStyle(fontSize: 16),
                    validator: (value) {
                      return passwordvalidator;
                    },
                    decoration: InputDecoration(
                      hintText: 'Введите пароль',
                      filled: true,
                      fillColor: Colors.white,
                      hintStyle: const TextStyle(fontSize: 16),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                      )
                    ),
                  ),
                )
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Checkbox(
                          value: rememberme,
                          onChanged: (bool? value) {
                            setState(() {
                              rememberme = value!;
                            });
                          },
                        ),
                      ),
                      const Text('Запомнить'),
                    ],
                  )
                )
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
                  onPressed: () async {
                    final SharedPreferences prefs = await _prefs;
                    try {
                      var response = await Dio().post('https://xn----gtbdlmdrgbq5j.xn--p1ai/api/v1/auth/token/login/', data: {'username': _emailController.text, 'password': _passwordController.text});
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
                      if (rememberme){
                        await prefs.setString('login', _emailController.text);
                        await prefs.setString('pass', _passwordController.text);
                      }
                      final String? token = prefs.getString('token');
                      var response =  await Dio().get('https://xn----gtbdlmdrgbq5j.xn--p1ai/api/v1/isdiler/', options: Options(headers: {'Authorization': 'Token $token'}));
                      if (response.data['success']){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const DilerOrders()));
                      }
                      else {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const ProviderOrders()));
                      }
                    }
                  },
                  child: const Text('Войти', style: TextStyle(color: Colors.black)),
                )
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: TextButton(
                  onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const Register()));
                  },
                  child: const Text('Зарегистрироваться', style: TextStyle(color: Colors.white),),
                )
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: TextButton(
                  onPressed: () async {
                    var url = Uri.parse('https://xn----gtbdlmdrgbq5j.xn--p1ai/password_reset/');
                      if (!await launchUrl(url)) {
                        throw 'Could not launch $url';
                      }
                  },
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