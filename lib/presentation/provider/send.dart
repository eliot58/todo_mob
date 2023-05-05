import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:todotodo/domain/state/quantity/quantity_state.dart';
import 'package:todotodo/internal/dependencies/quantity_module.dart';
import 'package:todotodo/presentation/common.dart';
import 'package:url_launcher/url_launcher.dart';

import 'works.dart';

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
  late QuantityState quantityState;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    quantityState = QuantityModule.quantityState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
              child: Container(
        padding: const EdgeInsets.only(top: 60, left: 15, right: 15),
        child: Form(
            key: _formKey,
            child: Observer(
              builder: (context) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back_ios)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Image.asset('assets/img/cart.png'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Text('${quantityState.price} рублей x ${quantityState.countWindow}', style: const TextStyle(color: Color(0xff15CE73), fontSize: 20, fontWeight: FontWeight.w600)),
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
                            Text(quantityState.date)
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.only(bottom: 8),
                              child: Text('Профиль'),
                            ),
                            Text(quantityState.shape)
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.only(bottom: 8),
                              child: Text('Фурнитура'),
                            ),
                            Text(quantityState.implement)
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Text('Эскиз'),
                            IconButton(
                                onPressed: () async {
                                  var url = Uri.parse('http://127.0.0.1:8000${quantityState.fileurl}');
                                  if (!await launchUrl(url)) {
                                    throw 'Could not launch $url';
                                  }
                                },
                                icon: Image.asset('assets/img/folder.png'))
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        SvgPicture.asset('assets/img/ico/location.svg'),
                        Padding(
                          padding: const EdgeInsets.only(left: 2),
                          child: Text(quantityState.address),
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
                      decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(quantityState.comment,
                            style: const TextStyle(
                              color: Color(0xff080696),
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            )),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 15, bottom: 24),
                      child: Text('Заполните поля:',
                          style: TextStyle(
                            color: Color(0xff080696),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Text('Дата поставки',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          )),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1950), lastDate: DateTime(2100));
    
                          if (pickedDate != null) {
                            String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
    
                            setState(() {
                              quantityState.dateController.text = formattedDate;
                            });
                          }
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Выберите дату поставки';
                          }
                          return null;
                        },
                        controller: quantityState.dateController,
                        obscureText: false,
                        style: const TextStyle(fontSize: 16),
                        decoration: InputDecoration(filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Text('Профиль',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          )),
                    ),
                    Container(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButtonFormField(
                            dropdownColor: Colors.white,
                            isExpanded: true,
                            value: quantityState.optshape,
                            items: quantityState.shapes.map((dynamic item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                            decoration: InputDecoration(filled: true, fillColor: Colors.white, hintStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xff1C1C1E)), border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
                            onChanged: (dynamic newValue) {
                              setState(() {
                                quantityState.optshape = newValue!;
                              });
                            },
                            validator: (value) => value == 'Выберите профиль' ? 'Выберите профиль' : null,
                          ),
                        )),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Text('Фурнитура',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          )),
                    ),
                    Container(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButtonFormField(
                            dropdownColor: Colors.white,
                            isExpanded: true,
                            value: quantityState.optimpl,
                            items: quantityState.impls.map((dynamic item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                            decoration: InputDecoration(filled: true, fillColor: Colors.white, hintStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xff1C1C1E)), border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
                            onChanged: (dynamic newValue) {
                              setState(() {
                                quantityState.optimpl = newValue!;
                              });
                            },
                            validator: (value) => value == 'Выберите фурнитуру' ? 'Выберите фурнитуру' : null,
                          ),
                        )),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Text('Стоимость',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          )),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                        controller: quantityState.priceController,
                        obscureText: false,
                        style: const TextStyle(fontSize: 16),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Заполните поле';
                          }
                          return null;
                        },
                        decoration: InputDecoration(filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: TextFormField(
                        minLines: 5,
                        maxLines: 10,
                        controller: quantityState.commentController,
                        obscureText: false,
                        style: const TextStyle(fontSize: 16),
                        decoration: InputDecoration(hintText: 'Комментарий к заказу', hintStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xff8391A1)), filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
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
                            if (quantityState.paths == null) return 'Прикрепите файл';
                            return null;
                          },
                          onChanged: (file) {
                            setState(() {
                              quantityState.paths = file;
                            });
                          },
                        )),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: SizedBox(
                        width: 400,
                        height: 50,
                        child: ElevatedButton(
                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color(0xff15CE73))),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              quantityState.createQuantity();
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ProviderWorks()));
                            }
                          },
                          child: const Text('Откликнуться', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ),
                  ],
                );
              }
            )),
      ))),
    );
  }
}
