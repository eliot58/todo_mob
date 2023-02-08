import 'dart:developer';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todotodo/custom_icons.dart';
import 'package:todotodo/diler/archive.dart';
import 'package:todotodo/diler/ordercreate.dart';
import 'package:todotodo/diler/orders.dart';
import 'package:todotodo/diler/works.dart';

class DilerProfile extends StatefulWidget {
  const DilerProfile({super.key});

  @override
  State<DilerProfile> createState() => _DilerProfileState();
}

class _DilerProfileState extends State<DilerProfile> {
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  String _dropdownvalue = 'Мой регион';

  List<dynamic> items = [];


  dynamic _logourl;
  dynamic logopath;

  List<PlatformFile>? _paths;

  bool ispicked = false;

  final _formKey = GlobalKey<FormState>();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();



  _setdata() async {
    final SharedPreferences prefs = await _prefs;
    final String? token = prefs.getString('token');
    var response =  await Dio().get('https://xn----gtbdlmdrgbq5j.xn--p1ai/api/v1/profile/', options: Options(headers: {'Authorization': 'Token $token'}));
    if (!mounted) return;
    setState(() {
      _logourl = response.data['logo'];
      _companyController.text = response.data['company'];
      _companyController.selection = TextSelection.fromPosition(TextPosition(offset: _companyController.text.length));
      _fullNameController.text = response.data['fio'];
      _fullNameController.selection = TextSelection.fromPosition(TextPosition(offset: _fullNameController.text.length));
      _phoneController.text = response.data['phone'];
      _phoneController.selection = TextSelection.fromPosition(TextPosition(offset: _phoneController.text.length));
      _emailController.text = response.data['email'];
      _emailController.selection = TextSelection.fromPosition(TextPosition(offset: _emailController.text.length));
      _addressController.text = response.data['warehouse_address'];
      _addressController.selection = TextSelection.fromPosition(TextPosition(offset: _addressController.text.length));
      items = response.data['regions'];
      _dropdownvalue = response.data['region'];
    });
  }

  @override
  void initState() {
    super.initState();
    _setdata();
  }

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

  void _bottomTab (int index) async {
    if (index==0){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const DilerOrders()));
    } else if (index==1) {
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const DilerWorks()));
    } else if (index==2) {
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const OrderCreate()));
    } else if (index==3) {
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const DilerArchive()));
    } else if (index==4) {
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const DilerProfile()));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomNavigationBar(
        onTap: _bottomTab,
        unSelectedColor: const Color(0xff8A8A8A
),
        selectedColor: const Color(0xff15CE73),
        currentIndex: 4,
        items: <CustomNavigationBarItem>[
          CustomNavigationBarItem(
            icon: const Icon(CustomIcon.orders),
            title: const Text('Заказы')
          ),
          CustomNavigationBarItem(
            icon: const Icon(CustomIcon.works),
            title: const Text('В работе')
          ),
          CustomNavigationBarItem(
            icon: SvgPicture.asset('assets/img/create.svg'),
            title: const Text('Создать')
          ),
          CustomNavigationBarItem(
            icon: const Icon(CustomIcon.archive),
            title: const Text('Архив')
          ),
          CustomNavigationBarItem(
            icon: const Icon(CustomIcon.profile),
            title: const Text('Профиль')
          )
        ]
      ),
      body: items.isEmpty ? const Center(child: CircularProgressIndicator()) : SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 60, bottom: 30),
                    child: Text('Мой профиль', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
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
                            Text(_fullNameController.text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                            Text(_dropdownvalue, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
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
                    controller: _companyController,
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
                  child: Text('Имя и Фамилия'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextFormField(
                    controller: _fullNameController,
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
                  child: Text('Контактный номер'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextFormField(
                    controller: _phoneController,
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
                    controller: _emailController,
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
                  child: Text('Адрес склада'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextFormField(
                    controller: _addressController,
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
                  child: Text('Мой регион'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButtonFormField(
                        dropdownColor: Colors.white,
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
                          hintStyle: const TextStyle(fontSize: 16,fontWeight: FontWeight.w400, color: Color(0xff1C1C1E)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)
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
                      ),
                    )
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
                              "logo": logopath != null ?  MultipartFile.fromBytes(_paths!.first.bytes!, filename: _paths!.first.name) : null,
                              "fio": _fullNameController.text,
                              'phone': _phoneController.text,
                              'email': _emailController.text,
                              'company': _companyController.text,
                              'warehouse_address': _addressController.text,
                              'region': _dropdownvalue
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
          )
        )
      )
    );
  }
}