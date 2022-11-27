import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todotodo/auth/login.dart';
import 'package:todotodo/diler/archive.dart';
import 'package:todotodo/diler/orders.dart';
import 'package:todotodo/diler/profile.dart';
import 'package:todotodo/diler/work.dart';


class DilerCreate extends StatefulWidget {
  const DilerCreate({super.key});

  @override
  State<DilerCreate> createState() => _DilerCreateState();
}

class _DilerCreateState extends State<DilerCreate> {
  final TextEditingController _addresscontr = TextEditingController();
  final TextEditingController _countwindcontr = TextEditingController();
  final TextEditingController _pricecontr = TextEditingController();
  final TextEditingController _commentcontr = TextEditingController();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  String optshape = 'Выберите профиль';

  List<dynamic> shapes = [];

  String optimpl = 'Выберите фурнитуру';

  List<dynamic> impls = [];

  dynamic filespath;

  String file1 = '';

  String optpay = 'Вид оплаты';

  var pays = ['Вид оплаты', 'Карта', 'Безнал'];

  String optdel = 'Вид доставки';

  var dels = ['Вид доставки','Адрес клиента','Мой склад','Самовывоз'];

  final _formKey = GlobalKey<FormState>();

  _pickimgs() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();
      setState(() {
        filespath = files;
        if (files.length == 1){
          file1 = files[0].uri.pathSegments.last;
        }
        else {
          file1 = '${files[0].uri.pathSegments.last}, .....';
        }
      });
    }
  }

  _setdata() async {
    final SharedPreferences prefs = await _prefs;
    final String? token = prefs.getString('token');
    var isblanked = await Dio().get('https://xn----gtbdlmdrgbq5j.xn--p1ai/api/v1/isblanked/', options: Options(headers: {'Authorization': 'Token $token'}));
    if (isblanked.data['isblanked']){
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Заполните профиль'),
            content: const Text(''),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const DilerProfile()));
                }
              ),
            ],
          );
        },
      );
    }
    var response =  await Dio().get('https://xn----gtbdlmdrgbq5j.xn--p1ai/api/v1/data/', options: Options(headers: {'Authorization': 'Token $token'}));
    setState(() {
      shapes = response.data['shapes'];
      impls = response.data['implements'];
    });
  }

  @override
  void initState() {
    super.initState();
    _setdata();
  }
  Widget _selectshape() {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButtonFormField(
          isExpanded: true,
          value: optshape,
          items: shapes.map((dynamic items) {
            return DropdownMenuItem(
              value: items,
              child: Text(items),
            );
          }).toList(),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintStyle: const TextStyle(fontSize: 16),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
            )
          ),
          onChanged: (dynamic newValue) {
            setState(() {
              optshape = newValue!;
            });
          },
          validator: (value) => value == 'Выберите профиль'
              ? 'Выберите профиль'
              : null,
        )
      ),
    );
  }

  Widget _selectimplement() {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButtonFormField(
          isExpanded: true,
          value: optimpl,
          items: impls.map((dynamic items) {
            return DropdownMenuItem(
              value: items,
              child: Text(items),
            );
          }).toList(),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintStyle: const TextStyle(fontSize: 16),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
            )
          ),
          onChanged: (dynamic newValue) {
            setState(() {
              optimpl = newValue!;
            });
          },
          validator: (value) => value == 'Выберите фурнитуру'
              ? 'Выберите фурнитуру'
              : null,
        )
      ),
    );
  }


  Widget _selectpay() {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButtonFormField(
          isExpanded: true,
          value: optpay,
          items: pays.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Text(items),
            );
          }).toList(),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintStyle: const TextStyle(fontSize: 16),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
            )
          ),
          onChanged: (String? newValue) {
            setState(() {
              optpay = newValue!;
            });
          },
          validator: (value) => value == 'Вид оплаты'
              ? 'Выберите вид оплаты'
              : null,
        )
      ),
    );
  }

  Widget _selectdel() {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButtonFormField(
          isExpanded: true,
          value: optdel,
          items: dels.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Text(items),
            );
          }).toList(),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintStyle: const TextStyle(fontSize: 16),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
            )
          ),
          onChanged: (String? newValue) {
            setState(() {
              optdel = newValue!;
            });
          },
          validator: (value) => value == 'Вид доставки'
              ? 'Выберите вид доставки'
              : null,
        )
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Создать заказ"),
          backgroundColor: const Color(0xff07995c),
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Form(
              key: _formKey,
              child: Center(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, top: 10),
                    child: _selectshape()
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _selectimplement()
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        controller: _addresscontr,
                        obscureText: false,
                        style: const TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          hintText: 'Введите адрес доставки',
                          filled: true,
                          fillColor: Colors.white,
                          hintStyle: const TextStyle(fontSize: 16),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                          )
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Заполните поле';
                          }
                          return null;
                        },
                      ),
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _selectpay()
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _selectdel()
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        controller: _countwindcontr,
                        obscureText: false,
                        style: const TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          hintText: 'Количество окон',
                          filled: true,
                          fillColor: Colors.white,
                          hintStyle: const TextStyle(fontSize: 16),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                          )
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Заполните поле';
                          }
                          return null;
                        },
                      ),
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        controller: _pricecontr,
                        obscureText: false,
                        style: const TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          hintText: 'Желаемая цена',
                          filled: true,
                          fillColor: Colors.white,
                          hintStyle: const TextStyle(fontSize: 16),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                          )
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Заполните поле';
                          }
                          return null;
                        },
                      ),
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        minLines: 5,
                        maxLines: 10,
                        keyboardType: TextInputType.multiline,
                        controller: _commentcontr,
                        obscureText: false,
                        style: const TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          hintText: 'Коментарий к заказу',
                          filled: true,
                          fillColor: Colors.white,
                          hintStyle: const TextStyle(fontSize: 16),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                          )
                        ),
                      ),
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(file1)
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: ElevatedButton(
                      onPressed: _pickimgs,
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(const Color(0xff07995c))
                      ),
                      child: const Text('Прикрепить файлы')
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (file1 != ''){
                          if (_formKey.currentState!.validate()){
                            FormData formData = FormData.fromMap({
                                "shape": optshape,
                                'implement': optimpl,
                                'address': _addresscontr.text,
                                'type_pay': optpay,
                                'type_delivery': optdel,
                                'amount': _countwindcontr.text,
                                'price': _pricecontr.text,
                                'comment': _commentcontr.text,
                            });
                            for (var file in filespath) {
                              formData.files.addAll([
                              MapEntry("upl", await MultipartFile.fromFile(file.path)),
                            ]);
                            }
                            final SharedPreferences prefs = await _prefs;
                            final String? token = prefs.getString('token');
                            var response =  await Dio().post('https://xn----gtbdlmdrgbq5j.xn--p1ai/api/v1/orders/', options: Options(headers: {'Authorization': 'Token $token'}), data: formData);
                            if (response.data['success']){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const DilerOrders()));
                            }
                          }
                        } else {
                          return showDialog<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Прикрепите файлы'),
                                content: const Text(''),
                                actions: <Widget>[
                                  ElevatedButton(
                                    child: const Text('Ok'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    }
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(const Color(0xff07995c))
                      ),
                      child: const Text('Создать')
                    )
                  ),
                ],
              )
            )
            )
          ),
        ),
        drawer: SizedBox(
          width: MediaQuery.of(context).size.width * 0.75,
          child: Drawer(
            backgroundColor: const Color(0xff07995c),
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 20, top: 20),
                  child: Image.asset("assets/img/todotodo_logo.png", width: 60, height: 60)
                ),
                ListTile(
                  title: const Text('Профиль', style: TextStyle(color: Colors.white)),
                  leading: const Icon(Icons.account_box, color: Colors.white),
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const DilerProfile()));
                  }
                ),
                ListTile(
                  title: const Text('Создать заказ', style: TextStyle(color: Colors.white)),
                  leading: const Icon(Icons.create, color: Colors.white),
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const DilerCreate()));
                  }
                ),
                ListTile(
                  title: const Text('Мои заказы', style: TextStyle(color: Colors.white)),
                  leading: const Icon(Icons.receipt_long_outlined, color: Colors.white),
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const DilerOrders()));
                  }
                ),
                ListTile(
                  title: const Text('В работе', style: TextStyle(color: Colors.white)),
                  leading: const Icon(Icons.work, color: Colors.white),
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const DilerWork()));
                  }
                ),
                ListTile(
                  title: const Text('Архив', style: TextStyle(color: Colors.white)),
                  leading: const Icon(Icons.archive, color: Colors.white),
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const DilerArchive()));
                  }
                ),
                ListTile(
                  title: const Text('Выход', style: TextStyle(color: Colors.white)),
                  leading: const Icon(Icons.exit_to_app, color: Colors.white),
                  onTap: () async {
                    final SharedPreferences prefs = await _prefs;
                    final String? token = prefs.getString('token');
                    await Dio().get('https://xn----gtbdlmdrgbq5j.xn--p1ai/api/v1/auth/token/logout/', options: Options(headers: {'Authorization': 'Token $token'}));
                    await prefs.remove('token');
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const Auth()));
                  }
                ),
              ],
            ),
          ),
        )

      ),
    );
  }
}