

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DilerArchive extends StatefulWidget {
  const DilerArchive({super.key});

  @override
  State<DilerArchive> createState() => _DilerArchiveState();
}

class _DilerArchiveState extends State<DilerArchive> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Архив"),
          backgroundColor: const Color(0xff07995c),
        ),
        body: Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              Card(
                child: ListTile(
                  title: const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text('Naryn Chorobaev 3', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text('Заказчик: Aimedin Chorobaev', style: TextStyle(color: Colors.black)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text('16.11.2003', style: TextStyle(color: Colors.black)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text('Профиль: Rehau Blitz New', style: TextStyle(color: Colors.black)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text('Фурнитура: ROTO NX', style: TextStyle(color: Colors.black)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text('Желаемая сумма: 5000', style: TextStyle(color: Colors.black)),
                      )
                    ],
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  title: const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text('Naryn Chorobaev 3', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text('Заказчик: Aimedin Chorobaev', style: TextStyle(color: Colors.black)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text('16.11.2003', style: TextStyle(color: Colors.black)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text('Профиль: Rehau Blitz New', style: TextStyle(color: Colors.black)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text('Фурнитура: ROTO NX', style: TextStyle(color: Colors.black)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text('Желаемая сумма: 5000', style: TextStyle(color: Colors.black)),
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                child: UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(color: Color(0xff07995c)),
                  accountName: const Text('aimedinc horobearv'),
                  accountEmail: const Text('chaimedin2003@gmail.com'),
                  currentAccountPicture: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.red,
                    )
                  )
                ),
              ),
              ListTile(
                title: const Text('Профиль'),
                leading: const Icon(Icons.account_box),
                onTap: (){
                  Navigator.pushReplacementNamed(context, '/diler_profile');
                }
              ),
              ListTile(
                title: const Text('Создать заказ'),
                leading: const Icon(Icons.create),
                onTap: (){
                  Navigator.pushReplacementNamed(context, '/diler_order_create');
                }
              ),
              ListTile(
                title: const Text('Заказы в регионе'),
                leading: const Icon(Icons.receipt_long_outlined),
                onTap: (){
                  Navigator.pushReplacementNamed(context, '/diler_orders');
                }
              ),
              ListTile(
                title: const Text('В работе'),
                leading: const Icon(Icons.work),
                onTap: (){
                  Navigator.pushReplacementNamed(context, '/diler_work');
                }
              ),
              ListTile(
                title: const Text('Архив'),
                leading: const Icon(Icons.archive),
                onTap: (){
                  Navigator.pushReplacementNamed(context, '/diler_archive');
                }
              ),
              ListTile(
                title: const Text('Выход'),
                leading: const Icon(Icons.exit_to_app),
                onTap: () async {
                  final SharedPreferences prefs = await _prefs;
                  final String? token = prefs.getString('token');
                  await Dio().get('http://127.0.0.1:8000/api/v1/auth/token/logout/', options: Options(headers: {'Authorization': 'Token $token'}));
                  await prefs.remove('token');
                }
              ),
            ],
          ),
        )

      ),
    );
  }
}