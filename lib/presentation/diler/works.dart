import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todotodo/custom_icons.dart';
import 'package:todotodo/data/api/service/todo_service.dart';
import 'package:todotodo/domain/state/works/works_state.dart';
import 'package:todotodo/internal/dependencies/works_module.dart';
import 'package:todotodo/presentation/auth/login.dart';
import 'package:todotodo/presentation/diler/archive.dart';
import 'package:todotodo/presentation/diler/ordercreate.dart';
import 'package:todotodo/presentation/diler/orders.dart';
import 'package:todotodo/presentation/diler/profile.dart';

class DilerWorks extends StatefulWidget {
  const DilerWorks({super.key});

  @override
  State<DilerWorks> createState() => _DilerWorksState();
}

class _DilerWorksState extends State<DilerWorks> {
  late WorksState worksState;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

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
  void initState() {
    super.initState();
    worksState = WorksModule.worksState();
    worksState.getWorks();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: CustomNavigationBar(onTap: _bottomTab, unSelectedColor: const Color(0xff8A8A8A), selectedColor: const Color(0xff15CE73), currentIndex: 1, items: <CustomNavigationBarItem>[
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
            child: Observer(
              builder: (context) {
                if (worksState.isLoading) {
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
                              final service = TodoService();
                              service.logout();
                            },
                            child: const Icon(Icons.exit_to_app),
                          )
                        ]),
                      ),
                    ),
                    ListView.builder(
                            physics: const ClampingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: worksState.works.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Card(
                                    elevation: 16,
                                    shadowColor: Colors.black,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: const BorderSide(color: Color(0xff15CE73))),
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                        child: ListTile(
                                          trailing: Image.asset('assets/img/folder.png'),
                                          subtitle: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 12),
                                                child: Text(worksState.works[index]['date'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 12),
                                                child: RichText(
                                                    text: TextSpan(
                                                  text: 'Номер заказа: ',
                                                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff15CE73)),
                                                  children: <TextSpan>[TextSpan(text: worksState.works[index]["order"]["id"].toString(), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black))],
                                                )),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 12),
                                                child: RichText(
                                                    text: TextSpan(
                                                  text: 'Профиль: ',
                                                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff15CE73)),
                                                  children: <TextSpan>[TextSpan(text: worksState.works[index]["shape"], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black))],
                                                )),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 12),
                                                child: RichText(
                                                    text: TextSpan(
                                                  text: 'Фурнитура: ',
                                                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff15CE73)),
                                                  children: <TextSpan>[TextSpan(text: worksState.works[index]["implement"], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black))],
                                                )),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 12),
                                                child: RichText(
                                                    text: TextSpan(
                                                  text: 'Цена: ',
                                                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff15CE73)),
                                                  children: <TextSpan>[TextSpan(text: worksState.works[index]["price"].toString(), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black))],
                                                )),
                                              ),
                                            ],
                                          ),
                                        ))),
                              );
                            },
                          )
                  ],
                );
              }
            ),
          ),
        ),
      ),
    );
  }
}
