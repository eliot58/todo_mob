import 'package:flutter/material.dart';

class Balance extends StatefulWidget {
  const Balance({super.key});

  @override
  State<Balance> createState() => _BalanceState();
}

class _BalanceState extends State<Balance> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Профиль"),
          backgroundColor: const Color(0xff090696),
        ),
        body: Container(
          padding: const EdgeInsets.only(top: 5),
          child: Column(
            children: <Widget>[
              const ListTile(
                title: Padding(
                  padding: EdgeInsets.only(bottom: 10, top: 10),
                  child: Text('Денег на счету', style: TextStyle(fontSize: 14)),
                ),
                subtitle: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text('100 ₽', style: TextStyle(fontSize: 36, color: Color(0xff05b169))),
                )
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    SizedBox(
                      width: 150,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: null,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(const Color(0xff1f5485))
                        ),
                        child: const Text('Счет')
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: null,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(const Color(0xff1f5485))
                        ),
                        child: const Text('Сбер')
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    SizedBox(
                      width: 150,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: null,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(const Color(0xff1f5485))
                        ),
                        child: const Text('Вопрос')
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: null,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(const Color(0xff19178b))
                        ),
                        child: const Text('10000')
                      ),
                    ),
                  ],
                ),
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