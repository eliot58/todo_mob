import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todotodo/auth/login.dart';
import 'package:todotodo/custom_icons.dart';
import 'package:todotodo/provider/balance.dart';
import 'package:todotodo/provider/orders.dart';
import 'package:todotodo/provider/profile.dart';
import 'package:todotodo/provider/works.dart';

class ProviderArchive extends StatefulWidget {
  const ProviderArchive({super.key});

  @override
  State<ProviderArchive> createState() => _ProviderArchiveState();
}

class _ProviderArchiveState extends State<ProviderArchive> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

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

  dynamic _orderlist = [];

  bool setarchive = false;

  _setList() async {
    final SharedPreferences prefs = await _prefs;
    final String? token = prefs.getString('token');
    var response =  await Dio().get('https://xn----gtbdlmdrgbq5j.xn--p1ai/api/v1/archive/', options: Options(headers: {'Authorization': 'Token $token'}));
    if (!mounted) return;
    setState(() {
      _orderlist = response.data;
      setarchive = true;
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
        currentIndex: 3,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 100, bottom: 25),
                child: Center(
                  child: Row(
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
                ),
              ),
              setarchive ? ListView.builder(
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: _orderlist.length,
                itemBuilder: (BuildContext context, int index) {  
                  return Card(
                    elevation: 16,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(color: Color(0xff080696))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      child: ListTile(
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: RichText(
                                text: TextSpan(
                                  text: 'Дата: ',
                                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff080696)),
                                  children: <TextSpan>[
                                    TextSpan(text: _orderlist[index]["date"],style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black))
                                  ],
                                )
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: RichText(
                                text: TextSpan(
                                  text: 'Профиль: ',
                                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff080696)),
                                  children: <TextSpan>[
                                    TextSpan(text: _orderlist[index]["shape"],style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black))
                                  ],
                                )
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: RichText(
                                text: TextSpan(
                                  text: 'Фурнитура: ',
                                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff080696)),
                                  children: <TextSpan>[
                                    TextSpan(text: _orderlist[index]["implement"],style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black))
                                  ],
                                )
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: RichText(
                                text: TextSpan(
                                  text: 'Желаемая сумма: ',
                                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff080696)),
                                  children: <TextSpan>[
                                    TextSpan(text: _orderlist[index]["price"].toString(),style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black))
                                  ],
                                )
                              ),
                            ),
                          ],
                        ),
                      )
                    )
                  );
                },
              ) : const Center(child: CircularProgressIndicator())
            ],
          ),
        ),
      ),
    );
  }
}