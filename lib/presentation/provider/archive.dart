import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todotodo/custom_icons.dart';
import 'package:todotodo/data/api/service/todo_service.dart';
import 'package:todotodo/domain/state/archive/archive_state.dart';
import 'package:todotodo/internal/dependencies/archive_module.dart';
import 'package:todotodo/presentation/auth/login.dart';
import 'package:todotodo/presentation/provider/balance.dart';
import 'package:todotodo/presentation/provider/contacts.dart';
import 'package:todotodo/presentation/provider/orders.dart';
import 'package:todotodo/presentation/provider/profile.dart';
import 'package:todotodo/presentation/provider/works.dart';

class ProviderArchive extends StatefulWidget {
  const ProviderArchive({super.key});

  @override
  State<ProviderArchive> createState() => _ProviderArchiveState();
}

class _ProviderArchiveState extends State<ProviderArchive> {
  late ArchiveState archivesState;

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
    } else if (index == 5) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const Contacts()));
    }
  }

  @override
  void initState() {
    super.initState();
    archivesState = ArchivesModule.archivesState();
    archivesState.getArchives();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: CustomNavigationBar(onTap: _bottomTab, currentIndex: 3, unSelectedColor: const Color(0xff8A8A8A), selectedColor: const Color(0xff080696), items: <CustomNavigationBarItem>[
          CustomNavigationBarItem(icon: const Icon(CustomIcon.orders), title: Text('Заказы', style: TextStyle(fontSize: 10.sp))),
          CustomNavigationBarItem(icon: const Icon(CustomIcon.wallet), title: Text('Подписка', style: TextStyle(fontSize: 10.sp))),
          CustomNavigationBarItem(icon: const Icon(CustomIcon.redo), title: Text('Статусы', style: TextStyle(fontSize: 10.sp))),
          CustomNavigationBarItem(icon: const Icon(CustomIcon.archive), title: Text('Архив', style: TextStyle(fontSize: 10.sp))),
          CustomNavigationBarItem(icon: const Icon(CustomIcon.bag), title: Text('Профиль', style: TextStyle(fontSize: 10.sp))),
          CustomNavigationBarItem(icon: const Icon(CustomIcon.friends), title: Text('Контакты', style: TextStyle(fontSize: 10.sp)))
        ]),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Observer(builder: (context) {
              if (archivesState.isLoading) {
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
                          child: Image.asset('assets/img/provider-logo.png', width: 43.w, height: 43.h),
                        ),
                        Text('Todotodo.поставщик', style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700, color: const Color(0xff080696))),
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
                    itemCount: archivesState.archives.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                          elevation: 16,
                          shadowColor: Colors.black,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: const BorderSide(color: Color(0xff080696))),
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
                                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: const Color(0xff080696)),
                                        children: <TextSpan>[TextSpan(text: archivesState.archives[index]["date"], style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.black))],
                                      )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 12),
                                      child: RichText(
                                          text: TextSpan(
                                        text: 'Номер заказа: ',
                                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: const Color(0xff080696)),
                                        children: <TextSpan>[TextSpan(text: archivesState.archives[index]["order"]["id"].toString(), style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.black))],
                                      )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 12),
                                      child: RichText(
                                          text: TextSpan(
                                        text: 'Профиль: ',
                                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: const Color(0xff080696)),
                                        children: <TextSpan>[TextSpan(text: archivesState.archives[index]["shape"], style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.black))],
                                      )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 12),
                                      child: RichText(
                                          text: TextSpan(
                                        text: 'Фурнитура: ',
                                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: const Color(0xff080696)),
                                        children: <TextSpan>[TextSpan(text: archivesState.archives[index]["implement"], style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.black))],
                                      )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 12),
                                      child: RichText(
                                          text: TextSpan(
                                        text: 'Цена: ',
                                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: const Color(0xff080696)),
                                        children: <TextSpan>[TextSpan(text: archivesState.archives[index]["price"].toString(), style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.black))],
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
