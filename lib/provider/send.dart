import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todotodo/provider/works.dart';
import 'package:todotodo/utils/filepick.dart';
import 'package:url_launcher/url_launcher.dart';


class ProviderSend extends StatefulWidget {
  final int id;

  const ProviderSend({
    super.key,
    required this.id,
  });

  @override
  State<ProviderSend> createState() => _ProviderSendState();
}

class _ProviderSendState extends State<ProviderSend> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();


  dynamic _orderdata = {
    'address': '',
    'shape': '',
    'implement': '',
    'type_pay': '',
    'type_delivery': '',
    'price': '',
    'comment': '',
    'file': '',
    'fileurl': '',
    'date': '',
    'count_window': ''
  };

  String optshape = 'Выберите профиль';

  List<dynamic> shapes = [];

  String optimpl = 'Выберите фурнитуру';

  List<dynamic> impls = [];

  List<PlatformFile>? _paths;


  final _formKey = GlobalKey<FormState>();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  

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
    return impls.isEmpty ? const Center(
      child: CircularProgressIndicator()
    ) : Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 60, left: 15, right: 15),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.arrow_back_ios)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Image.asset('assets/img/cart.png'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Text('${_orderdata['price']} рублей x ${_orderdata['count_window']}', style: const TextStyle(color: Color(0xff15CE73), fontSize: 20, fontWeight: FontWeight.w600)),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Text('Дата'),
                        ),
                        Text(_orderdata['date'])
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Text('Профиль'),
                        ),
                        Text(_orderdata['shape'])
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Text('Фурнитура'),
                        ),
                        Text(_orderdata['implement'])
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const Text('Эскиз'),
                        IconButton(onPressed: () async {
                          var url = Uri.parse('https://xn----gtbdlmdrgbq5j.xn--p1ai${_orderdata["fileurl"]}');
                          if (!await launchUrl(url)) {
                            throw 'Could not launch $url';
                          }
                        }, icon: Image.asset('assets/img/ico/folder.png'))
                      ],
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    SvgPicture.asset('assets/img/ico/location.svg'),
                    Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: Text(_orderdata['address']),
                    )
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text('Примечание к заказу', style: TextStyle(color: Color(0xff27313C), fontSize: 16, fontWeight: FontWeight.w500)),
                ),
                Container(
                  height: 100,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(_orderdata['comment'], style: const TextStyle(color: Color(0xff080696), fontSize: 18, fontWeight: FontWeight.w400, )),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 24),
                  child: Text('Заполните поля:', style: TextStyle(color: Color(0xff080696), fontSize: 16, fontWeight: FontWeight.w600, )),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text('Дата поставки', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, )),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextFormField(
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
                          _dateController.text =
                              formattedDate;
                        });
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Выберите дату поставки';
                      }
                      return null;
                    },
                    controller: _dateController,
                    obscureText: false,
                    style: const TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)
                      )
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text('Профиль', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, )),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButtonFormField(
                        dropdownColor: Colors.white,
                        isExpanded: true,
                        value: optshape,
                        items: shapes.map((dynamic item) {
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
                            optshape= newValue!;
                          });
                        },
                        validator: (value) => value == 'Выберите профиль'
                          ? 'Выберите профиль'
                          : null,
                      ),
                    )
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text('Фурнитура', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, )),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButtonFormField(
                        dropdownColor: Colors.white,
                        isExpanded: true,
                        value: optimpl,
                        items: impls.map((dynamic item) {
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
                            optimpl= newValue!;
                          });
                        },
                        validator: (value) => value == 'Выберите фурнитуру'
                          ? 'Выберите фурнитуру'
                          : null,
                      ),
                    )
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text('Стоимость', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, )),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextFormField(
                    controller: _priceController,
                    obscureText: false,
                    style: const TextStyle(fontSize: 16),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Заполните поле';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)
                      )
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: TextFormField(
                    minLines: 5,
                    maxLines: 10,
                    controller: _commentController,
                    obscureText: false,
                    style: const TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                      hintText: 'Комментарий к заказу',
                      hintStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xff8391A1)),
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
                  padding: const EdgeInsets.only(bottom: 10),
                  child: CustomImageFormField(
                    validator: (_) {
                      if (_paths == null) return 'Прикрепите файл';
                      return null;
                    },
                    onChanged: (file) {
                      setState(() {
                        _paths = file;
                      });
                    },
                  )
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: SizedBox(
                    width: 400,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color(0xff15CE73))),
                      onPressed: () async {
                        
                          if (_formKey.currentState!.validate()){
                            FormData formData = FormData.fromMap({
                              'date': _dateController.text,
                              'shape': optshape,
                              'implement': optimpl,
                              'price': _priceController.text,
                              'comment': _commentController.text,
                              "upload": MultipartFile.fromBytes(_paths!.first.bytes!, filename: _paths!.first.name),
                            });
                            final SharedPreferences prefs = await _prefs;
                            final String? token = prefs.getString('token');
                            Dio().post('https://xn----gtbdlmdrgbq5j.xn--p1ai/api/v1/response/${widget.id}/', options: Options(headers: {'Authorization': 'Token $token'}), data: formData);
                            if (!mounted) return;
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const ProviderWorks()));
                            
                          }
                        
                      },
                      child: const Text('Откликнуться', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                    ),
                  ),
                ),
              ],
            )
          ),
        )
      )
    );
  }
}