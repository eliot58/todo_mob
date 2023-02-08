import 'dart:developer';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multiselect/multiselect.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todotodo/auth/login.dart';
import 'package:todotodo/custom_icons.dart';
import 'package:todotodo/provider/archive.dart';
import 'package:todotodo/provider/balance.dart';
import 'package:todotodo/provider/orders.dart';
import 'package:todotodo/provider/works.dart';

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


  List<String> shapes = [];
  List<String> implements = [];
  List<String> regions = [];

  List<String> selectedshapes = [];
  List<String> selectedimpl = [];
  List<String> selectedregions = [];

  dynamic _logourl;
  
  dynamic logopath;

  bool ispicked = false;

  List<PlatformFile>? _paths;


  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final _formKey = GlobalKey<FormState>();


  _pickimg() async {
    try {
      _paths = (await FilePicker.platform.pickFiles(
        withData: true,
        type: FileType.custom,
        allowMultiple: false,
        onFileLoading: (FilePickerStatus status) => print(status),
        allowedExtensions: ['png', 'jpg', 'jpeg', 'heic'],
      ))
          ?.files;
    } on PlatformException catch (e) {
      log('Unsupported operation$e');
    } catch (e) {
      log(e.toString());
    }
    setState(() {
      if (_paths != null) {
        if (_paths != null) {
          ispicked = true;
          logopath = true;
        }
      }
    });
    if (!mounted) return;
    build(context);
  }

  Widget _imgget(){
    if (ispicked){
      return IconButton(icon: CircleAvatar(radius: 50,backgroundImage: MemoryImage(_paths!.first.bytes!)), onPressed: _pickimg, iconSize: 47);
    }
    if (_logourl==null){
      return IconButton(icon: Image.asset('assets/img/avatar.png'), onPressed: _pickimg, iconSize: 47);
    }
    return IconButton(icon: CircleAvatar(radius: 50,backgroundImage: NetworkImage('https://xn----gtbdlmdrgbq5j.xn--p1ai$_logourl')), onPressed: _pickimg, iconSize: 47);
    
  }

  _setdata() async {
    final SharedPreferences prefs = await _prefs;
    final String? token = prefs.getString('token');
    if (!mounted) return;
    if (token==null){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const Login()));
    }
    var response = await Dio().get('https://xn----gtbdlmdrgbq5j.xn--p1ai/api/v1/profile/', options: Options(headers: {'Authorization': 'Token $token'}));
    if (!mounted) return;
    setState(() {
      _logourl = response.data['logo'];
      _company.text = response.data['company'];
      _company.selection = TextSelection.fromPosition(TextPosition(offset: _company.text.length));
      _legalentity.text = response.data['legal_entity'];
      _legalentity.selection = TextSelection.fromPosition(TextPosition(offset: _legalentity.text.length));
      _productaddress.text = response.data['product_address'];
      _productaddress.selection = TextSelection.fromPosition(TextPosition(offset: _productaddress.text.length));
      _contactentity.text = response.data['contact_entity'];
      _contactentity.selection = TextSelection.fromPosition(TextPosition(offset: _contactentity.text.length));
      _contactphone.text = response.data['contact_phone'];
      _contactphone.selection = TextSelection.fromPosition(TextPosition(offset: _contactphone.text.length));
      _serviceentity.text = response.data['service_entity'];
      _serviceentity.selection = TextSelection.fromPosition(TextPosition(offset: _serviceentity.text.length));
      _servicephone.text = response.data['service_phone'];
      _servicephone.selection = TextSelection.fromPosition(TextPosition(offset: _servicephone.text.length));
      _serviceemail.text = response.data['service_email'];
      _serviceemail.selection = TextSelection.fromPosition(TextPosition(offset: _serviceemail.text.length));
      _description.text = response.data['description'];
      _description.selection = TextSelection.fromPosition(TextPosition(offset: _description.text.length));
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

  void _bottomTab (int index) async {
    if (index==0){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const ProviderOrders()));
    } else if (index==1) {
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const Balance()));
    } else if (index==2) {
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const ProviderWorks()));
    } else if (index==3) {
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const ProviderArchive()));
    } else if (index==4) {
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const ProviderProfile()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomNavigationBar(
        onTap: _bottomTab,
        currentIndex: 4,
        unSelectedColor: const Color(0xff8A8A8A
),
        selectedColor: const Color(0xff080696),
        items: <CustomNavigationBarItem>[
          CustomNavigationBarItem(
            icon: const Icon(CustomIcon.orders),
            title: const Text('Заказы')
          ),
          CustomNavigationBarItem(
            icon: const Icon(CustomIcon.wallet),
            title: const Text('Подписка')
          ),
          CustomNavigationBarItem(
            icon: const Icon(CustomIcon.redo),
            title: const Text('В работе')
          ),
          CustomNavigationBarItem(
            icon: const Icon(CustomIcon.archive),
            title: const Text('Архив')
          ),
          CustomNavigationBarItem(
            icon: const Icon(CustomIcon.bag),
            title: const Text('Профиль')
          )
        ]
      ),
      body: regions.isEmpty ? const Center(child: CircularProgressIndicator()) : SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 60, bottom: 30),
                      child: Text('Профиль компании', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      children: <Widget>[
                        _imgget(),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(_contactentity.text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                              Text(_productaddress.text, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
                            ],
                          ),
                        )
                      ],
                    )
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text('Название компании'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextFormField(
                      controller: _company,
                      obscureText: false,
                      style: const TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)
                        )
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Заполните поле';
                        }
                        return null;
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text('Юридическое лицо'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextFormField(
                      controller: _legalentity,
                      obscureText: false,
                      style: const TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)
                        )
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Заполните поле';
                        }
                        return null;
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text('Адрес производства'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextFormField(
                      controller: _productaddress,
                      obscureText: false,
                      keyboardType: TextInputType.streetAddress,
                      style: const TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)
                        )
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Заполните поле';
                        }
                        return null;
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text('Руководитель'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextFormField(
                      controller: _contactentity,
                      obscureText: false,
                      style: const TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)
                        )
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Заполните поле';
                        }
                        return null;
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text('Телефон производства'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextFormField(
                      controller: _contactphone,
                      obscureText: false,
                      keyboardType: TextInputType.phone,
                      style: const TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)
                        )
                      ),
                      validator: (value) {
                        final phoneRegExp = RegExp(r"^(\+7|7|8)?[\s\-]?\(?[489][0-9]{2}\)?[\s\-]?[0-9]{3}[\s\-]?[0-9]{2}[\s\-]?[0-9]{2}$");
                        if (value == null || value.isEmpty) {
                          return 'Заполните поле';
                        } else if (!phoneRegExp.hasMatch(value)){
                          return 'Введите правильный номер (+79855310868)';
                        }
                        return null;
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text('Менеджер'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextFormField(
                      controller: _serviceentity,
                      obscureText: false,
                      style: const TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)
                        )
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Заполните поле';
                        }
                        return null;
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text('Контактный телефон'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextFormField(
                      controller: _servicephone,
                      obscureText: false,
                      keyboardType: TextInputType.phone,
                      style: const TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)
                        )
                      ),
                      validator: (value) {
                        final phoneRegExp = RegExp(r"^(\+7|7|8)?[\s\-]?\(?[489][0-9]{2}\)?[\s\-]?[0-9]{3}[\s\-]?[0-9]{2}[\s\-]?[0-9]{2}$");
                        if (value == null || value.isEmpty) {
                          return 'Заполните поле';
                        } else if (!phoneRegExp.hasMatch(value)){
                          return 'Введите правильный номер (+79855310868)';
                        }
                        return null;
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text('E-mail'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextFormField(
                      controller: _serviceemail,
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)
                        )
                      ),
                      validator: (value) {
                        final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                        if (value == null || value.isEmpty) {
                          return 'Заполните поле';
                        } else if (!emailRegExp.hasMatch(value)){
                          return 'Введите действующий E-mail';
                        }
                        return null;
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text('Профили'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: DropDownMultiSelect(
                      onChanged: (List<String> x) {
                        setState(() {
                          selectedshapes = x;
                        });
                      },
                      options: shapes,
                      selectedValues: selectedshapes,
                      whenEmpty: 'Профили',
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text('Фурнитуры'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
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
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text('Области доставки'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
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
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text('О компании'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextFormField(
                      minLines: 5,
                      maxLines: 10,
                      controller: _description,
                      obscureText: false,
                      style: const TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)
                        )
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Заполните поле';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: SizedBox(
                      width: 400,
                      height: 50,
                      child: ElevatedButton(
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color(0xff15CE73))),
                        onPressed: () async{
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
                              "logo": logopath != null ?  MultipartFile.fromBytes(_paths!.first.bytes!, filename: _paths!.first.name) : null,
                              'description': _description.text,
                              'shapes': selectedshapes,
                              'implements': selectedimpl,
                              'regions': selectedregions
                            });
                            final SharedPreferences prefs = await _prefs;
                            final String? token = prefs.getString('token');
                            Dio().post('https://xn----gtbdlmdrgbq5j.xn--p1ai/api/v1/profile/', options: Options(headers: {'Authorization': 'Token $token'}), data: formData);
                            return showDialog(
                              context: context, 
                              builder: (BuildContext context) {
                                return Dialog(
                                  insetPadding: const EdgeInsets.all(20),
                                  child: SizedBox(
                                    width: 400,
                                    height: 400,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        const Text('Профиль сохранён', style: TextStyle(color: Color(0xff080696), fontSize: 16, fontWeight: FontWeight.w700),),
                                        Image.asset('assets/img/ico/check.png'),
                                        SizedBox(
                                          width: 400,
                                          height: 50,
                                          child: ElevatedButton(
                                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color(0xff15CE73))),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Закрыть', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                                          ),
                                        )
                                      ],
                                    )
                                  ),
                                );
                              }
                            );
                          }
                        },
                        child: const Text('Подтвердить', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        )
      )
    );
  }
}