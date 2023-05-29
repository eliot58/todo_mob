import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todotodo/custom_icons.dart';
import 'package:todotodo/domain/state/works/works_state.dart';
import 'package:todotodo/internal/dependencies/works_module.dart';
import 'package:todotodo/presentation/provider/contacts.dart';
import 'package:url_launcher/url_launcher.dart';

import 'archive.dart';
import 'balance.dart';
import 'orders.dart';
import 'profile.dart';

class ProviderWorks extends StatefulWidget {
  const ProviderWorks({super.key});

  @override
  State<ProviderWorks> createState() => _ProviderWorksState();
}

class _ProviderWorksState extends State<ProviderWorks> {
  late WorksState worksState;

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
    worksState = WorksModule.worksState();
    worksState.getWorksAndQuantities();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.white,
              bottom: TabBar(
                indicatorColor: const Color(0xff080696),
                labelColor: const Color(0xff080696),
                unselectedLabelColor: const Color(0xff8A8A8A),
                tabs: [
                  Text('В работе', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400)),
                  Text('Отправлено КП', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400)),
                ],
              ),
            ),
            bottomNavigationBar: CustomNavigationBar(onTap: _bottomTab, currentIndex: 2, unSelectedColor: const Color(0xff8A8A8A), selectedColor: const Color(0xff080696), items: <CustomNavigationBarItem>[
              CustomNavigationBarItem(icon: const Icon(CustomIcon.orders), title: Text('Заказы', style: TextStyle(fontSize: 10.sp))),
              CustomNavigationBarItem(icon: const Icon(CustomIcon.wallet), title: Text('Подписка', style: TextStyle(fontSize: 10.sp))),
              CustomNavigationBarItem(icon: const Icon(CustomIcon.redo), title: Text('Статусы', style: TextStyle(fontSize: 10.sp))),
              CustomNavigationBarItem(icon: const Icon(CustomIcon.archive), title: Text('Архив', style: TextStyle(fontSize: 10.sp))),
              CustomNavigationBarItem(icon: const Icon(CustomIcon.bag), title: Text('Профиль', style: TextStyle(fontSize: 10.sp))),
              CustomNavigationBarItem(icon: const Icon(CustomIcon.friends), title: Text('Контакты', style: TextStyle(fontSize: 10.sp)))
            ]),
            backgroundColor: Colors.white,
            body: Observer(builder: (context) {
              if (worksState.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return TabBarView(children: [
                ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: worksState.works.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                      child: Card(
                          elevation: 16,
                          shadowColor: Colors.black,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: const BorderSide(color: Color(0xff080696))),
                          child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                              child: ListTile(
                                trailing: ElevatedButton(
                                    onPressed: () async {
                                      worksState.submitOrder(id: worksState.works[index]["id"]);
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => const ProviderArchive()));
                                    },
                                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color(0xff080696))),
                                    child: const Text('принять', style: TextStyle(color: Colors.white))),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 12),
                                      child: RichText(
                                          text: TextSpan(
                                        text: 'Дата: ',
                                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: const Color(0xff080696)),
                                        children: <TextSpan>[TextSpan(text: worksState.works[index]["date"], style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.black))],
                                      )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 12),
                                      child: RichText(
                                          text: TextSpan(
                                        text: 'Номер заказа: ',
                                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: const Color(0xff080696)),
                                        children: <TextSpan>[TextSpan(text: worksState.works[index]["order"]["id"].toString(), style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.black))],
                                      )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 12),
                                      child: RichText(
                                          text: TextSpan(
                                        text: 'Профиль: ',
                                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: const Color(0xff080696)),
                                        children: <TextSpan>[TextSpan(text: worksState.works[index]["shape"], style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.black))],
                                      )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 12),
                                      child: RichText(
                                          text: TextSpan(
                                        text: 'Фурнитура: ',
                                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: const Color(0xff080696)),
                                        children: <TextSpan>[TextSpan(text: worksState.works[index]["implement"], style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.black))],
                                      )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 12),
                                      child: RichText(
                                          text: TextSpan(
                                        text: 'Цена: ',
                                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: const Color(0xff080696)),
                                        children: <TextSpan>[TextSpan(text: worksState.works[index]["price"].toString(), style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.black))],
                                      )),
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
                                                  style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: const Size(50, 10), tapTargetSize: MaterialTapTargetSize.shrinkWrap, alignment: Alignment.centerLeft),
                                                  onPressed: () async {
                                                    var url = Uri.parse('${dotenv.env["api_url"]}${worksState.works[index]["order"]["file"]}');
                                                    if (!await launch('${dotenv.env["api_url"]}${worksState.works[index]["order"]["file"]}')) {
                                                      throw 'Could not launch $url';
                                                    }
                                                  },
                                                  child: Text(Uri.decodeFull(worksState.works[index]["order"]["file"].split("/").last), overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.blue))),
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
                                          const Text('Ваша КП: ', style: TextStyle(color: Color(0xff080696))),
                                          Expanded(
                                            child: TextButton(
                                                style: TextButton.styleFrom(
                                                  padding: EdgeInsets.zero,
                                                  minimumSize: const Size(50, 10),
                                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                  alignment: Alignment.centerLeft,
                                                ),
                                                onPressed: () async {
                                                  var url = Uri.parse('${dotenv.env["api_url"]}${worksState.works[index]["file"]}');
                                                  if (!await launch('${dotenv.env["api_url"]}${worksState.works[index]["file"]}')) {
                                                    throw 'Could not launch $url';
                                                  }
                                                },
                                                child: Text(Uri.decodeFull(worksState.works[index]["file"].split("/").last), overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.blue))),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ))),
                    );
                  },
                ),
                ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: worksState.quantities.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      child: Card(
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
                                        text: 'Номер заказа: ',
                                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: const Color(0xff080696)),
                                        children: <TextSpan>[TextSpan(text: worksState.quantities[index]["order"]["id"].toString(), style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.black))],
                                      )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 12),
                                      child: RichText(
                                          text: TextSpan(
                                        text: 'Дата поставки: ',
                                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: const Color(0xff080696)),
                                        children: <TextSpan>[TextSpan(text: worksState.quantities[index]["date"], style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.black))],
                                      )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 12),
                                      child: RichText(
                                          text: TextSpan(
                                        text: 'Профиль: ',
                                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: const Color(0xff080696)),
                                        children: <TextSpan>[TextSpan(text: worksState.quantities[index]["shape"], style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.black))],
                                      )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 12),
                                      child: RichText(
                                          text: TextSpan(
                                        text: 'Фурнитура: ',
                                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: const Color(0xff080696)),
                                        children: <TextSpan>[TextSpan(text: worksState.quantities[index]["implement"], style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.black))],
                                      )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 12),
                                      child: RichText(
                                          text: TextSpan(
                                        text: 'Предложенная цена: ',
                                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: const Color(0xff080696)),
                                        children: <TextSpan>[TextSpan(text: worksState.quantities[index]["price"].toString(), style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.black))],
                                      )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 12),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          const Text('Ваша КП: ', style: TextStyle(color: Color(0xff080696))),
                                          Expanded(
                                            child: TextButton(
                                                style: TextButton.styleFrom(
                                                  padding: EdgeInsets.zero,
                                                  minimumSize: const Size(50, 10),
                                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                  alignment: Alignment.centerLeft,
                                                ),
                                                onPressed: () async {
                                                  var url = Uri.parse('${dotenv.env["api_url"]}${worksState.quantities[index]["file"]}');
                                                  if (!await launch('${dotenv.env["api_url"]}${worksState.quantities[index]["file"]}')) {
                                                    throw 'Could not launch $url';
                                                  }
                                                },
                                                child: Text(Uri.decodeFull(worksState.quantities[index]["file"].split("/").last), overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.blue))),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ))),
                    );
                  },
                )
              ]);
            })),
      ),
    );
  }
}
