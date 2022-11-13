import 'package:flutter/material.dart';

class ProviderOrder extends StatefulWidget {
  const ProviderOrder({super.key});

  @override
  State<ProviderOrder> createState() => _ProviderOrderState();
}

class _ProviderOrderState extends State<ProviderOrder> {
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
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 5, bottom: 5),
                child: Text('Инфо о заказе', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Card(
                  child: ListTile(
                    title: const Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text('Naryn Chorobaev 3', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Row(
                            children: const <Widget>[
                              Text('dsdksjdk', style: TextStyle(color: Colors.black)),
                              Text('dsdksjdk', style: TextStyle(color: Colors.black)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Row(
                            children: const <Widget>[
                              Text('dsdksjdk', style: TextStyle(color: Colors.black)),
                              Text('dsdksjdk', style: TextStyle(color: Colors.black)),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: Text('Профиль: Rehau Blitz New', style: TextStyle(color: Colors.black)),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: Text('Фурнитура: ROTO NX', style: TextStyle(color: Colors.black)),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: Text('Желаемая сумма: 5000', style: TextStyle(color: Colors.black)),
                        )
                      ]
                    )
                  ),
                ),
              ),
              const Card(
                child: ListTile(
                  title: Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text('Комментарий', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
                  ),
                  subtitle: Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text('мьоддаодыоалдыадьыоамльдыоадлыолдыоьаыодаодыодоыдмоьдаьдмоьдаыомдодыомьдыоыдододыодыаымыомдымдыьаыдмьыоадыдамьыамьдымьдаоы', style: TextStyle(color: Colors.black)),
                  ),
                )
              ),
              const Padding(
                padding: EdgeInsets.only(top: 5, bottom: 5),
                child: Text('Предложение', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              ),
              ListView.builder(
                itemCount: 1,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
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
            ],
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