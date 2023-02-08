import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:todotodo/auth/login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();


  String _dropdownvalue = 'Выберите специализацию';

  var items = ['Выберите специализацию','Дилер', 'Поставщик окон'];

  dynamic uservalidator;
  dynamic phonevalidator;

  final _formKey = GlobalKey<FormState>();

  Widget _logo(){
    return Container(
      padding: const EdgeInsets.only(top: 100, bottom: 20),
      child: Image.asset("assets/img/todotodo_logo.png")
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              children: <Widget>[
                _logo(),
                const Padding(
                  padding: EdgeInsets.only(bottom: 25),
                  child: Text('Зарегистрироваться', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Container(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButtonFormField(
                        dropdownColor: Colors.white,
                        isExpanded: true,
                        value: _dropdownvalue,
                        items: items.map((String item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintStyle: const TextStyle(fontSize: 16,fontWeight: FontWeight.w400, color: Color(0xff1C1C1E)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)
                          )
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            _dropdownvalue = newValue!;
                          });
                        },
                        validator: (value) => value == 'Выберите специализацию'
                          ? 'Выберите специализацию'
                          : null,
                      ),
                    )
                  )
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Container(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: TextFormField(
                      controller: _fullNameController,
                      obscureText: false,
                      style: const TextStyle(fontSize: 16),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Введите ФИО';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Введите ФИО',
                        hintStyle: const TextStyle(fontSize: 16,fontWeight: FontWeight.w400, color: Color(0xff1C1C1E)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)
                        )
                      ),
                    ),
                  )
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Container(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: TextFormField(
                      controller: _phoneController,
                      obscureText: false,
                      style: const TextStyle(fontSize: 16),
                      validator: (value) {
                        return phonevalidator;
                      },
                      decoration: InputDecoration(
                        hintText: 'Введите номер телефона',
                        hintStyle: const TextStyle(fontSize: 16,fontWeight: FontWeight.w400, color: Color(0xff1C1C1E)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)
                        )
                      ),
                    ),
                  )
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: Container(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: TextFormField(
                      controller: _emailController,
                      obscureText: false,
                      style: const TextStyle(fontSize: 16),
                      validator: (value) {
                        return uservalidator;
                      },
                      decoration: InputDecoration(
                        hintText: 'Введите E-mail',
                        hintStyle: const TextStyle(fontSize: 16,fontWeight: FontWeight.w400, color: Color(0xff1C1C1E)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)
                        )
                      ),
                    ),
                  )
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const Privacy()));
                  }, child: const Text('Пользовательское соглашение', style: TextStyle(fontSize: 12, color: Color.fromARGB(255, 41, 38, 38), fontWeight: FontWeight.w400)))
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15,bottom: 10),
                  child: SizedBox(
                    width: 400,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color(0xff15CE73))),
                      onPressed: () async {
                        var uservalidate =  await Dio().post('https://xn----gtbdlmdrgbq5j.xn--p1ai/api/v1/uservalidate/', data: {'email': _emailController.text});
                        setState(() {
                          uservalidator = uservalidate.data['validate'];
                        });
                        var phonevalidate =  await Dio().post('https://xn----gtbdlmdrgbq5j.xn--p1ai/api/v1/phonevalidate/', data: {'phone': _phoneController.text});
                        setState(() {
                          phonevalidator = phonevalidate.data['validate'];
                        });
                        if (_formKey.currentState!.validate()){
                          var response = await Dio().post('https://xn----gtbdlmdrgbq5j.xn--p1ai/api/v1/signup/', data: {'email': _emailController.text, 'fio': _fullNameController.text, 'spec': _dropdownvalue == 'Дилер' ? 'D' : 'P', 'phone': _phoneController.text});
                          if (response.data['success']){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const SuccesReg()));
                          }
                          else {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const LoseReg()));
                          }
                        }
                      },
                      child: const Text('Зарегистрироваться', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Есть аккаунт?', style: TextStyle(color: Color(0xff1C1C1E), fontSize: 14, fontWeight: FontWeight.w400)),
                    TextButton(onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const Login()));
                    }, child: const Text('Войти', style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400, color: Color(0xff15CE73))))
                  ],
                )
              ],
            ),
          )
        )
      )
    );
  }
}

class Privacy extends StatefulWidget {
  const Privacy({super.key});

  @override
  State<Privacy> createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25, right: 40),
                      child: IconButton(onPressed: () {Navigator.pop(context);}, icon: const Icon(Icons.arrow_back_ios)),
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        text: 'Условия использования\nсервиса',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(text: " Todotodo", style: TextStyle(color: Color(0xff15CE73), fontSize: 16, fontWeight: FontWeight.w400))
                        ],
                      )
                    )
                  ],
                ),
                FutureBuilder(
                  future: Future.delayed(const Duration(milliseconds: 150)).then((value) {
                    return rootBundle.loadString('assets/privacy_policy.md');
                  }),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Markdown(
                        shrinkWrap: true,
                        data: snapshot.data!,
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class SuccesReg extends StatelessWidget {
  const SuccesReg({super.key});

  Widget _logo(){
    return Container(
      padding: const EdgeInsets.only(top: 100, bottom: 20),
      child: Image.asset("assets/img/todotodo_logo.png")
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            _logo(),
            const Text('Вы успешно прошли регистрацию пароль отпрален на указанный вами E-mail',textAlign: TextAlign.center, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color(0xff15CE73))),
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const Login()));
                },
                child: const Text('Войти', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
              ),
            ),
          ]
        )
      ),
    );
  }
}


class LoseReg extends StatelessWidget {
  const LoseReg({super.key});

  Widget _logo(){
    return Container(
      padding: const EdgeInsets.only(top: 100, bottom: 20),
      child: Image.asset("assets/img/todotodo_logo.png")
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            _logo(),
            const Text('Не удалось пройти регистрацию попробуйте снова',textAlign: TextAlign.center, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color(0xff15CE73))),
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const Register()));
                },
                child: const Text('Регистрация', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
              ),
            ),
          ]
        )
      ),
    );
  }
}