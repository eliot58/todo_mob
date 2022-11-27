import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todotodo/auth/login.dart';
import 'package:todotodo/provider/archive.dart';
import 'package:todotodo/provider/balance.dart';
import 'package:todotodo/provider/orders.dart';
import 'package:todotodo/provider/profile.dart';
import 'package:todotodo/provider/send.dart';
import 'package:todotodo/provider/work.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class ProviderOrder extends StatefulWidget {
  final int id;

  const ProviderOrder({
    super.key,
    required this.id,
  });

  @override
  State<ProviderOrder> createState() => _ProviderOrderState();
}

class _ProviderOrderState extends State<ProviderOrder> {
  final TextEditingController _date = TextEditingController();
  final TextEditingController _price = TextEditingController();
  final TextEditingController _comment = TextEditingController();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  dynamic _orderdata = {
    'address': '',
    'shape': '',
    'implement': '',
    'type_pay': '',
    'type_delivery': '',
    'price': '',
    'comment': '',
    'file': '',
    'fileurl': ''
  };

  String optshape = 'Выберите профиль';

  List<dynamic> shapes = [];

  String optimpl = 'Выберите фурнитуру';

  List<dynamic> impls = [];

  dynamic filepath;

  String file1 = '';


  final _formKey = GlobalKey<FormState>();

  _pickimg() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      
      setState(() {
        filepath = result.files.single.path;
        file1 = filepath.split('/').last;
      });
    }
    build(context);
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
  

  _setdata() async {
    final SharedPreferences prefs = await _prefs;
    final String? token = prefs.getString('token');
    var response =  await Dio().get('https://xn----gtbdlmdrgbq5j.xn--p1ai/api/v1/order/${widget.id}/', options: Options(headers: {'Authorization': 'Token $token'}));
    setState(() {
      _orderdata = response.data;
      shapes = response.data['shapes'];
      impls = response.data['implements'];
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
          title: const Text("Отклик"),
          backgroundColor: const Color(0xff090696),
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Card(
                    child: ListTile(
                      title: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(_orderdata['address'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Row(
                              children: <Widget>[
                                const Text('Тип оплаты: ', style: TextStyle(color: Colors.black)),
                                Text(_orderdata['type_pay'], style: const TextStyle(color: Colors.black)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Row(
                              children: <Widget>[
                                const Text('Тип доставки: ', style: TextStyle(color: Colors.black)),
                                Text(_orderdata['type_delivery'], style: const TextStyle(color: Colors.black)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Text('Профиль: ${_orderdata["shape"]}', style: const TextStyle(color: Colors.black)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Text('Фурнитура: ${_orderdata["implement"]}', style: const TextStyle(color: Colors.black)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Row(
                              children: <Widget>[
                                const Text('Предложение: ', style: TextStyle(color: Colors.black)),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: const Size(50, 30),
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    alignment: Alignment.centerLeft
                                  ),
                                  onPressed: () async {
                                    var url = Uri.parse('https://xn----gtbdlmdrgbq5j.xn--p1ai${_orderdata["fileurl"]}');
                                    if (!await launchUrl(url)) {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                  child: Text(_orderdata["file"], style: const TextStyle(color: Colors.blue))
                                ),
                              ],
                            ),
                          ),
                        ]
                      )
                    ),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: const Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text('Комментарий', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(_orderdata['comment'], style: const TextStyle(color: Colors.black)),
                    ),
                  )
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  child: Text('Предложение', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Container(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: TextFormField(
                            controller: _date,
                            obscureText: false,
                            style: const TextStyle(fontSize: 16),
                            decoration: InputDecoration(
                              hintText: 'Дата поставки',
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
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  lastDate: DateTime(2100));
                            
                              if (pickedDate != null) {
                                String formattedDate =
                                    DateFormat('dd-MM-yyyy').format(pickedDate);
                                
                                setState(() {
                                  _date.text =
                                      formattedDate;
                                });
                              } else {}
                            },
                          ),
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
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
                            controller: _price,
                            obscureText: false,
                            style: const TextStyle(fontSize: 16),
                            decoration: InputDecoration(
                              hintText: 'Стоимость',
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
                            controller: _comment,
                            obscureText: false,
                            style: const TextStyle(fontSize: 16),
                            decoration: InputDecoration(
                              hintText: 'Комментарий',
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
                          onPressed: _pickimg,
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(const Color(0xff090696))
                          ),
                          child: const Text('Прикрепить файл')
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 20),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (file1 == ''){
                              return showDialog<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Прикрепите файл'),
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
                            } else {
                              if (_formKey.currentState!.validate()){
                                FormData formData = FormData.fromMap({
                                  'date': _date.text,
                                  'shape': optshape,
                                  'implement': optimpl,
                                  'price': _price.text,
                                  'comment': _comment.text,
                                  "upload": filepath != null ?  await MultipartFile.fromFile(filepath, filename: 'quantity') : null,
                                });
                                final SharedPreferences prefs = await _prefs;
                                final String? token = prefs.getString('token');
                                var response =  await Dio().post('https://xn----gtbdlmdrgbq5j.xn--p1ai/api/v1/response/${widget.id}/', options: Options(headers: {'Authorization': 'Token $token'}), data: formData);
                                if (response.data['success']){
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const ProviderSend()));
                                }
                              }
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(const Color(0xff090696))
                          ),
                          child: const Text('Отправить')
                        ),
                      )
                    ],
                  ),
                )
              ],
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