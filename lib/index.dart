import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todotodo/diler/orders.dart';
import 'package:todotodo/provider/orders.dart';
import 'package:url_launcher/url_launcher.dart';

// auth

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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

  @override
  void initState() {
    super.initState();
    _isauth();
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

// register

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _fiocontr = TextEditingController();
  final TextEditingController _emailcontr = TextEditingController();
  final TextEditingController _phonecontr = TextEditingController();

  String _dropdownvalue = 'Выберите специализацию';

  var items = ['Выберите специализацию', 'Дилер', 'Поставщик окон'];

  dynamic uservalidator;
  dynamic phonevalidator;

  final _formKey = GlobalKey<FormState>();


  Widget _logo() {
    return Container(
        padding: const EdgeInsets.only(top: 40, bottom: 40),
        child: Image.asset("assets/img/todotodo_logo.png"));
  }

  Widget _select() {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButtonFormField(
          borderRadius: BorderRadius.circular(16),
          isExpanded: true,
          value: _dropdownvalue,
          items: items.map((String item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _dropdownvalue = newValue!;
            });
          },
          validator: (value) => value == 'Выберите специализацию'
              ? 'Выберите специализацию'
              : null,
        )
      ),
    );
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff07995c),
        body: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    _logo(),
                    Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Container(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: TextFormField(
                            controller: _fiocontr,
                            obscureText: false,
                            style: const TextStyle(fontSize: 16),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Введите ФИО';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              hintText: 'Введите ФИО'
                            ),
                          ),
                        )
                      ),
                    Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: _select()),
                    Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Container(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: TextFormField(
                            controller: _emailcontr,
                            obscureText: false,
                            style: const TextStyle(fontSize: 16),
                            validator: (value) {
                              return uservalidator;
                            },
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
                          child: TextFormField(
                            controller: _phonecontr,
                            obscureText: false,
                            style: const TextStyle(fontSize: 16),
                            validator: (value) {
                              return phonevalidator;
                            },
                            decoration: const InputDecoration(
                                hintText: 'Введите номер телефона'
                              ),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white)),
                          onPressed: () async {
                            var uservalidate =  await Dio().post('https://xn----gtbdlmdrgbq5j.xn--p1ai/api/v1/uservalidate/', data: {'email': _emailcontr.text});
                            setState(() {
                              uservalidator = uservalidate.data['validate'];
                            });
                            var phonevalidate =  await Dio().post('https://xn----gtbdlmdrgbq5j.xn--p1ai/api/v1/phonevalidate/', data: {'phone': _phonecontr.text});
                            setState(() {
                              phonevalidator = phonevalidate.data['validate'];
                            });
                            if (_formKey.currentState!.validate()){
                              var response = await Dio().post('https://xn----gtbdlmdrgbq5j.xn--p1ai/api/v1/signup/', data: {'email': _emailcontr.text, 'fio': _fiocontr.text, 'spec': _dropdownvalue == 'Дилер' ? 'D' : 'P', 'phone': _phonecontr.text});
                              if (response.data['success']){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SuccesReg()));
                              }
                              else {
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoseReg()));
                              }
                            }
                          },
                          child: const Text('Зарегистрироваться',
                              style: TextStyle(color: Colors.black)),
                        )
                      ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            TextButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(context, '/');
                                },
                                child: const Text(
                                  'Есть аккаунт?',
                                  style: TextStyle(color: Colors.white),
                                )),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(context, '/');
                                },
                                child: const Text(
                                  'Войти',
                                  style: TextStyle(color: Colors.white),
                                ))
                          ]),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(bottom: 40),
                        child: TextButton(
                            onPressed: () async {
                              var url = Uri.parse('https://xn----gtbdlmdrgbq5j.xn--p1ai/password_reset/');
                              if (!await launchUrl(url)) {
                                throw 'Could not launch $url';
                              }
                            },
                            child: const Text(
                              'Восстановить пароль',
                              style: TextStyle(color: Colors.white),
                            )
                        )
                    )
                  ],
                )
        )
      )
    );
  }
}


class SuccesReg extends StatelessWidget {
  const SuccesReg({super.key});

  Widget _logo() {
    return Container(
        padding: const EdgeInsets.only(top: 40, bottom: 40),
        child: Image.asset("assets/img/todotodo_logo.png"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff07995c),
      body: Center(
      child: Column(
        children: <Widget>[
          _logo(),
          const Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text('Вы успешно прошли регистрацию пароль отпрален на указанный вами E-mail', textAlign: TextAlign.center,),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
              onPressed: (){
                Navigator.pushReplacementNamed(context, '/');
              },
              child: const Text('Войти', style: TextStyle(color: Colors.black)),
            )
          )
        ],
      ),
    )
    );
  }
}


class LoseReg extends StatelessWidget {
  const LoseReg({super.key});

  Widget _logo() {
    return Container(
      padding: const EdgeInsets.only(top: 40, bottom: 40),
      child: Image.asset("assets/img/todotodo_logo.png"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff07995c),
      body: Center(
      child: Column(
        children: <Widget>[
          _logo(),
          const Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text('Не удалось пройти регистрацию попробуйте снова', textAlign: TextAlign.center),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
              onPressed: (){
                Navigator.pushReplacementNamed(context, '/');
              },
              child: const Text('Войти', style: TextStyle(color: Colors.black)),
            )
          )
        ],
      ),
    )
    );
  }
}

