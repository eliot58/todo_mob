import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:multiselect/multiselect.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todotodo/auth/login.dart';
import 'package:todotodo/provider/archive.dart';
import 'package:todotodo/provider/balance.dart';
import 'package:todotodo/provider/orders.dart';
import 'package:todotodo/provider/send.dart';
import 'package:todotodo/provider/work.dart';

class ProviderProfile extends StatefulWidget {
  const ProviderProfile({super.key});

  @override
  State<ProviderProfile> createState() => _ProviderProfileState();
}


class _ProviderProfileState extends State<ProviderProfile> {
  final TextEditingController _company = TextEditingController();
  final TextEditingController _legalentity = TextEditingController();
  final TextEditingController _productaddress = TextEditingController();
  final TextEditingController _contactentity = TextEditingController();
  final TextEditingController _contactphone = TextEditingController();
  final TextEditingController _serviceentity = TextEditingController();
  final TextEditingController _servicephone = TextEditingController();
  final TextEditingController _serviceemail = TextEditingController();
  final TextEditingController _description = TextEditingController();

  bool issubmitmail = false;

  List<String> shapes = [];
  List<String> implements = [];
  List<String> regions = [];

  List<String> selectedshapes = [];
  List<String> selectedimpl = [];
  List<String> selectedregions = [];

  dynamic _logourl;
  
  dynamic logopath;

  bool ispicked = false;

  dynamic emailvalidator;
  dynamic phone1validator;
  dynamic phone2validator;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

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
          child: const Text('Ваша лого')
        ),
      );
    }
    return InkWell(
        onTap: _pickimg,
        splashColor: Colors.brown.withOpacity(0.5),
        child: Ink(
          height: 200,
          width: 250,
          child: Image.network('https://xn----gtbdlmdrgbq5j.xn--p1ai$_logourl'),
        ),
      );
  }

  _setdata() async {
    final SharedPreferences prefs = await _prefs;
    final String? token = prefs.getString('token');
    var response = await Dio().get('https://xn----gtbdlmdrgbq5j.xn--p1ai/api/v1/profile/', options: Options(headers: {'Authorization': 'Token $token'}));
    setState(() {
      _logourl = response.data['logo'];
      _company.text = response.data['company'];
      _legalentity.text = response.data['legal_entity'];
      _productaddress.text = response.data['product_address'];
      _contactentity.text = response.data['contact_entity'];
      _contactphone.text = response.data['contact_phone'];
      _serviceentity.text = response.data['service_entity'];
      _servicephone.text = response.data['service_phone'];
      _serviceemail.text = response.data['service_email'];
      _description.text = response.data['description'];
      issubmitmail = response.data['submitemail'];
      shapes = response.data['shapes'].cast<String>();
      implements = response.data['implements'].cast<String>();
      regions = response.data['regions'].cast<String>();
      selectedshapes = response.data['selshapes'].cast<String>();
      selectedimpl = response.data['selimplements'].cast<String>();
      selectedregions = response.data['selregions'].cast<String>();
    });
  }

  @override
  void initState() {
    super.initState();
    _setdata();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Профиль"),
          backgroundColor: const Color(0xff090696),
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
                    padding: const EdgeInsets.all(10),
                    child: _imgget(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        controller: _company,
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
                        controller: _legalentity,
                        obscureText: false,
                        style: const TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          hintText: 'Юридическое лицо',
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
                        controller: _productaddress,
                        obscureText: false,
                        style: const TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          hintText: 'Адрес производства',
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
                        controller: _contactentity,
                        obscureText: false,
                        style: const TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          hintText: 'Руководитель',
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
                        controller: _contactphone,
                        obscureText: false,
                        style: const TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          hintText: 'Телефон производства',
                          filled: true,
                          fillColor: Colors.white,
                          hintStyle: const TextStyle(fontSize: 16),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                          )
                        ),
                        validator: (value) {
                          return phone1validator;
                        },
                      ),
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        controller: _serviceentity,
                        obscureText: false,
                        style: const TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          hintText: 'Менеджер',
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
                        controller: _servicephone,
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
                        validator: (value) {
                          return phone2validator;
                        },
                      ),
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        controller: _serviceemail,
                        obscureText: false,
                        style: const TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          hintText: 'E-mail',
                          filled: true,
                          fillColor: Colors.white,
                          hintStyle: const TextStyle(fontSize: 16),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                          )
                        ),
                        validator: (value) {
                          return emailvalidator;
                        },
                      ),
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: DropDownMultiSelect(
                        onChanged: (List<String> x) {
                          setState(() {
                            selectedshapes = x;
                          });
                        },
                        options: shapes,
                        selectedValues: selectedshapes,
                        whenEmpty: 'Профиль',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: DropDownMultiSelect(
                        onChanged: (List<String> x) {
                          setState(() {
                            selectedimpl = x;
                          });
                        },
                        options: implements,
                        selectedValues: selectedimpl,
                        whenEmpty: 'Фурнитура',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: DropDownMultiSelect(
                        onChanged: (List<String> x) {
                          setState(() {
                            selectedregions = x;
                          });
                        },
                        options: regions,
                        selectedValues: selectedregions,
                        whenEmpty: 'Области доставки',
                      ),
                    ),
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
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        minLines: 5,
                        maxLines: 10,
                        keyboardType: TextInputType.multiline,
                        controller: _description,
                        obscureText: false,
                        style: const TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          hintText: 'О компании',
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
                    padding: const EdgeInsets.only(top: 5, bottom: 20),
                    child: ElevatedButton(
                      onPressed: () async {
                        var uservalidate =  await Dio().post('https://xn----gtbdlmdrgbq5j.xn--p1ai/api/v1/uservalidate/', data: {'email': _serviceemail.text});
                        setState(() {
                          emailvalidator = uservalidate.data['validate'];
                        });
                        var phone1validate =  await Dio().post('https://xn----gtbdlmdrgbq5j.xn--p1ai/api/v1/phonevalidate/', data: {'phone': _contactphone.text});
                        setState(() {
                          phone1validator = phone1validate.data['validate'];
                        });
                        var phone2validate =  await Dio().post('https://xn----gtbdlmdrgbq5j.xn--p1ai/api/v1/phonevalidate/', data: {'phone': _servicephone.text});
                        setState(() {
                          phone2validator = phone2validate.data['validate'];
                        });
                        if (_formKey.currentState!.validate()){
                          FormData formData = FormData.fromMap({
                            'company': _company.text,
                            'legal_entity': _legalentity.text,
                            'product_address': _productaddress.text,
                            'contact_entity': _contactentity.text,
                            'contact_phone': _contactphone.text,
                            'service_entity': _serviceentity.text,
                            'service_phone': _servicephone.text,
                            'service_email': _serviceemail.text,
                            'submitemail': issubmitmail,
                            'logo': logopath != null ?  await MultipartFile.fromFile(logopath, filename: 'logo') : null,
                            'description': _description.text,
                            'shapes': selectedshapes,
                            'implements': selectedimpl,
                            'regions': selectedregions
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
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(const Color(0xff090696))
                      ),
                      child: const Text('Сохранить')
                    ),
                  )
                ],
              )
            )
            )
          )
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
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const ProviderProfile()));
                  }
                ),
                ListTile(
                  title: const Text('Баланс', style: TextStyle(color: Colors.white)),
                  leading: const Icon(Icons.monetization_on, color: Colors.white),
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const Balance()));
                  }
                ),
                ListTile(
                  title: const Text('Отправлено КП', style: TextStyle(color: Colors.white)),
                  leading: const Icon(Icons.send, color: Colors.white),
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const ProviderSend()));
                  }
                ),
                ListTile(
                  title: const Text('Заказы в регионе', style: TextStyle(color: Colors.white)),
                  leading: const Icon(Icons.receipt_long_outlined, color: Colors.white),
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const ProviderOrders()));
                  }
                ),
                ListTile(
                  title: const Text('В работе', style: TextStyle(color: Colors.white)),
                  leading: const Icon(Icons.work, color: Colors.white),
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const ProviderWork()));
                  }
                ),
                ListTile(
                  title: const Text('Архив', style: TextStyle(color: Colors.white)),
                  leading: const Icon(Icons.archive, color: Colors.white),
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const ProviderArchive()));
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