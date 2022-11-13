import 'package:flutter/material.dart';

class ProviderOrders extends StatefulWidget {
  const ProviderOrders({super.key});

  @override
  State<ProviderOrders> createState() => _ProviderOrdersState();
}

class _ProviderOrdersState extends State<ProviderOrders> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Заказы в регионе"),
          backgroundColor: const Color(0xff090696),
        ),
        body: Container(
          color: Colors.white,
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (BuildContext context, int index){
              return Card(
                child: ListTile(
                  title: const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text('Naryn Chorobaev 3', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text('Заказчик: Aimedin Chorobaev', style: TextStyle(color: Colors.black)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text('16.11.2003', style: TextStyle(color: Colors.black)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text('Профиль: Rehau Blitz New', style: TextStyle(color: Colors.black)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text('Фурнитура: ROTO NX', style: TextStyle(color: Colors.black)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text('Желаемая сумма: 5000', style: TextStyle(color: Colors.black)),
                      )
                    ],
                  ),
                ),
              );
            },
          )
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              ListTile(
                title: const Text('Профиль'),
                leading: const Icon(Icons.account_box),
                onTap: (){}
              ),
              ListTile(
                title: const Text('Баланс'),
                leading: const Icon(Icons.create),
                onTap: (){}
              ),
              ListTile(
                title: const Text('Заказы в регионе'),
                leading: const Icon(Icons.receipt_long_outlined),
                onTap: (){}
              ),
              ListTile(
                title: const Text('В работе'),
                leading: const Icon(Icons.work),
                onTap: (){}
              ),
              ListTile(
                title: const Text('Архив'),
                leading: const Icon(Icons.archive),
                onTap: (){}
              ),
              ListTile(
                title: const Text('Выход'),
                leading: const Icon(Icons.exit_to_app),
                onTap: (){}
              ),
            ],
          ),
        )

      ),
    );
  }
}