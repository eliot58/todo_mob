import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
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
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: CustomNavigationBar(onTap: _bottomTab, currentIndex: 5, unSelectedColor: const Color(0xff8A8A8A), selectedColor: const Color(0xff080696), items: <CustomNavigationBarItem>[
          CustomNavigationBarItem(icon: const Icon(CustomIcon.orders), title: const Text('Заказы')),
          CustomNavigationBarItem(icon: const Icon(CustomIcon.wallet), title: const Text('Подписка')),
          CustomNavigationBarItem(icon: const Icon(CustomIcon.redo), title: const Text('Статусы')),
          CustomNavigationBarItem(icon: const Icon(CustomIcon.archive), title: const Text('Архив')),
          CustomNavigationBarItem(icon: const Icon(CustomIcon.bag), title: const Text('Профиль')),
          CustomNavigationBarItem(icon: const Icon(CustomIcon.friends), title: const Text('Контакты'))
        ]),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 10),
                  child: Text("Пригласить друзей", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
                ),
                Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      title: Text("Aimedin Chorobaev", style: TextStyle(fontWeight: FontWeight.w600)),
                      leading: CircleAvatar(backgroundColor: Color(0xff8A8A8A), radius: 20, child: Text("ACH")),
                      trailing: TextButton(onPressed: null, child: Text("Пригласить", style: TextStyle(color: Color(0xff15CE73)))),
                    ),
                  ),
                )
              ],
            )
          ),
        ),
      ),
    );
  }
}