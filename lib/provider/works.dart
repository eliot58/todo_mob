import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todotodo/custom_icons.dart';
import 'package:todotodo/provider/archive.dart';
import 'package:todotodo/provider/balance.dart';
import 'package:todotodo/provider/orders.dart';
import 'package:todotodo/provider/profile.dart';
import 'package:url_launcher/url_launcher.dart';

class ProviderWorks extends StatefulWidget {
  const ProviderWorks({super.key});

  @override
  State<ProviderWorks> createState() => _ProviderWorksState();
}

class _ProviderWorksState extends State<ProviderWorks> {
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

  dynamic _worklist = [];
  dynamic _sendlist = [];

  bool setwork = false;
  bool setkp = false;

  _setWorks() async {
    final SharedPreferences prefs = await _prefs;
    final String? token = prefs.getString('token');
    var response =  await Dio().get('https://xn----gtbdlmdrgbq5j.xn--p1ai/api/v1/work/', options: Options(headers: {'Authorization': 'Token $token'}));
    if (!mounted) return;
    setState(() {
      _worklist = response.data;
      setwork = true;
    });
  }

  _setSend() async {
    final SharedPreferences prefs = await _prefs;
    final String? token = prefs.getString('token');
    var response =  await Dio().get('https://xn----gtbdlmdrgbq5j.xn--p1ai/api/v1/send_quantity/', options: Options(headers: {'Authorization': 'Token $token'}));
    if (!mounted) return;
    setState(() {
      _sendlist = response.data;
      setkp = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _setWorks();
    _setSend();
  }
  
  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          bottom: const TabBar(
            indicatorColor: Color(0xff080696),
            labelColor: Color(0xff080696),
            unselectedLabelColor: Color(0xff8A8A8A),
            tabs: [
              Text('В работе',style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
              Text('Отправлено КП',style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
            ],
          ),
          title: const Text('В работе',style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black)),
        ),
        bottomNavigationBar: CustomNavigationBar(
          onTap: _bottomTab,
          currentIndex: 2,
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
        backgroundColor: Colors.white,
        body: TabBarView(
          children: [
            setwork ? ListView.builder(
              physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: _worklist.length,
              itemBuilder: (BuildContext context, int index) {  
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  child: Card(
                    elevation: 16,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(color: Color(0xff080696))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      child: ListTile(
                        trailing: ElevatedButton(
                          onPressed: () async {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> const ProviderArchive()));
                            final SharedPreferences prefs = await _prefs;
                            final String? token = prefs.getString('token');
                            Dio().get('https://xn----gtbdlmdrgbq5j.xn--p1ai/api/v1/provider_check/${_worklist[index]["id"]}/', options: Options(headers: {'Authorization': 'Token $token'}));
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(const Color(0xff080696))
                          ),
                          child: const Text('принять', style: TextStyle(color: Colors.white))
                        ),
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
                                    TextSpan(text: _worklist[index]["date"],style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black))
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
                                    TextSpan(text: _worklist[index]["shape"],style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black))
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
                                    TextSpan(text: _worklist[index]["implement"],style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black))
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
                                    TextSpan(text: _worklist[index]["price"].toString(),style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black))
                                  ],
                                )
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const Text('Эскиз: ', style: TextStyle(color: Color(0xff080696))),
                                    Expanded(
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                          minimumSize: const Size(50, 10),
                                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          alignment: Alignment.centerLeft
                                        ),
                                        onPressed: () async {
                                          var url = Uri.parse('https://xn----gtbdlmdrgbq5j.xn--p1ai${_worklist[index]["scetch_url"]}');
                                          if (!await launchUrl(url)) {
                                            throw 'Could not launch $url';
                                          }
                                        },
                                        child: Text(Uri.decodeFull(_worklist[index]["scetch"]),overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.blue))
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Text('Ваше КП: ', style: TextStyle(color: Color(0xff080696))),
                                  Expanded(
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        minimumSize: const Size(50, 10),
                                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        alignment: Alignment.centerLeft,
                                      ),
                                      onPressed: () async {
                                        var url = Uri.parse('https://xn----gtbdlmdrgbq5j.xn--p1ai${_worklist[index]["file_url"]}');
                                        if (!await launchUrl(url)) {
                                          throw 'Could not launch $url';
                                        }
                                      },
                                      child: Text(Uri.decodeFull(_worklist[index]["file"]),overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.blue))
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    )
                  ),
                );
              },
            ) : const Center(child: CircularProgressIndicator()),
            setkp ? ListView.builder(
              physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: _sendlist.length,
              itemBuilder: (BuildContext context, int index) {  
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: Card(
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
                                    TextSpan(text: _sendlist[index]["date"],style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black))
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
                                    TextSpan(text: _sendlist[index]["shape"],style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black))
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
                                    TextSpan(text: _sendlist[index]["implement"],style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black))
                                  ],
                                )
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: RichText(
                                text: TextSpan(
                                  text: 'Стоимость: ',
                                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff080696)),
                                  children: <TextSpan>[
                                    TextSpan(text: _sendlist[index]["order_price"].toString(),style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black))
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
                                    TextSpan(text: _sendlist[index]["quantity_shape"],style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black))
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
                                    TextSpan(text: _sendlist[index]["quantity_impl"],style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black))
                                  ],
                                )
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: RichText(
                                text: TextSpan(
                                  text: 'Желаемая цена: ',
                                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff080696)),
                                  children: <TextSpan>[
                                    TextSpan(text: _sendlist[index]["quantity_price"].toString(),style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black))
                                  ],
                                )
                              ),
                            ),
                          ],
                        ),
                      )
                    )
                  ),
                );
              },
            ) : const Center(child: CircularProgressIndicator())
          ]
        )
      ),
    );
  }
}