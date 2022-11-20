import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:multiselect/multiselect.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todotodo/diler/archive.dart';
import 'package:todotodo/diler/create.dart';
import 'package:todotodo/diler/orders.dart';
import 'package:todotodo/diler/work.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class DilerProfile extends StatefulWidget {
  const DilerProfile({super.key});

  @override
  State<DilerProfile> createState() => _DilerProfileState();
}

class _DilerProfileState extends State<DilerProfile> {
  final TextEditingController _companycontr = TextEditingController();
  final TextEditingController _fiocontr = TextEditingController();
  final TextEditingController _phonecontr = TextEditingController();
  final TextEditingController _emailcontr = TextEditingController();
  final TextEditingController _addresscontr = TextEditingController();
  bool issubmitmail = false;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();


  String _dropdownvalue = 'Мой регион';

  List<dynamic> items = [];
  dynamic _logourl;

  dynamic logopath;

  String practice = '';

  bool ispicked = false;

  final _formKey = GlobalKey<FormState>();
  

  _pickimg() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      
      setState(() {
        logopath = result.files.single.path;
        ispicked = true;
      });
    }
    build(context);
  }

  _setdata() async {
    final SharedPreferences prefs = await _prefs;
    final String? token = prefs.getString('token');
    var response =  await Dio().get('https://xn----gtbdlmdrgbq5j.xn--p1ai/api/v1/profile/', options: Options(headers: {'Authorization': 'Token $token'}));
    setState(() {
      _logourl = response.data['logo'];
      practice = response.data['practice'];
      _companycontr.text = response.data['company'];
      _fiocontr.text = response.data['fio'];
      _phonecontr.text = response.data['phone'];
      _emailcontr.text = response.data['email'];
      _addresscontr.text = response.data['warehouse_address'];
      items = response.data['regions'];
      _dropdownvalue = response.data['region'];
      issubmitmail = response.data['submitemail'];
    });
  }

  @override
  initState() {
    super.initState();
    _setdata();
  }
  

  Widget _imgget(){
    if (ispicked){
      return InkWell(
        onTap: _pickimg,
        splashColor: Colors.brown.withOpacity(0.5),
        child: Ink(
          height: 200,
          width: 250,
          child: Image.file(File(logopath)),
        ),
      );
    }
    if (_logourl==null){
      return SizedBox(
        width: 250,
        height: 200,
        child: ElevatedButton(
          onPressed: _pickimg,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.grey)
          ),
          child: const Text('Ваша аватарка')
        ),
      );
    }
    return InkWell(
        onTap: _pickimg,
        splashColor: Colors.brown.withOpacity(0.5),
        child: Ink(
          height: 200,
          width: 250,
          child: Image.network('https://xn----gtbdlmdrgbq5j.xn--p1ai${_logourl}'),
        ),
      );
  }

  Widget _select() {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButtonFormField(
          isExpanded: true,
          value: _dropdownvalue,
          items: items.map((dynamic item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
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
              _dropdownvalue = newValue!;
            });
          },
          validator: (value) => value == 'Мой регион'
              ? 'Мой регион'
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
          title: const Text("Профиль"),
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
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(practice, style: const TextStyle(fontSize: 20))
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: _imgget(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        controller: _companycontr,
                        obscureText: false,
                        style: const TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          hintText: 'Название компании',
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
                    child: Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        controller: _fiocontr,
                        obscureText: false,
                        style: const TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          hintText: 'Имя и фамилия',
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
                    child: Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        controller: _phonecontr,
                        obscureText: false,
                        style: const TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          hintText: 'Контактный телефон',
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
                    child: Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        controller: _emailcontr,
                        obscureText: false,
                        style: const TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          hintText: 'Контактный E-mail',
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
                    child: Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        controller: _addresscontr,
                        obscureText: false,
                        style: const TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          hintText: 'Адрес склада',
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
                    child: _select()
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      padding: const EdgeInsets.only(right: 20, left: 20),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Checkbox(
                              value: issubmitmail,
                              onChanged: (bool? value) {
                                setState(() {
                                  issubmitmail = value!;
                                });
                              },
                            ),
                          ),
                          const Text('Подписка на рассылку'),
                        ],
                      )
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 20),
                    child: ElevatedButton(
                      onPressed: () async {
                        FormData formData = FormData.fromMap({
                            "logo": logopath != null ?  await MultipartFile.fromFile(logopath, filename: 'logo') : null,
                            "fio": _fiocontr.text,
                            'phone': _phonecontr.text,
                            'email': _emailcontr.text,
                            'company': _companycontr.text,
                            'warehouse_address': _addresscontr.text,
                            'region': _dropdownvalue,
                            'submitemail': issubmitmail
                        });
                        final SharedPreferences prefs = await _prefs;
                        final String? token = prefs.getString('token');
                        var response =  await Dio().post('https://xn----gtbdlmdrgbq5j.xn--p1ai/api/v1/profile/', options: Options(headers: {'Authorization': 'Token $token'}), data: formData);
                        if (response.data['success']){
                          return showDialog<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Сохранено'),
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
                      child: const Text('Сохранить')
                    ),
                  )
                ],
              )
            )
            )
          ),
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              ListTile(
                title: const Text('Профиль'),
                leading: const Icon(Icons.account_box),
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const DilerProfile()));
                }
              ),
              ListTile(
                title: const Text('Создать заказ'),
                leading: const Icon(Icons.create),
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const DilerCreate()));
                }
              ),
              ListTile(
                title: const Text('Мои заказы'),
                leading: const Icon(Icons.receipt_long_outlined),
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const DilerOrders()));
                }
              ),
              ListTile(
                title: const Text('В работе'),
                leading: const Icon(Icons.work),
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const DilerWork()));
                }
              ),
              ListTile(
                title: const Text('Архив'),
                leading: const Icon(Icons.archive),
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const DilerArchive()));
                }
              ),
              ListTile(
                title: const Text('Выход'),
                leading: const Icon(Icons.exit_to_app),
                onTap: () async {
                  final SharedPreferences prefs = await _prefs;
                  final String? token = prefs.getString('token');
                  await Dio().get('https://xn----gtbdlmdrgbq5j.xn--p1ai/api/v1/auth/token/logout/', options: Options(headers: {'Authorization': 'Token $token'}));
                  await prefs.remove('token');
                  Navigator.pushReplacementNamed(context, '/');
                }
              ),
            ],
          ),
        )

      ),
    );
  }
}