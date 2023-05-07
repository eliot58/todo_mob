import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:todotodo/custom_icons.dart';
import 'package:todotodo/domain/state/orders/orders_state.dart';
import 'package:todotodo/internal/dependencies/orders_module.dart';
import 'package:todotodo/presentation/auth/login.dart';
import 'package:todotodo/presentation/provider/balance.dart';
import 'package:todotodo/presentation/provider/works.dart';
import 'package:todotodo/data/api/service/todo_service.dart';
import 'archive.dart';
import 'profile.dart';
import 'send.dart';

class ProviderOrders extends StatefulWidget {
  const ProviderOrders({super.key});

  @override
  State<ProviderOrders> createState() => _ProviderOrdersState();
}

class _ProviderOrdersState extends State<ProviderOrders> {
  late OrdersState ordersState;

  double _startPrice = 500;
  double _endPrice = 200000;

  bool _new = true;

  Map<String, String> delivery = {"0": "Адрес клиента", "1": "Мой склад", "2": "Самовывоз"};

  @override
  void initState() {
    super.initState();
    ordersState = OrdersModule.ordersState();
    ordersState.getOrders();
  }

  void _bottomTab(int index) async {
    if (index == 0) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ProviderOrders()));
    } else if (index == 1) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const Balance()));
    } else if (index == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ProviderWorks()));
    } else if (index == 3) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ProviderArchive()));
    } else if (index == 4) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ProviderProfile()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: CustomNavigationBar(onTap: _bottomTab, currentIndex: 0, unSelectedColor: const Color(0xff8A8A8A), selectedColor: const Color(0xff080696), items: <CustomNavigationBarItem>[
          CustomNavigationBarItem(icon: const Icon(CustomIcon.orders), title: const Text('Заказы')),
          CustomNavigationBarItem(icon: const Icon(CustomIcon.wallet), title: const Text('Подписка')),
          CustomNavigationBarItem(icon: const Icon(CustomIcon.redo), title: const Text('Статусы')),
          CustomNavigationBarItem(icon: const Icon(CustomIcon.archive), title: const Text('Архив')),
          CustomNavigationBarItem(icon: const Icon(CustomIcon.bag), title: const Text('Профиль'))
        ]),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Observer(builder: (context) {
              if (ordersState.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 100, bottom: 25),
                    child: Center(
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.end, children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Image.asset('assets/img/provider-logo.png', width: 43, height: 43),
                        ),
                        const Text('Todotodo.поставщик', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Color(0xff080696))),
                        GestureDetector(
                          onTap: () async {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Login()));
                            final service = TodoService();
                            service.logout();
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
                          ordersState.searchInOrders(value);
                        },
                        textAlignVertical: TextAlignVertical.bottom,
                        obscureText: false,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color.fromARGB(118, 118, 128, 120),
                            hintText: 'Search',
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: IconButton(
                              icon: SvgPicture.asset('assets/img/filter.svg'),
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
                                                              ordersState.whereByPrice(_startPrice, _endPrice);
                                                            });
                                                            if (_new == false) {
                                                              this.setState(() {
                                                                ordersState.reverseOrders();
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
                  ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: ordersState.orders.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                          elevation: 16,
                          shadowColor: Colors.black,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: const BorderSide(color: Color(0xff080696))),
                          child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProviderSend(id: ordersState.orders[index]["id"])));
                                },
                                trailing: Image.asset('assets/img/folder.png'),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 12),
                                      child: Text(ordersState.orders[index]["date"], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 12),
                                      child: RichText(
                                          text: TextSpan(
                                        text: 'Номер заказа: ',
                                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff080696)),
                                        children: <TextSpan>[TextSpan(text: ordersState.orders[index]["id"].toString(), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black))],
                                      )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 12),
                                      child: RichText(
                                          text: TextSpan(
                                        text: 'Количество окон: ',
                                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff080696)),
                                        children: <TextSpan>[TextSpan(text: ordersState.orders[index]["amount_window"].toString(), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black))],
                                      )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 12),
                                      child: RichText(
                                          text: TextSpan(
                                        text: 'Желаемая цена: ',
                                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff080696)),
                                        children: <TextSpan>[TextSpan(text: ordersState.orders[index]["price"].toString(), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black))],
                                      )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 12),
                                      child: RichText(
                                          text: TextSpan(
                                        text: 'Профиль: ',
                                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff080696)),
                                        children: <TextSpan>[TextSpan(text: ordersState.orders[index]["shape"], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black))],
                                      )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 12),
                                      child: RichText(
                                          text: TextSpan(
                                        text: 'Фурнитура: ',
                                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff080696)),
                                        children: <TextSpan>[TextSpan(text: ordersState.orders[index]["implement"], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black))],
                                      )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 12),
                                      child: RichText(
                                          text: TextSpan(
                                        text: 'Тип оплаты: ',
                                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff080696)),
                                        children: <TextSpan>[TextSpan(text: ordersState.orders[index]["type_pay"] == 'C' ? "Карта" : "Безнал", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black))],
                                      )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 12),
                                      child: RichText(
                                          text: TextSpan(
                                        text: 'Тип доставки: ',
                                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff080696)),
                                        children: <TextSpan>[TextSpan(text: delivery[ordersState.orders[index]["type_delivery"]], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black))],
                                      )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 12),
                                      child: RichText(
                                          text: TextSpan(
                                        text: 'Адрес: ',
                                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff080696)),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: ordersState.orders[index]['address'],
                                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
                                          )
                                        ],
                                      )),
                                    ),
                                  ],
                                ),
                              )));
                    },
                  )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
