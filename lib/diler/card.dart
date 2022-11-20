import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:multiselect/multiselect.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todotodo/diler/archive.dart';
import 'package:todotodo/diler/create.dart';
import 'package:todotodo/diler/orders.dart';
import 'package:todotodo/diler/profile.dart';
import 'package:todotodo/diler/work.dart';

class CompanyCard extends StatefulWidget {
  final int id;

  const CompanyCard({
    super.key,
    required this.id,
  });

  @override
  State<CompanyCard> createState() => _CompanyCardState();
}

class _CompanyCardState extends State<CompanyCard> {
  final TextEditingController _company = TextEditingController();
  final TextEditingController _legalentity = TextEditingController();
  final TextEditingController _productaddress = TextEditingController();
  final TextEditingController _contactentity = TextEditingController();
  final TextEditingController _contactphone = TextEditingController();
  final TextEditingController _serviceentity = TextEditingController();
  final TextEditingController _servicephone = TextEditingController();
  final TextEditingController _serviceemail = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  List<String> shapes = [];
  List<String> implements = [];
  List<String> regions = [];

  List<String> selectedshapes = [];
  List<String> selectedimpl = [];
  List<String> selectedregions = [];

  dynamic _logourl;

  final _formKey = GlobalKey<FormState>();

  _setdata() async {
    final SharedPreferences prefs = await _prefs;
    final String? token = prefs.getString('token');
    var response = await Dio().get('https://xn----gtbdlmdrgbq5j.xn--p1ai/api/v1/providercard/${widget.id}/', options: Options(headers: {'Authorization': 'Token $token'}));
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

  Widget _logo(){
    if (_logourl!=null){
      return Padding(
        padding: const EdgeInsets.all(10),
        child: Image.network('https://xn----gtbdlmdrgbq5j.xn--p1ai$_logourl', width: 250, height: 200)
      );
    }
    return SizedBox(
        width: 250,
        height: 200,
        child: ElevatedButton(
          onPressed: null,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.grey)
          ),
          child: const Text('Лого')
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
                  _logo(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        enabled: false,
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
                      ),
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        enabled: false,
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
                      ),
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        enabled: false,
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
                      ),
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        enabled: false,
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
                      ),
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        enabled: false,
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
                      ),
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        enabled: false,
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
                      ),
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        enabled: false,
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
                      ),
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        enabled: false,
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
                      ),
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: DropDownMultiSelect(
                        enabled: false,
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
                        enabled: false,
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
                        enabled: false,
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
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        enabled: false,
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
                      ),
                    )
                  ),
                ],
              )
            )
            )
          )
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