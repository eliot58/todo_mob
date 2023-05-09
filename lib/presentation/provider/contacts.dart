import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todotodo/custom_icons.dart';
import 'package:todotodo/presentation/provider/balance.dart';
import 'package:todotodo/presentation/provider/orders.dart';
import 'package:todotodo/presentation/provider/profile.dart';
import 'package:todotodo/presentation/provider/works.dart';

import 'archive.dart';

class Contacts extends StatefulWidget {
  const Contacts({super.key});

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  List<Contact>? contacts;
  bool permissionDenied = false;

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  _fetchContacts() async {
    if (!await FlutterContacts.requestPermission(readonly: true)) {
      setState(() => permissionDenied = true);
    } else {
      final con = await FlutterContacts.getContacts();
      setState(() => contacts = con);
    }
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
    } else if (index == 5) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const Contacts()));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (permissionDenied) return const Center(child: Text('Permission denied'));
    if (contacts == null) return const Center(child: CircularProgressIndicator());
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: CustomNavigationBar(onTap: _bottomTab, currentIndex: 5, unSelectedColor: const Color(0xff8A8A8A), selectedColor: const Color(0xff080696), items: <CustomNavigationBarItem>[
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
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 10),
                    child: Text("Пригласить друзей", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.sp)),
                  ),
                  ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: contacts!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: ListTile(
                              title: Text(contacts![index].displayName, style: const TextStyle(fontWeight: FontWeight.w600)),
                              leading: CircleAvatar(backgroundColor: const Color(0xff8A8A8A), radius: 20, child: Text(contacts![index].displayName[0])),
                              trailing: const TextButton(onPressed: null, child: Text("Пригласить", style: TextStyle(color: Color(0xff15CE73)))),
                            ),
                          ),
                        );
                      })
                ],
              )),
        ),
      ),
    );
  }
}
