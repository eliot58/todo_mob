import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todotodo/auth/login.dart';
import 'package:todotodo/custom_icons.dart';
import 'package:todotodo/provider/archive.dart';
import 'package:todotodo/provider/orders.dart';
import 'package:todotodo/provider/profile.dart';
import 'package:todotodo/provider/works.dart';

class Balance extends StatefulWidget {
  const Balance({super.key});

  @override
  State<Balance> createState() => _BalanceState();
}

class _BalanceState extends State<Balance> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  dynamic _items = [];
  

  void _bottomTab (int index) async {
    if (index==0){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const ProviderOrders()));
    } else if (index==1) {
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const Balance()));
    } else if (index==2) {
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const ProviderWorks()));
    } else if (index==3) {
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const ProviderArchive()));
    } else if (index==4) {
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const ProviderProfile()));
    }
  }

  _setList() async {
    final SharedPreferences prefs = await _prefs;
    final String? token = prefs.getString('token');
    var response =  await Dio().get('https://xn----gtbdlmdrgbq5j.xn--p1ai/api/v1/balance/', options: Options(headers: {'Authorization': 'Token $token'}));
    if (!mounted) return;
    print(response.data);
    setState(() {
      _items = response.data;
    });
  }

  @override
  void initState() {
    super.initState();
    _setList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomNavigationBar(
        onTap: _bottomTab,
        currentIndex: 1,
        unSelectedColor: const Color(0xff8A8A8A
),
        selectedColor: const Color(0xff080696),
        items: <CustomNavigationBarItem>[
          CustomNavigationBarItem(
            icon: const Icon(CustomIcon.orders),
            title: const Text('Заказы')
          ),
          CustomNavigationBarItem(
            icon: const Icon(CustomIcon.wallet),
            title: const Text('Подписка')
          ),
          CustomNavigationBarItem(
            icon: const Icon(CustomIcon.redo),
            title: const Text('В работе')
          ),
          CustomNavigationBarItem(
            icon: const Icon(CustomIcon.archive),
            title: const Text('Архив')
          ),
          CustomNavigationBarItem(
            icon: const Icon(CustomIcon.bag),
            title: const Text('Профиль')
          )
        ]
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 100),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Image.asset('assets/img/provider-logo.png', width: 43, height: 43),
                ),
                const Text('Todotodo.поставщик', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Color(0xff080696
))),
                GestureDetector(
                  onTap: () async {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const Login()));
                    final SharedPreferences prefs = await _prefs;
                    final String? token = prefs.getString('token');
                    await prefs.remove('token');
                    Dio().get('https://xn----gtbdlmdrgbq5j.xn--p1ai/api/v1/auth/token/logout/', options: Options(headers: {'Authorization': 'Token $token'}));
                  },
                  child: const Icon(Icons.exit_to_app),
                )
              ]
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: _items.length,
                shrinkWrap: true, itemBuilder: (BuildContext context, int index) { 
                return Card(
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          color: const Color(0xffEBEBEB),
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                          child: Text(_items[index]['title'], textAlign: TextAlign.center, style: const TextStyle(fontSize: 16)),
                        ),
                        Center(
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                child: Text(_items[index]['price'].toString(), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Color(0xff080696))),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                child: Text(_items[index]['description'], textAlign: TextAlign.center, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                child: ElevatedButton(
                                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color(0xff15CE73))),
                                  onPressed: null, 
                                  child: const Text('Купить', style: TextStyle(color: Color(0xffffffff)))
                                ),
                              )
                            ],
                          ),
                        )
                      ]
                    ),
                  );
                },
              )
            )
          ],
        ),
      )
    );
  }
}