import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todotodo/auth/login.dart';
import 'package:todotodo/diler/archive.dart';
import 'package:todotodo/diler/create.dart';
import 'package:todotodo/diler/orders.dart';
import 'package:todotodo/diler/profile.dart';


class DilerWork extends StatefulWidget {
  const DilerWork({super.key});

  @override
  State<DilerWork> createState() => _DilerWorkState();
}

class _DilerWorkState extends State<DilerWork> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  dynamic _orderlist = [];

  _setList() async {
    final SharedPreferences prefs = await _prefs;
    final String? token = prefs.getString('token');
    var response =  await Dio().get('https://xn----gtbdlmdrgbq5j.xn--p1ai/api/v1/work/', options: Options(headers: {'Authorization': 'Token $token'}));
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
          title: const Text("Заказы в работе"),
          backgroundColor: const Color(0xff07995c),
        ),
        body: Container(
          color: Colors.white,
          child: ListView.builder(
            itemCount: _orderlist.length,
            itemBuilder: (BuildContext context, int index){
              return Card(
                child: ListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(_orderlist[index]['address'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text('Дата: ${_orderlist[index]["date"]}', style: const TextStyle(color: Colors.black)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text('Количество КП: ${_orderlist[index]["kpcount"]}', style: const TextStyle(color: Colors.black)),
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
                        child: Text('Желаемая сумма: ${_orderlist[index]["price"]}', style: const TextStyle(color: Colors.black)),
                      )
                    ],
                  ),
                  onTap: null,
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
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const DilerProfile()));
                  }
                ),
                ListTile(
                  title: const Text('Создать заказ', style: TextStyle(color: Colors.white)),
                  leading: const Icon(Icons.create, color: Colors.white),
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const DilerCreate()));
                  }
                ),
                ListTile(
                  title: const Text('Мои заказы', style: TextStyle(color: Colors.white)),
                  leading: const Icon(Icons.receipt_long_outlined, color: Colors.white),
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const DilerOrders()));
                  }
                ),
                ListTile(
                  title: const Text('В работе', style: TextStyle(color: Colors.white)),
                  leading: const Icon(Icons.work, color: Colors.white),
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const DilerWork()));
                  }
                ),
                ListTile(
                  title: const Text('Архив', style: TextStyle(color: Colors.white)),
                  leading: const Icon(Icons.archive, color: Colors.white),
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const DilerArchive()));
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