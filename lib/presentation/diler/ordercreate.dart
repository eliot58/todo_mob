import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todotodo/domain/state/order/order_state.dart';
import 'package:todotodo/internal/dependencies/order_module.dart';
import 'package:todotodo/presentation/common.dart';
import 'package:todotodo/presentation/diler/orders.dart';

class OrderCreate extends StatefulWidget {
  const OrderCreate({super.key});

  @override
  State<OrderCreate> createState() => _OrderCreateState();
}

class _OrderCreateState extends State<OrderCreate> {
  late OrderState orderState;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    orderState = OrderModule.orderState();
    orderState.isBlankcheck();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
              child: Form(
                  key: _formKey,
                  child: Observer(builder: (context) {
                    if (orderState.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 30, bottom: 30, top: 60, right: 30),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(Icons.arrow_back_ios)),
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    'Создать заказ',
                                    style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
                                    textAlign: TextAlign.center,
                                  )),
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
                                  value: orderState.optshape,
                                  items: orderState.shapes.map<DropdownMenuItem<String>>((item) {
                                    return DropdownMenuItem(
                                      value: item,
                                      child: Text(item),
                                    );
                                  }).toList(),
                                  decoration: InputDecoration(hintStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400, color: const Color(0xff1C1C1E)), border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
                                  onChanged: (dynamic newValue) {
                                    setState(() {
                                      orderState.optshape = newValue!;
                                    });
                                  },
                                  validator: (value) => value == 'Выберите профиль' ? 'Выберите профиль' : null,
                                ),
                              )),
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
                                  value: orderState.optimpl,
                                  items: orderState.implements.map<DropdownMenuItem<String>>((dynamic item) {
                                    return DropdownMenuItem(
                                      value: item,
                                      child: Text(item),
                                    );
                                  }).toList(),
                                  decoration: InputDecoration(hintStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400, color: const Color(0xff1C1C1E)), border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
                                  onChanged: (dynamic newValue) {
                                    setState(() {
                                      orderState.optimpl = newValue!;
                                    });
                                  },
                                  validator: (value) => value == 'Выберите фурнитуру' ? 'Выберите фурнитуру' : null,
                                ),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Container(
                            padding: const EdgeInsets.only(left: 30, right: 30),
                            child: TextFormField(
                              controller: orderState.addressController,
                              obscureText: false,
                              style: TextStyle(fontSize: 16.sp),
                              decoration: InputDecoration(hintText: 'Введите адрес доставки', hintStyle: TextStyle(fontSize: 16.sp, color: const Color(0xff1C1C1E)), border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
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
                                  value: orderState.optpay,
                                  items: orderState.pays.map((String item) {
                                    return DropdownMenuItem(
                                      value: item,
                                      child: Text(item),
                                    );
                                  }).toList(),
                                  decoration: InputDecoration(hintStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400, color: const Color(0xff1C1C1E)), border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      orderState.optpay = newValue!;
                                    });
                                  },
                                  validator: (value) => value == 'Вид оплаты' ? 'Выберите вид оплаты' : null,
                                ),
                              )),
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
                                  value: orderState.optdel,
                                  items: orderState.dels.map((String item) {
                                    return DropdownMenuItem(
                                      value: item,
                                      child: Text(item),
                                    );
                                  }).toList(),
                                  decoration: InputDecoration(hintStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400, color: const Color(0xff1C1C1E)), border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      orderState.optdel = newValue!;
                                    });
                                  },
                                  validator: (value) => value == 'Вид доставки' ? 'Выберите вид доставки' : null,
                                ),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Container(
                            padding: const EdgeInsets.only(left: 30, right: 30),
                            child: TextFormField(
                              controller: orderState.windowCountController,
                              obscureText: false,
                              keyboardType: TextInputType.number,
                              style: TextStyle(fontSize: 16.sp),
                              decoration: InputDecoration(hintText: 'Количество окон', hintStyle: TextStyle(fontSize: 16.sp, color: const Color(0xff1C1C1E)), border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
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
                              controller: orderState.priceController,
                              obscureText: false,
                              keyboardType: TextInputType.number,
                              style: TextStyle(fontSize: 16.sp),
                              decoration: InputDecoration(hintText: 'Желаемая цена', hintStyle: TextStyle(fontSize: 16.sp, color: const Color(0xff1C1C1E)), border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
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
                              controller: orderState.commentController,
                              obscureText: false,
                              style: TextStyle(fontSize: 16.sp),
                              decoration: InputDecoration(hintText: 'Комментарий к заказу', hintStyle: TextStyle(fontSize: 16.sp, color: const Color(0xff1C1C1E)), border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Container(
                              padding: const EdgeInsets.only(left: 30, right: 30),
                              child: CustomImagesFormField(
                                validator: (_) {
                                  if (orderState.paths == null) return 'Прикрепите файл';
                                  return null;
                                },
                                onChanged: (file) {
                                  setState(() {
                                    orderState.paths = file;
                                  });
                                },
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
                          child: SizedBox(
                            width: 400,
                            height: 50,
                            child: ElevatedButton(
                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color(0xff15CE73))),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  await orderState.createOrder();
                                  if (!mounted) return;
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DilerOrders()));
                                }
                              },
                              child: Text('Подтвердить', style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w600)),
                            ),
                          ),
                        )
                      ],
                    );
                  })))),
    );
  }
}
