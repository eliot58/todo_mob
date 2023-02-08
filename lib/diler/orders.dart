import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todotodo/auth/login.dart';
import 'package:todotodo/custom_icons.dart';
import 'package:todotodo/diler/archive.dart';
import 'package:todotodo/diler/order.dart';
import 'package:todotodo/diler/ordercreate.dart';
import 'package:todotodo/diler/profile.dart';
import 'package:todotodo/diler/works.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';

class DilerOrders extends StatefulWidget {
  const DilerOrders({super.key});

  @override
  State<DilerOrders> createState() => _DilerOrdersState();
}

class _DilerOrdersState extends State<DilerOrders> {

  double _startPrice = 500;
  double _endPrice = 200000;

  bool _new = true;
  dynamic _ordersList;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  _setList() async {
    final SharedPreferences prefs = await _prefs;
    final String? token = prefs.getString('token');
    var response =  await Dio().get('https://xn----gtbdlmdrgbq5j.xn--p1ai/api/v1/orders/', options: Options(headers: {'Authorization': 'Token $token'}));
    if (!mounted) return;
    setState(() {
      _ordersList = response.data;
    });
  }

  @override
  void initState() {
    super.initState();
    _setList();
  }

  search(s,ss){
    s = s.toLowerCase();
    ss = ss.toLowerCase();
    return s.indexOf(ss) != -1 ? true : false;
  }


  void _bottomTab (int index) async {
    if (index==0){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const DilerOrders()));
    } else if (index==1) {
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const DilerWorks()));
    } else if (index==2) {
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const OrderCreate()));
    } else if (index==3) {
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const DilerArchive()));
    } else if (index==4) {
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const DilerProfile()));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomNavigationBar(
        elevation: 160,
        borderRadius: const Radius.circular(15),
        onTap: _bottomTab,
        unSelectedColor: const Color(0xff8A8A8A
),
        selectedColor: const Color(0xff15CE73),
        currentIndex: 0,
        items: <CustomNavigationBarItem>[
          CustomNavigationBarItem(
            icon: const Icon(CustomIcon.orders),
            title: const Text('Заказы')
          ),
          CustomNavigationBarItem(
            icon: const Icon(CustomIcon.works),
            title: const Text('В работе')
          ),
          CustomNavigationBarItem(
            icon: SvgPicture.asset('assets/img/create.svg'),
            title: const Text('Создать')
          ),
          CustomNavigationBarItem(
            icon: const Icon(CustomIcon.archive),
            title: const Text('Архив')
          ),
          CustomNavigationBarItem(
            icon: const Icon(CustomIcon.profile),
            title: const Text('Профиль')
          )
        ]
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 100, bottom: 25),
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Image.asset('assets/img/todotodo_logo.png', width: 43, height: 43),
                      ),
                      const Text('Todotodo.дилеры', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Color(0xff15CE73
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
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: SizedBox(
                  height: 38,
                  child: TextField(
                    textInputAction: TextInputAction.search,
                    onSubmitted: (value) {
                      setState(() {
                        _ordersList = _ordersList.where((element) => search(element['shape'],value) || search(element['implement'],value) || search(element['address'],value)).toList();
                      });
                    },
                    textAlignVertical: TextAlignVertical.bottom,
                    obscureText: false,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromARGB(118, 118, 128, 120),
                      hintText: 'Search',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(icon: const Icon(CustomIcon.filter, color: Color(0xff080696)), onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context){
                            return StatefulBuilder(
                              builder: (BuildContext context, void Function(void Function()) setState) {
                                return Dialog(
                                  backgroundColor: const Color(0xffF2F2F2),
                                  insetPadding: const EdgeInsets.all(2),
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: MediaQuery.of(context).size.height * 0.75,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 15),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Padding(
                                                padding: EdgeInsets.only(bottom: 15),
                                                child: Text('По дате', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                                              ),
                                              IconButton(padding: const EdgeInsets.only(top: 15, bottom: 20, left: 0, right: 0), icon: const Icon(Icons.close), onPressed: () {Navigator.pop(context);}),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 20),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: <Widget>[
                                                const Padding(
                                                  padding: EdgeInsets.only(right: 20),
                                                  child: Text('Сначала новые', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                                                ),
                                                FlutterSwitch(
                                                  activeColor: Colors.white,
                                                  width: 40,
                                                  height: 18,
                                                  borderRadius: 30.0,
                                                  padding: 0,
                                                  toggleColor: const Color(0xff454545),
                                                  activeToggleColor: const Color(0xff15CE73),
                                                  value: _new, 
                                                  onToggle: (val) {
                                                    setState(() {
                                                      _new = val;
                                                    });
                                                  }
                                                )
                                              ],
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(bottom: 20),
                                            child: Text('По цене', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                                          ),
                                          Container(
                                            color: Colors.white,
                                            child: RangeSlider(
                                              min: 500,
                                              max: 200000,
                                              activeColor: const Color(0xff15CE73),
                                              divisions: 5,
                                              labels: RangeLabels("$_startPrice", "$_endPrice"),
                                              values: RangeValues(_startPrice, _endPrice),
                                              onChanged: (values) {
                                                setState(() {
                                                  _startPrice = values.start;
                                                  _endPrice = values.end;
                                                });
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 5, bottom: 25),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: const <Widget>[
                                                Text('500 p', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                                                Text('200000 p', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400))
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 400,
                                            height: 50,
                                            child: ElevatedButton(
                                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color(0xff15CE73))),
                                              onPressed: () {
                                                if (_new == false){
                                                  this.setState((){
                                                    _ordersList = List.from(_ordersList.reversed);
                                                  });
                                                }
                                                this.setState((){
                                                  _ordersList = _ordersList.where((element) => element['price'] >= _startPrice && element['price'] <= _endPrice).toList();
                                                });
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Подтвердить', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                );
                              },

                            );
                          }
                        );
                      },),
                      hintStyle: const TextStyle(fontSize: 16, color: Color(0xff1C1C1E)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)
                      )
                    ),
                  ),
                ),
              ),
              _ordersList == null ? const Center(
                child: CircularProgressIndicator(),
              ) : ListView.builder(
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: _ordersList.length,
                itemBuilder: (BuildContext context, int index) {  
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Card(
                      elevation: 16,
                      shadowColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(color: Color(0xff15CE73))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        child: ListTile(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> Order(id: _ordersList[index]["id"])));
                          },
                          trailing: SizedBox(
                            height: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IconButton(onPressed: () async {
                                  final SharedPreferences prefs = await _prefs;
                                  final String? token = prefs.getString('token');
                                  Dio().delete('https://xn----gtbdlmdrgbq5j.xn--p1ai/api/v1/order/${_ordersList[index]["id"]}/', options: Options(headers: {'Authorization': 'Token $token'}));
                                  setState(() {
                                    _ordersList.removeAt(index);
                                  });
                                }, icon: const Icon(Icons.delete)),
                                Image.asset('assets/img/ico/folder.png')
                              ],
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Text(_ordersList[index]['date'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: RichText(
                                  text: TextSpan(
                                    text: 'Заказчик: ',
                                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff15CE73)),
                                    children: <TextSpan>[
                                      TextSpan(text: _ordersList[index]["author"],style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black))
                                    ],
                                  )
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: RichText(
                                  text: TextSpan(
                                    text: 'Количество КП: ',
                                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff15CE73)),
                                    children: <TextSpan>[
                                      TextSpan(text: _ordersList[index]["count_kp"].toString(),style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black))
                                    ],
                                  )
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: RichText(
                                  text: TextSpan(
                                    text: 'Желаемая цена: ',
                                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff15CE73)),
                                    children: <TextSpan>[
                                      TextSpan(text: _ordersList[index]["price"].toString(),style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black))
                                    ],
                                  )
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: RichText(
                                  text: TextSpan(
                                    text: 'Профиль: ',
                                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff15CE73)),
                                    children: <TextSpan>[
                                      TextSpan(text: _ordersList[index]["shape"],style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black))
                                    ],
                                  )
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: RichText(
                                  text: TextSpan(
                                    text: 'Фурнитура: ',
                                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff15CE73)),
                                    children: <TextSpan>[
                                      TextSpan(text: _ordersList[index]["implement"],style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black))
                                    ],
                                  )
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: RichText(
                                  text: TextSpan(
                                    text: 'Адрес: ',
                                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff15CE73)),
                                    children: <TextSpan>[
                                      TextSpan(text: _ordersList[index]['address'],style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),)
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
              )
            ],
          ),
        ),
      ),
    );
  }
}