import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

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


  Widget _logo() {
    return Container(
        padding: const EdgeInsets.only(top: 40, bottom: 40),
        child: Image.asset("assets/img/todotodo_logo.png"));
  }

  Widget _select() {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      constraints: const BoxConstraints(maxWidth: 500),
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
  dynamic uservalidator;
  dynamic phonevalidator;

  final _formKey = GlobalKey<FormState>();

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
                          constraints: const BoxConstraints(maxWidth: 500),
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
                          constraints: const BoxConstraints(maxWidth: 500),
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
                          constraints: const BoxConstraints(maxWidth: 500),
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
                            var uservalidate =  await Dio().post('http://127.0.0.1:8000/api/v1/uservalidate/', data: {'email': _emailcontr.text});
                            setState(() {
                              uservalidator = uservalidate.data['validate'];
                            });
                            var phonevalidate =  await Dio().post('http://127.0.0.1:8000/api/v1/phonevalidate/', data: {'phone': _phonecontr.text});
                            setState(() {
                              phonevalidator = phonevalidate.data['validate'];
                            });
                            if (_formKey.currentState!.validate()){
                              var response = await Dio().post('http://127.0.0.1:8000/api/v1/profile/', data: {'email': _emailcontr.text, 'fio': _fiocontr.text, 'spec': _dropdownvalue == 'Дилер' ? 'D' : 'P', 'phone': _phonecontr.text});
                              if (response.data['success']){
                                Navigator.pushReplacement(
                                  context, 
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) => const SuccesReg(),
                                  )
                                );
                              }
                              else {
                                Navigator.pushReplacement(
                                  context, 
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) => const LoseReg(),
                                  )
                                );
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
                                onPressed: () {},
                                child: const Text(
                                  'Есть аккаунт?',
                                  style: TextStyle(color: Colors.white),
                                )),
                            TextButton(
                                onPressed: () {},
                                child: const Text(
                                  'Войти',
                                  style: TextStyle(color: Colors.white),
                                ))
                          ]),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(bottom: 40),
                        child: TextButton(
                            onPressed: () {},
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
                Navigator.pushNamed(context, '/auth');
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
              onPressed: null,
              child: const Text('Войти', style: TextStyle(color: Colors.black)),
            )
          )
        ],
      ),
    )
    );
  }
}
