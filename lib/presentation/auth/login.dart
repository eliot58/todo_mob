import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:todotodo/custom_icons.dart';
import 'package:todotodo/domain/state/login/login_state.dart';
import 'package:todotodo/internal/dependencies/login_module.dart';
import 'package:todotodo/presentation/auth/register.dart';
import 'package:todotodo/presentation/diler/orders.dart';
import 'package:todotodo/presentation/provider/orders.dart';
import 'package:url_launcher/url_launcher.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late LoginState loginState;

  @override
  void initState() {
    super.initState();
    loginState = LoginModule.loginState();
  }

  final _formKey = GlobalKey<FormState>();

  Widget _logo() {
    return Container(padding: const EdgeInsets.only(top: 100, bottom: 20), child: Image.asset("assets/img/todotodo_logo.png"));
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
                  loginState.isLoading ? const Center(child: CircularProgressIndicator()) : Container(),
                  Column(
                    children: <Widget>[
                      _logo(),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 25),
                        child: Text('Войти', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700)),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Container(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: TextFormField(
                              controller: _emailController,
                              style: const TextStyle(fontSize: 16),
                              decoration: InputDecoration(
                                  hintText: 'email address', prefixIcon: const Icon(CustomIcon.sms, color: Color(0xff1C1C1E)), hintStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xff1C1C1E)), border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
                            ),
                          )),
                      Padding(
                          padding: const EdgeInsets.only(bottom: 25),
                          child: Container(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: TextFormField(
                              controller: _passwordController,
                              obscureText: loginState.passwordObscure,
                              style: const TextStyle(fontSize: 16),
                              validator: (value) {
                                return loginState.passwordvalidator;
                              },
                              decoration: InputDecoration(
                                  hintText: 'password',
                                  suffixIcon: IconButton(
                                    icon: const Icon(Icons.remove_red_eye_sharp),
                                    onPressed: loginState.obscureChange,
                                  ),
                                  prefixIcon: const Icon(CustomIcon.lock, color: Color(0xff1C1C1E)),
                                  hintStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xff1C1C1E)),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
                            ),
                          )),
                      Padding(
                          padding: const EdgeInsets.only(bottom: 25),
                          child: Container(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                              Row(
                                children: [
                                  Checkbox(
                                    value: loginState.remember,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        loginState.remember = value!;
                                      });
                                    },
                                  ),
                                  const Text('Запомнить меня', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
                                ],
                              ),
                              TextButton(
                                  onPressed: () async {
                                    var url = Uri.parse('http://127.0.0.1:8000/password_reset/');
                                    if (!await launchUrl(url)) {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                  child: const Text('Забыли пароль?', style: TextStyle(fontSize: 14, color: Color(0xff15CE73), fontWeight: FontWeight.w600)))
                            ]),
                          )),
                      Container(
                        padding: const EdgeInsets.only(bottom: 60, left: 15, right: 15),
                        child: SizedBox(
                          width: 400,
                          height: 50,
                          child: ElevatedButton(
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color(0xff15CE73))),
                            onPressed: _login,
                            child: const Text('Войти', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          const Text('Ещё нет аккаунта?', style: TextStyle(color: Color(0xff1C1C1E), fontSize: 14, fontWeight: FontWeight.w400)),
                          TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Register()));
                              },
                              child: const Text('Зарегистрироваться', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff15CE73))))
                        ],
                      )
                    ],
                  ),
                ],
              );
            }),
          ),
        )),
      ),
    );
  }

  _login() async {
    await loginState.login(email: _emailController.text, password: _passwordController.text);

    if (_formKey.currentState!.validate()) {
      if (loginState.loginData!['spec'] == 'D') {
        if (!mounted) return;
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DilerOrders()));
      } else {
        if (!mounted) return;
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ProviderOrders()));
      }
    }
  }
}
