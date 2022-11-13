import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';


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

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();


  String _dropdownvalue = 'Мой регион';

  List<dynamic> items = [];
  dynamic _logourl;

  dynamic logopath;

  final _formKey = GlobalKey<FormState>();

  String practice = '';

  bool ispicked = false;

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
    var response =  await Dio().get('http://127.0.0.1:8000/api/v1/profile/get/', options: Options(headers: {'Authorization': 'Token 62889d1f4515f03411220f9d27e01fb2db2eba9e'}));
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
          child: Image.network(_logourl),
        ),
      );
  }

  Widget _select() {
    return Container(
      constraints: const BoxConstraints(maxWidth: 500),
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
                      constraints: const BoxConstraints(maxWidth: 500),
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
                      constraints: const BoxConstraints(maxWidth: 500),
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
                      constraints: const BoxConstraints(maxWidth: 500),
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
                      constraints: const BoxConstraints(maxWidth: 500),
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
                      constraints: const BoxConstraints(maxWidth: 500),
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
                            'region': _dropdownvalue
                        });
                        var response =  await Dio().post('http://127.0.0.1:8000/api/v1/profile/get/', options: Options(headers: {'Authorization': 'Token 1e5c9e89382f292f1a3fbe50cf325b8e0bd6ec99'}), data: formData);
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
                  Navigator.pushReplacementNamed(context, '/diler_profile');
                }
              ),
              ListTile(
                title: const Text('Создать заказ'),
                leading: const Icon(Icons.create),
                onTap: (){
                  Navigator.pushReplacementNamed(context, '/diler_order_create');
                }
              ),
              ListTile(
                title: const Text('Заказы в регионе'),
                leading: const Icon(Icons.receipt_long_outlined),
                onTap: (){
                  Navigator.pushReplacementNamed(context, '/diler_orders');
                }
              ),
              ListTile(
                title: const Text('В работе'),
                leading: const Icon(Icons.work),
                onTap: (){
                  Navigator.pushReplacementNamed(context, '/diler_work');
                }
              ),
              ListTile(
                title: const Text('Архив'),
                leading: const Icon(Icons.archive),
                onTap: (){
                  Navigator.pushReplacementNamed(context, '/diler_archive');
                }
              ),
              ListTile(
                title: const Text('Выход'),
                leading: const Icon(Icons.exit_to_app),
                onTap: () async {
                  final SharedPreferences prefs = await _prefs;
                  final String? token = prefs.getString('token');
                  await Dio().get('http://127.0.0.1:8000/api/v1/auth/token/logout/', options: Options(headers: {'Authorization': 'Token $token'}));
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