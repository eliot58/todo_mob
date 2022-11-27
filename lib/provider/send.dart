import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todotodo/auth/login.dart';
import 'package:todotodo/provider/archive.dart';
import 'package:todotodo/provider/balance.dart';
import 'package:todotodo/provider/orders.dart';
import 'package:todotodo/provider/profile.dart';
import 'package:todotodo/provider/work.dart';

class ProviderSend extends StatefulWidget {
  const ProviderSend({super.key});

  @override
  State<ProviderSend> createState() => _ProviderSendState();
}

class _ProviderSendState extends State<ProviderSend> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  dynamic _orderlist = [];

  _setList() async {
    final SharedPreferences prefs = await _prefs;
    final String? token = prefs.getString('token');
    var response =  await Dio().get('https://xn----gtbdlmdrgbq5j.xn--p1ai/api/v1/send_quantity/', options: Options(headers: {'Authorization': 'Token $token'}));
    setState(() {
      _orderlist = response.data;
    });
  }

  @override
  void initState() {
    super.initState();
    _setList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Мои предложения"),
          backgroundColor: const Color(0xff090696),
        ),
        body: Container(
          color: Colors.white,
          child: ListView.builder(
            itemCount: _orderlist.length,
            itemBuilder: (BuildContext context, int index){
              return Card(
                child: ListTile(
                  title: const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text('Предложение', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(_orderlist[index]['date'], style: const TextStyle(color: Colors.black)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text('Количесто окон: ${_orderlist[index]["amount_window"]}', style: const TextStyle(color: Colors.black)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text('Профиль: ${_orderlist[index]["shape"]}', style: const TextStyle(color: Colors.black)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text('Фурнитура: ${_orderlist[index]["implement"]}', style: const TextStyle(color: Colors.black)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text('Стоимость: ${_orderlist[index]["order_price"]}', style: const TextStyle(color: Colors.black)),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text('Заказ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text('Профиль: ${_orderlist[index]["quantity_shape"]}', style: const TextStyle(color: Colors.black)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text('Фурнитура: ${_orderlist[index]["quantity_impl"]}', style: const TextStyle(color: Colors.black)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text('Желаемая цена: ${_orderlist[index]["quantity_price"]}', style: const TextStyle(color: Colors.black)),
                      ),
                    ],
                  ),
                  onTap: null,
                  trailing: Center(
                    child: IconButton(
                      icon: const Icon(Icons.delete), 
                      onPressed: () async {
                        final SharedPreferences prefs = await _prefs;
                        final String? token = prefs.getString('token');
                        var response =  await Dio().delete('https://xn----gtbdlmdrgbq5j.xn--p1ai/api/v1/quatitydel/${_orderlist[index]["id"]}/', options: Options(headers: {'Authorization': 'Token $token'}));
                        if (response.data['detail']){
                          setState(() {
                            _orderlist.removeAt(index);
                          });
                        }
                      }
                    ),
                  ),
                ),
              );
            },
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