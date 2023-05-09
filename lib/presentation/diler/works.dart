import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
          CustomNavigationBarItem(icon: const Icon(CustomIcon.orders), title: Text('Заказы', style: TextStyle(fontSize: 10.sp))),
          CustomNavigationBarItem(icon: const Icon(CustomIcon.works), title: Text('В работе', style: TextStyle(fontSize: 10.sp))),
          CustomNavigationBarItem(icon: SvgPicture.asset('assets/img/create.svg'), title: Text('Создать', style: TextStyle(fontSize: 10.sp))),
          CustomNavigationBarItem(icon: const Icon(CustomIcon.archive), title: Text('Архив', style: TextStyle(fontSize: 10.sp))),
          CustomNavigationBarItem(icon: const Icon(CustomIcon.profile), title: Text('Профиль', style: TextStyle(fontSize: 10.sp)))
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
                            child: Image.asset('assets/img/todotodo_logo.png', width: 43.w, height: 43.h),
                          ),
                          Text('Todotodo.дилеры', style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700, color: const Color(0xff15CE73))),
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
                                                child: Text(worksState.works[index]['date'], style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400)),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 12),
                                                child: RichText(
                                                    text: TextSpan(
                                                  text: 'Номер заказа: ',
                                                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: const Color(0xff15CE73)),
                                                  children: <TextSpan>[TextSpan(text: worksState.works[index]["order"]["id"].toString(), style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.black))],
                                                )),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 12),
                                                child: RichText(
                                                    text: TextSpan(
                                                  text: 'Профиль: ',
                                                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: const Color(0xff15CE73)),
                                                  children: <TextSpan>[TextSpan(text: worksState.works[index]["shape"], style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.black))],
                                                )),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 12),
                                                child: RichText(
                                                    text: TextSpan(
                                                  text: 'Фурнитура: ',
                                                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: const Color(0xff15CE73)),
                                                  children: <TextSpan>[TextSpan(text: worksState.works[index]["implement"], style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.black))],
                                                )),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 12),
                                                child: RichText(
                                                    text: TextSpan(
                                                  text: 'Цена: ',
                                                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: const Color(0xff15CE73)),
                                                  children: <TextSpan>[TextSpan(text: worksState.works[index]["price"].toString(), style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.black))],
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
