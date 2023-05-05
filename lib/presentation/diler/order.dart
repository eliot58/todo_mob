import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todotodo/custom_icons.dart';
import 'package:todotodo/domain/state/order/order_state.dart';
import 'package:todotodo/internal/dependencies/order_module.dart';
import 'package:todotodo/presentation/auth/login.dart';
import 'package:todotodo/presentation/diler/archive.dart';
import 'package:todotodo/presentation/diler/company.dart';
import 'package:todotodo/presentation/diler/ordercreate.dart';
import 'package:todotodo/presentation/diler/orders.dart';
import 'package:todotodo/presentation/diler/profile.dart';
import 'package:todotodo/presentation/diler/works.dart';
import 'package:url_launcher/url_launcher.dart';

class Order extends StatefulWidget {
  final int id;

  const Order({
    super.key,
    required this.id,
  });

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  late OrderState orderState;
  final TextEditingController _searchController = TextEditingController();

  double _startPrice = 500;
  double _endPrice = 200000;

  bool _new = true;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    orderState = OrderModule.orderState();
    orderState.getOrder(id: widget.id);
  }

  void _bottomTab(int index) async {
    if (index == 0) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const DilerOrders()));
    } else if (index == 1) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const DilerWorks()));
    } else if (index == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderCreate()));
    } else if (index == 3) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const DilerArchive()));
    } else if (index == 4) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const DilerProfile()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: CustomNavigationBar(onTap: _bottomTab, unSelectedColor: const Color(0xff8A8A8A), selectedColor: const Color(0xff15CE73), currentIndex: 0, items: <CustomNavigationBarItem>[
            CustomNavigationBarItem(icon: const Icon(CustomIcon.orders), title: const Text('Заказы')),
            CustomNavigationBarItem(icon: const Icon(CustomIcon.works), title: const Text('В работе')),
            CustomNavigationBarItem(icon: SvgPicture.asset('assets/img/create.svg'), title: const Text('Создать')),
            CustomNavigationBarItem(icon: const Icon(CustomIcon.archive), title: const Text('Архив')),
            CustomNavigationBarItem(icon: const Icon(CustomIcon.profile), title: const Text('Профиль'))
          ]),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Observer(builder: (context) {
                if (orderState.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 100, bottom: 25),
                      child: Center(
                        child: Row(crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Image.asset('assets/img/todotodo_logo.png', width: 43, height: 43),
                          ),
                          const Text('Todotodo.дилеры', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Color(0xff15CE73))),
                          GestureDetector(
                            onTap: () async {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Login()));
                              final SharedPreferences prefs = await _prefs;
                              final String? token = prefs.getString('token');
                              await prefs.remove('token');
                              Dio().get('http://127.0.0.1:8000/api/v1/auth/token/logout/', options: Options(headers: {'Authorization': 'Token $token'}));
                            },
                            child: const Icon(Icons.exit_to_app),
                          )
                        ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: SizedBox(
                        height: 38,
                        child: TextField(
                          textInputAction: TextInputAction.search,
                          onChanged: (value) {
                            orderState.searchInQuantities(value);
                          },
                          textAlignVertical: TextAlignVertical.bottom,
                          controller: _searchController,
                          obscureText: false,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color.fromARGB(118, 118, 128, 120),
                              hintText: 'Search',
                              prefixIcon: const Icon(Icons.search),
                              suffixIcon: IconButton(
                                icon: const Icon(CustomIcon.filter, color: Color(0xff080696)),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
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
                                                            IconButton(
                                                                padding: const EdgeInsets.only(top: 15, bottom: 20, left: 0, right: 0),
                                                                icon: const Icon(Icons.close),
                                                                onPressed: () {
                                                                  Navigator.pop(context);
                                                                }),
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
                                                                  })
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
                                                            children: const <Widget>[Text('500 p', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)), Text('200000 p', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400))],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 400,
                                                          height: 50,
                                                          child: ElevatedButton(
                                                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color(0xff15CE73))),
                                                            onPressed: () {
                                                              this.setState(() {
                                                                orderState.whereByPrice(_startPrice, _endPrice);
                                                              });
                                                              if (_new == false) {
                                                                this.setState(() {
                                                                  orderState.reverseQuantities();
                                                                });
                                                              }
                                                              Navigator.pop(context);
                                                            },
                                                            child: const Text('Подтвердить', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ));
                                          },
                                        );
                                      });
                                },
                              ),
                              hintStyle: const TextStyle(fontSize: 16, color: Color(0xff1C1C1E)),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Card(
                              elevation: 16,
                              shadowColor: Colors.black,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: const BorderSide(color: Color(0xff080696))),
                              color: const Color(0xffF8F7FC),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: ListTile(
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 12),
                                        child: RichText(
                                            text: TextSpan(
                                          text: 'Профиль: ',
                                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff15CE73)),
                                          children: <TextSpan>[TextSpan(text: orderState.order["shape"], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black))],
                                        )),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 12),
                                        child: RichText(
                                            text: TextSpan(
                                          text: 'Фурнитура: ',
                                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff15CE73)),
                                          children: <TextSpan>[TextSpan(text: orderState.order["implement"], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black))],
                                        )),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 12),
                                        child: RichText(
                                            text: TextSpan(
                                          text: 'Тип оплаты: ',
                                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff15CE73)),
                                          children: <TextSpan>[TextSpan(text: orderState.order['type_pay'], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black))],
                                        )),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 12),
                                        child: RichText(
                                            text: TextSpan(
                                          text: 'Тип доставки: ',
                                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff15CE73)),
                                          children: <TextSpan>[TextSpan(text: orderState.order['type_delivery'], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black))],
                                        )),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 12),
                                        child: RichText(
                                            text: TextSpan(
                                          text: 'Желаемая цена: ',
                                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff15CE73)),
                                          children: <TextSpan>[TextSpan(text: orderState.order["price"].toString(), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black))],
                                        )),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 12),
                                        child: RichText(
                                            text: TextSpan(
                                          text: 'Адрес: ',
                                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff15CE73)),
                                          children: <TextSpan>[TextSpan(text: orderState.order["address"], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black))],
                                        )),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                        ),
                        ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: orderState.order['quantity_set'].length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                                elevation: 16,
                                shadowColor: Colors.black,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: const BorderSide(color: Color(0xff15CE73))),
                                child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: ListTile(
                                      trailing: ElevatedButton(
                                          onPressed: orderState.order["quantity_set"][index]["isresponse"]
                                              ? null
                                              : () async {
                                                  final SharedPreferences prefs = await _prefs;
                                                  final String? token = prefs.getString('token');
                                                  Dio().get('http://127.0.0.1:8000/api/v1/response/${orderState.order["quantity_set"][index]["id"]}/', options: Options(headers: {'Authorization': 'Token $token'}));
                                                  setState(() {
                                                    orderState.order["quantity_set"][index]["isresponse"] = true;
                                                  });
                                                },
                                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(orderState.order["quantity_set"][index]["isresponse"] ? const Color(0xff080696) : const Color(0xff07995c))),
                                          child: Text(orderState.order["quantity_set"][index]["isresponse"] ? 'заказано' : 'заказать', style: const TextStyle(color: Colors.white))),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 12),
                                            child: Row(
                                              children: <Widget>[
                                                const Text('Поставщик: ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff080696))),
                                                Expanded(
                                                  child: TextButton(
                                                      style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: const Size(50, 30), tapTargetSize: MaterialTapTargetSize.shrinkWrap, alignment: Alignment.centerLeft),
                                                      onPressed: () async {
                                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Company(id: orderState.order["quantity_set"][index]["author_id"])));
                                                      },
                                                      child: Text(orderState.order["quantity_set"][index]["author_company"], overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.blue))),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 12),
                                            child: RichText(
                                                text: TextSpan(
                                              text: 'Поставка: ',
                                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff080696)),
                                              children: <TextSpan>[TextSpan(text: orderState.order["quantity_set"][index]["date"], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black))],
                                            )),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 12),
                                            child: RichText(
                                                text: TextSpan(
                                              text: 'Профиль: ',
                                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff080696)),
                                              children: <TextSpan>[TextSpan(text: orderState.order["quantity_set"][index]["shape"], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black))],
                                            )),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 12),
                                            child: RichText(
                                                text: TextSpan(
                                              text: 'Фурнитура: ',
                                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff080696)),
                                              children: <TextSpan>[TextSpan(text: orderState.order["quantity_set"][index]["implement"], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black))],
                                            )),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 12),
                                            child: Row(
                                              children: <Widget>[
                                                const Text('Предложение: ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff080696))),
                                                Expanded(
                                                  child: TextButton(
                                                      style: TextButton.styleFrom(padding: EdgeInsets.zero, tapTargetSize: MaterialTapTargetSize.shrinkWrap, alignment: Alignment.centerLeft),
                                                      onPressed: () async {
                                                        var url = Uri.parse('http://127.0.0.1:8000${orderState.order["quantity_set"][index]["fileurl"]}');
                                                        if (!await launchUrl(url)) {
                                                          throw 'Could not launch $url';
                                                        }
                                                      },
                                                      child: Text(Uri.decodeFull(orderState.order["quantity_set"][index]["file"]), overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.blue))),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 12),
                                            child: RichText(
                                                text: TextSpan(
                                              text: 'Цена: ',
                                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff080696)),
                                              children: <TextSpan>[TextSpan(text: orderState.order["kp"][index]["price"].toString(), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black))],
                                            )),
                                          ),
                                        ],
                                      ),
                                    )));
                          },
                        )
                      ],
                    )
                  ],
                );
              }),
            ),
          )),
    );
  }
}
