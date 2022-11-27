import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todotodo/auth/login.dart';
import 'package:todotodo/diler/archive.dart';
import 'package:todotodo/diler/card.dart';
import 'package:todotodo/diler/create.dart';
import 'package:todotodo/diler/orders.dart';
import 'package:todotodo/diler/profile.dart';
import 'package:todotodo/diler/work.dart';
import 'package:url_launcher/url_launcher.dart';


class DilerOrder extends StatefulWidget {
  final int id;

  const DilerOrder({
    super.key,
    required this.id,
  });



  @override
  State<DilerOrder> createState() => _DilerOrderState();
}

class _DilerOrderState extends State<DilerOrder> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  
  
  dynamic _orderdata = {
    'address': '',
    'shape': '',
    'implement': '',
    'type_pay': '',
    'type_delivery': '',
    'price': '',
    'comment': '',
    'kp': []
  };
  

  _setdata() async {
    final SharedPreferences prefs = await _prefs;
    final String? token = prefs.getString('token');
    var response =  await Dio().get('https://xn----gtbdlmdrgbq5j.xn--p1ai/api/v1/order/${widget.id}/', options: Options(headers: {'Authorization': 'Token $token'}));
    setState(() {
      _orderdata = response.data;
    });
  }

  @override
  void initState() {
    super.initState();
    _setdata();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Инфо о заказе"),
          backgroundColor: const Color(0xff07995c),
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Card(
                    child: ListTile(
                      title: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(_orderdata['address'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Row(
                              children: <Widget>[
                                const Text('Тип оплаты: ', style: TextStyle(color: Colors.black)),
                                Text(_orderdata['type_pay'], style: const TextStyle(color: Colors.black)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Row(
                              children: <Widget>[
                                const Text('Тип доставки: ', style: TextStyle(color: Colors.black)),
                                Text(_orderdata['type_delivery'], style: const TextStyle(color: Colors.black)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Text('Профиль: ${_orderdata["shape"]}', style: const TextStyle(color: Colors.black)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Text('Фурнитура: ${_orderdata["implement"]}', style: const TextStyle(color: Colors.black)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Text('Желаемая сумма: ${_orderdata["price"]}', style: const TextStyle(color: Colors.black)),
                          )
                        ]
                      )
                    ),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: const Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text('Комментарий', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(_orderdata['comment'], style: const TextStyle(color: Colors.black)),
                    ),
                  )
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  child: Text('Предложение поставщиков', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                ),
                ListView.builder(
                  itemCount: _orderdata['kp'].length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index){
                    return Card(
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: <Widget>[
                              const Text('Заказчик: ', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
                              TextButton(
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: const Size(50, 30),
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  alignment: Alignment.centerLeft
                                ),
                                onPressed: () async {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> CompanyCard(id: _orderdata["kp"][index]["author_id"])));
                                },
                                child: Text(_orderdata["kp"][index]["author_company"], style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 16))
                              ),
                            ],
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Text('Дата : ${_orderdata["kp"][index]["date_create"]}', style: const TextStyle(color: Colors.black)),
                                  ),
                                  Text('Поставка : ${_orderdata["kp"][index]["date"]}', style: const TextStyle(color: Colors.black)),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Text('Профиль: ${_orderdata["kp"][index]["shape"]}', style: const TextStyle(color: Colors.black)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Text('Фурнитура: ${_orderdata["kp"][index]["implement"]}', style: const TextStyle(color: Colors.black)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Row(
                                children: <Widget>[
                                  const Text('Предложение: ', style: TextStyle(color: Colors.black)),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      minimumSize: const Size(50, 30),
                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      alignment: Alignment.centerLeft
                                    ),
                                    onPressed: () async {
                                      var url = Uri.parse('https://xn----gtbdlmdrgbq5j.xn--p1ai${_orderdata["kp"][index]["fileurl"]}');
                                      if (!await launchUrl(url)) {
                                        throw 'Could not launch $url';
                                      }
                                    },
                                    child: Text(_orderdata["kp"][index]["file"], style: const TextStyle(color: Colors.blue))
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Text('Желаемая сумма: ${_orderdata["kp"][index]["price"]}', style: const TextStyle(color: Colors.black)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: ElevatedButton(
                                onPressed: _orderdata["kp"][index]["isresponse"] ? null : () async {
                                  final SharedPreferences prefs = await _prefs;
                                  final String? token = prefs.getString('token');
                                  var response =  await Dio().get('https://xn----gtbdlmdrgbq5j.xn--p1ai/api/v1/response/${_orderdata["kp"][index]["id"]}/', options: Options(headers: {'Authorization': 'Token $token'}));
                                  if (response.data['detail']=='success'){
                                    setState(() {
                                      _orderdata["kp"][index]["isresponse"] = true;
                                    });
                                  }
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(const Color(0xff07995c))
                                ),
                                child: Text(_orderdata["kp"][index]["isresponse"] ? 'заказано' : 'заказать', style: const TextStyle(color: Colors.white))
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                )
              ],
            )
          ),
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