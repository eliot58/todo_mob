import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todotodo/auth/register.dart';
import 'package:todotodo/diler/orders.dart';
import 'package:todotodo/provider/orders.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:todotodo/custom_icons.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool rememberme = false;

  dynamic passwordvalidator;

  bool passwordobscure = true;


  final _formKey = GlobalKey<FormState>();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  

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
                  child: Text('Войти', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Container(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: TextFormField(
                      controller: _emailController,
                      obscureText: false,
                      style: const TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                        hintText: 'email address',
                        prefixIcon: const Icon(CustomIcon.sms, color: Color(0xff1C1C1E)),
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
                      controller: _passwordController,
                      obscureText: passwordobscure,
                      style: const TextStyle(fontSize: 16),
                      validator: (value) {
                        return passwordvalidator;
                      },
                      decoration: InputDecoration(
                        hintText: 'password',
                        suffixIcon: IconButton(icon: const Icon(Icons.remove_red_eye_sharp), onPressed: () {
                          setState(() {
                            passwordobscure = !passwordobscure;
                          });
                        },),
                        prefixIcon: const Icon(CustomIcon.lock, color: Color(0xff1C1C1E)),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            Checkbox(
                              value: rememberme,
                              onChanged: (bool? value) {
                                setState(() {
                                  rememberme = value!;
                                });
                              },
                            ),
                            const Text('Запомнить меня', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
                          ],
                        ),
                        TextButton(onPressed: () async {
                          var url = Uri.parse('https://xn----gtbdlmdrgbq5j.xn--p1ai/password_reset/');
                          if (!await launchUrl(url)) {
                            throw 'Could not launch $url';
                          }
                        }, child: const Text('Забыли пароль?', style: TextStyle(fontSize: 14, color: Color(0xff15CE73), fontWeight: FontWeight.w600)))
                      ]
                    ),
                  )
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 60, left: 15, right: 15),
                  child: SizedBox(
                    width: 400,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color(0xff15CE73))),
                      onPressed: () async{
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
                      child: const Text('Войти', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    const Text('Ещё нет аккаунта?', style: TextStyle(color: Color(0xff1C1C1E), fontSize: 14, fontWeight: FontWeight.w400)),
                    TextButton(onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const Register()));
                    }, child: const Text('Зарегистрироваться', style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400, color: Color(0xff15CE73))))
                  ],
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}