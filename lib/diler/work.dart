import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              ListTile(
                title: const Text('Профиль'),
                leading: const Icon(Icons.account_box),
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const DilerProfile()));
                }
              ),
              ListTile(
                title: const Text('Создать заказ'),
                leading: const Icon(Icons.create),
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const DilerCreate()));
                }
              ),
              ListTile(
                title: const Text('Мои заказы'),
                leading: const Icon(Icons.receipt_long_outlined),
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const DilerOrders()));
                }
              ),
              ListTile(
                title: const Text('В работе'),
                leading: const Icon(Icons.work),
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const DilerWork()));
                }
              ),
              ListTile(
                title: const Text('Архив'),
                leading: const Icon(Icons.archive),
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const DilerArchive()));
                }
              ),
              ListTile(
                title: const Text('Выход'),
                leading: const Icon(Icons.exit_to_app),
                onTap: () async {
                  final SharedPreferences prefs = await _prefs;
                  final String? token = prefs.getString('token');
                  await Dio().get('https://xn----gtbdlmdrgbq5j.xn--p1ai/api/v1/auth/token/logout/', options: Options(headers: {'Authorization': 'Token $token'}));
                  await prefs.remove('token');
                  Navigator.pushReplacementNamed(context, '/');
                }
              ),
            ],
          ),
        )

      ),
    );
  }
}