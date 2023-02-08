import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todotodo/diler/orders.dart';
import 'package:todotodo/diler/profile.dart';
import 'package:todotodo/utils/filepicks.dart';

class OrderCreate extends StatefulWidget {
  const OrderCreate({super.key});

  @override
  State<OrderCreate> createState() => _OrderCreateState();
}

class _OrderCreateState extends State<OrderCreate> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _windowCountController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();

  String optpay = 'Вид оплаты';

  var pays = ['Вид оплаты', 'Карта', 'Безнал'];

  String optdel = 'Вид доставки';

  var dels = ['Вид доставки','Адрес клиента','Мой склад','Самовывоз'];


  String optshape = 'Выберите профиль';

  String optimpl = 'Выберите фурнитуру';

  List<PlatformFile>? _paths;

  final _formKey = GlobalKey<FormState>();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();


  _isblnk() async {
    final SharedPreferences prefs = await _prefs;
    final String? token = prefs.getString('token');
    var isblanked = await Dio().get('https://xn----gtbdlmdrgbq5j.xn--p1ai/api/v1/isblanked/', options: Options(headers: {'Authorization': 'Token $token'}));
    if (isblanked.data['isblanked']){
      return showDialog<void>(
        barrierDismissible: false,
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
                  Image.asset('assets/img/profile.png'),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text('Заполните свой профиль', style: TextStyle(color: Color(0xff080696), fontSize: 24, fontWeight: FontWeight.w700))
                  ),
                  SizedBox(
                    width: 400,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color(0xff15CE73))),
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const DilerProfile()));
                      },
                      child: const Text('Перейти в профиль', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                    ),
                  )
                ],
              )
            ),
          );
        },
      );
    }
  }

  Future<Map<String, List<dynamic>>> _setdata() async {
    var response =  await Dio().get('https://xn----gtbdlmdrgbq5j.xn--p1ai/api/v1/data/');
    return Map<String, List<dynamic>>.from(response.data);
  }



  @override
  void initState() {
    super.initState();
    _isblnk();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, List<dynamic>>>(
        future: _setdata(),
        builder: (context, snapshot) {
          if (snapshot.hasError){
            return const Center(child: Text('Error'));
          } else if (snapshot.hasData){
            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 30, bottom: 30, top: 60, right: 30),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          IconButton(padding: EdgeInsets.zero,onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.arrow_back_ios)),
                          const Expanded(flex: 1,child: Text('Создать заказ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600), textAlign: TextAlign.center,)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButtonFormField(
                            dropdownColor: Colors.white,
                            isExpanded: true,
                            value: optshape,
                            items: snapshot.data!['shapes']!.map<DropdownMenuItem<String>>((item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                            decoration: InputDecoration(
                              hintStyle: const TextStyle(fontSize: 16,fontWeight: FontWeight.w400, color: Color(0xff1C1C1E)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)
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
                          ),
                        )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButtonFormField(
                            dropdownColor: Colors.white,
                            isExpanded: true,
                            value: optimpl,
                            items: snapshot.data!['implements']!.map<DropdownMenuItem<String>>((dynamic item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                            decoration: InputDecoration(
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: TextFormField(
                          controller: _addressController,
                          obscureText: false,
                          style: const TextStyle(fontSize: 16),
                          decoration: InputDecoration(
                            hintText: 'Введите адрес доставки',
                            hintStyle: const TextStyle(fontSize: 16, color: Color(0xff1C1C1E)),
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButtonFormField(
                            dropdownColor: Colors.white,
                            isExpanded: true,
                            value: optpay,
                            items: pays.map((String item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                            decoration: InputDecoration(
                              hintStyle: const TextStyle(fontSize: 16,fontWeight: FontWeight.w400, color: Color(0xff1C1C1E)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)
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
                          ),
                        )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButtonFormField(
                            dropdownColor: Colors.white,
                            isExpanded: true,
                            value: optdel,
                            items: dels.map((String item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                            decoration: InputDecoration(
                              hintStyle: const TextStyle(fontSize: 16,fontWeight: FontWeight.w400, color: Color(0xff1C1C1E)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)
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
                          ),
                        )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: TextFormField(
                          controller: _windowCountController,
                          obscureText: false,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(fontSize: 16),
                          decoration: InputDecoration(
                            hintText: 'Количество окон',
                            hintStyle: const TextStyle(fontSize: 16, color: Color(0xff1C1C1E)),
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: TextFormField(
                          controller: _priceController,
                          obscureText: false,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(fontSize: 16),
                          decoration: InputDecoration(
                            hintText: 'Желаемая цена',
                            hintStyle: const TextStyle(fontSize: 16, color: Color(0xff1C1C1E)),
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: TextFormField(
                          minLines: 5,
                          maxLines: 10,
                          controller: _commentController,
                          obscureText: false,
                          style: const TextStyle(fontSize: 16),
                          decoration: InputDecoration(
                            hintText: 'Комментарий к заказу',
                            hintStyle: const TextStyle(fontSize: 16, color: Color(0xff1C1C1E)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)
                            )
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                        padding: const EdgeInsets.only(left: 30, right: 30),
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
                      child: SizedBox(
                        width: 400,
                        height: 50,
                        child: ElevatedButton(
                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color(0xff15CE73))),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()){
                              FormData formData = FormData.fromMap({
                                  "shape": optshape,
                                  'implement': optimpl,
                                  'address': _addressController.text,
                                  'type_pay': optpay,
                                  'type_delivery': optdel,
                                  'amount': _windowCountController.text,
                                  'price': _priceController.text,
                                  'comment': _commentController.text,
                              });
                              for (var path in _paths!) {
                                formData.files.addAll([
                                  MapEntry("upl", MultipartFile.fromBytes(path.bytes!, filename: path.name)),
                                ]);
                              }
                              final SharedPreferences prefs = await _prefs;
                              final String? token = prefs.getString('token');
                              Dio().post('https://xn----gtbdlmdrgbq5j.xn--p1ai/api/v1/orders/', options: Options(headers: {'Authorization': 'Token $token'}), data: formData);
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const DilerOrders()));
                            }
                          },
                          child: const Text('Подтвердить', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                        ),
                      ),
                    )
                  ],
                )
              )
            );
          } 
          return const Center(child: CircularProgressIndicator());
        },
      )
    );
  }
}