import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todotodo/domain/state/register/register_state.dart';
import 'package:todotodo/internal/dependencies/register_module.dart';
import 'package:todotodo/presentation/auth/login.dart';

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

  var items = ['Выберите специализацию', 'Дилер', 'Поставщик окон'];

  late RegisterState registerState;

  @override
  void initState() {
    super.initState();
    registerState = RegisterModule.registerState();
  }

  final _formKey = GlobalKey<FormState>();

  Widget _logo() {
    return Container(
        padding: const EdgeInsets.only(top: 100, bottom: 20),
        child: Image.asset("assets/img/todotodo_logo.png"));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
              child: Form(
                  key: _formKey,
                  child: Center(
                    child: Observer(builder: (_) {
                      return Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          registerState.isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : Container(),
                          Column(
                            children: <Widget>[
                              _logo(),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 25),
                                child: Text('Зарегистрироваться',
                                    style: TextStyle(
                                        fontSize: 25.sp,
                                        fontWeight: FontWeight.w700)),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: Container(
                                      padding: const EdgeInsets.only(
                                          left: 15, right: 15),
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
                                              hintStyle: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: const Color(0xff1C1C1E)),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8))),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              _dropdownvalue = newValue!;
                                            });
                                          },
                                          validator: (value) =>
                                              value == 'Выберите специализацию'
                                                  ? 'Выберите специализацию'
                                                  : null,
                                        ),
                                      ))),
                              Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 15),
                                    child: TextFormField(
                                      controller: _fullNameController,
                                      obscureText: false,
                                      style: TextStyle(fontSize: 16.sp),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Введите ФИО';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          hintText: 'Введите ФИО',
                                          hintStyle: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w400,
                                              color: const Color(0xff1C1C1E)),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8))),
                                    ),
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 15),
                                    child: TextFormField(
                                      controller: _phoneController,
                                      obscureText: false,
                                      style: TextStyle(fontSize: 16.sp),
                                      validator: (value) {
                                        return registerState.phonevalidator;
                                      },
                                      decoration: InputDecoration(
                                          hintText: 'Введите номер телефона',
                                          hintStyle: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w400,
                                              color: const Color(0xff1C1C1E)),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8))),
                                    ),
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(bottom: 25),
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 15),
                                    child: TextFormField(
                                      controller: _emailController,
                                      obscureText: false,
                                      style: TextStyle(fontSize: 16.sp),
                                      validator: (value) {
                                        return registerState.uservalidator;
                                      },
                                      decoration: InputDecoration(
                                          hintText: 'Введите E-mail',
                                          hintStyle: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w400,
                                              color: const Color(0xff1C1C1E)),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8))),
                                    ),
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(bottom: 25),
                                  child: TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Privacy()));
                                      },
                                      child: Text(
                                          'Пользовательское соглашение',
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              color: const Color.fromARGB(
                                                  255, 41, 38, 38),
                                              fontWeight: FontWeight.w400)))),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, bottom: 10),
                                child: SizedBox(
                                  width: 400,
                                  height: 50,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                const Color(0xff15CE73))),
                                    onPressed: _register,
                                    child: Text('Зарегистрироваться',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text('Есть аккаунт?',
                                      style: TextStyle(
                                          color: const Color(0xff1C1C1E),
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400)),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Login()));
                                      },
                                      child: Text('Войти',
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                              color: const Color(0xff15CE73))))
                                ],
                              )
                            ],
                          ),
                        ],
                      );
                    }),
                  )))),
    );
  }

  _register() async {
    await registerState.register(
        email: _emailController.text,
        phone: _phoneController.text,
        spec: _dropdownvalue == 'Дилер' ? 'D' : 'P',
        fullName: _fullNameController.text);
    if (_formKey.currentState!.validate()) {
      if (registerState.registerData!){
        if (!mounted) return;
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const SuccesReg()));
      } else {
        if (!mounted) return;
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const LoseReg()));
      }
    }
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
    return SafeArea(
      child: Scaffold(
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
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back_ios)),
                      ),
                      RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: 'Условия использования\nсервиса',
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                            children: <TextSpan>[
                              TextSpan(
                                  text: " Todotodo",
                                  style: TextStyle(
                                      color: const Color(0xff15CE73),
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400))
                            ],
                          ))
                    ],
                  ),
                  FutureBuilder(
                    future: Future.delayed(const Duration(milliseconds: 150))
                        .then((value) {
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
      ),
    );
  }
}

class SuccesReg extends StatelessWidget {
  const SuccesReg({super.key});

  Widget _logo() {
    return Container(
        padding: const EdgeInsets.only(top: 100, bottom: 20),
        child: Image.asset("assets/img/todotodo_logo.png"));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
            child: Column(children: <Widget>[
          _logo(),
          Text(
              'Вы успешно прошли регистрацию пароль отпрален на указанный вами E-mail',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500)),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xff15CE73))),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const Login()));
              },
              child: Text('Войти',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600)),
            ),
          ),
        ])),
      ),
    );
  }
}

class LoseReg extends StatelessWidget {
  const LoseReg({super.key});

  Widget _logo() {
    return Container(
        padding: const EdgeInsets.only(top: 100, bottom: 20),
        child: Image.asset("assets/img/todotodo_logo.png"));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
            child: Column(children: <Widget>[
          _logo(),
          Text('Не удалось пройти регистрацию попробуйте снова',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500)),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xff15CE73))),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const Register()));
              },
              child: Text('Регистрация',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600)),
            ),
          ),
        ])),
      ),
    );
  }
}
