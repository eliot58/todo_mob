import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todotodo/auth/login.dart';
import 'package:todotodo/provider/archive.dart';
import 'package:todotodo/provider/orders.dart';
import 'package:todotodo/provider/profile.dart';
import 'package:todotodo/provider/send.dart';
import 'package:todotodo/provider/work.dart';

class Balance extends StatefulWidget {
  const Balance({super.key});

  @override
  State<Balance> createState() => _BalanceState();
}

class _BalanceState extends State<Balance> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Баланс"),
          backgroundColor: const Color(0xff090696),
        ),
        body: Container(
          padding: const EdgeInsets.only(top: 5),
          child: Column(
            children: <Widget>[
              const ListTile(
                title: Padding(
                  padding: EdgeInsets.only(bottom: 10, top: 10),
                  child: Text('Денег на счету', style: TextStyle(fontSize: 14)),
                ),
                subtitle: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text('0 ₽', style: TextStyle(fontSize: 36, color: Color(0xff05b169))),
                )
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    SizedBox(
                      width: 150,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: null,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(const Color(0xff1f5485))
                        ),
                        child: const Text('Счет')
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: null,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(const Color(0xff1f5485))
                        ),
                        child: const Text('Сбер')
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    SizedBox(
                      width: 150,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: null,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(const Color(0xff1f5485))
                        ),
                        child: const Text('Вопрос')
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: null,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(const Color(0xff19178b))
                        ),
                        child: const Text('10000')
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ),
        drawer: SizedBox(
          width: MediaQuery.of(context).size.width * 0.75,
          child: Drawer(
            backgroundColor: const Color(0xff07995c),
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 20, top: 20),
                  child: Image.asset("assets/img/todotodo_logo.png", width: 60, height: 60)
                ),
                ListTile(
                  title: const Text('Профиль', style: TextStyle(color: Colors.white)),
                  leading: const Icon(Icons.account_box, color: Colors.white),
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const ProviderProfile()));
                  }
                ),
                ListTile(
                  title: const Text('Баланс', style: TextStyle(color: Colors.white)),
                  leading: const Icon(Icons.monetization_on, color: Colors.white),
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const Balance()));
                  }
                ),
                ListTile(
                  title: const Text('Отправлено КП', style: TextStyle(color: Colors.white)),
                  leading: const Icon(Icons.send, color: Colors.white),
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const ProviderSend()));
                  }
                ),
                ListTile(
                  title: const Text('Заказы в регионе', style: TextStyle(color: Colors.white)),
                  leading: const Icon(Icons.receipt_long_outlined, color: Colors.white),
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const ProviderOrders()));
                  }
                ),
                ListTile(
                  title: const Text('В работе', style: TextStyle(color: Colors.white)),
                  leading: const Icon(Icons.work, color: Colors.white),
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const ProviderWork()));
                  }
                ),
                ListTile(
                  title: const Text('Архив', style: TextStyle(color: Colors.white)),
                  leading: const Icon(Icons.archive, color: Colors.white),
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const ProviderArchive()));
                  }
                ),
                ListTile(
                  title: const Text('Выход', style: TextStyle(color: Colors.white)),
                  leading: const Icon(Icons.exit_to_app, color: Colors.white),
                  onTap: () async {
                    final SharedPreferences prefs = await _prefs;
                    final String? token = prefs.getString('token');
                    await Dio().get('https://xn----gtbdlmdrgbq5j.xn--p1ai/api/v1/auth/token/logout/', options: Options(headers: {'Authorization': 'Token $token'}));
                    await prefs.remove('token');
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const Auth()));
                  }
                ),
              ],
            ),
          ),
        )

      ),
    );
  }
}