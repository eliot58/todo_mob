import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todotodo/custom_icons.dart';
import 'package:todotodo/domain/state/diler/profile_state.dart';
import 'package:todotodo/internal/dependencies/diler_profile_module.dart';
import 'package:todotodo/presentation/diler/archive.dart';
import 'package:todotodo/presentation/diler/ordercreate.dart';
import 'package:todotodo/presentation/diler/orders.dart';
import 'package:todotodo/presentation/diler/works.dart';

class DilerProfile extends StatefulWidget {
  const DilerProfile({super.key});

  @override
  State<DilerProfile> createState() => _DilerProfileState();
}

class _DilerProfileState extends State<DilerProfile> {
  late ProfileState profileState;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    profileState = DilerProfileModule.profileState();
    profileState.getProfile();
  }

  Widget _imgget() {
    if (profileState.isPicked) {
      return IconButton(icon: CircleAvatar(radius: 50, backgroundImage: MemoryImage(profileState.logopath!.first.bytes!)), onPressed: profileState.pickImg, iconSize: 47);
    }
    if (profileState.logourl == null) {
      return IconButton(icon: Image.asset('assets/img/avatar.png'), onPressed: profileState.pickImg, iconSize: 47);
    }
    return IconButton(icon: CircleAvatar(radius: 50, backgroundImage: NetworkImage('http://127.0.0.1:8000${profileState.logourl}')), onPressed: profileState.pickImg, iconSize: 47);
  }

  void _bottomTab(int index) async {
    if (index == 0) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const DilerOrders()));
    } else if (index == 1) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const DilerWorks()));
    } else if (index == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderCreate()));
    } else if (index == 3) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const DilerArchive()));
    } else if (index == 4) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const DilerProfile()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: CustomNavigationBar(onTap: _bottomTab, unSelectedColor: const Color(0xff8A8A8A), selectedColor: const Color(0xff15CE73), currentIndex: 4, items: <CustomNavigationBarItem>[
            CustomNavigationBarItem(icon: const Icon(CustomIcon.orders), title: const Text('Заказы')),
            CustomNavigationBarItem(icon: const Icon(CustomIcon.works), title: const Text('В работе')),
            CustomNavigationBarItem(icon: SvgPicture.asset('assets/img/create.svg'), title: const Text('Создать')),
            CustomNavigationBarItem(icon: const Icon(CustomIcon.archive), title: const Text('Архив')),
            CustomNavigationBarItem(icon: const Icon(CustomIcon.profile), title: const Text('Профиль'))
          ]),
          body: SingleChildScrollView(
              child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Observer(builder: (context) {
                      if (profileState.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return Column(
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
                                      children: <Widget>[Text(profileState.fullNameController.text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)), Text(profileState.dropdownvalue, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500))],
                                    ),
                                  )
                                ],
                              )),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text('Название компании'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: TextFormField(
                              controller: profileState.companyController,
                              obscureText: false,
                              style: const TextStyle(fontSize: 16),
                              decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
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
                              controller: profileState.fullNameController,
                              obscureText: false,
                              style: const TextStyle(fontSize: 16),
                              decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
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
                              controller: profileState.phoneController,
                              obscureText: false,
                              keyboardType: TextInputType.phone,
                              style: const TextStyle(fontSize: 16),
                              decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
                              validator: (value) {
                                final phoneRegExp = RegExp(r"^(\+7|7|8)?[\s\-]?\(?[489][0-9]{2}\)?[\s\-]?[0-9]{3}[\s\-]?[0-9]{2}[\s\-]?[0-9]{2}$");
                                if (value == null || value.isEmpty) {
                                  return 'Заполните поле';
                                } else if (!phoneRegExp.hasMatch(value)) {
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
                              controller: profileState.emailController,
                              obscureText: false,
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(fontSize: 16),
                              decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
                              validator: (value) {
                                final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                                if (value == null || value.isEmpty) {
                                  return 'Заполните поле';
                                } else if (!emailRegExp.hasMatch(value)) {
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
                              controller: profileState.addressController,
                              obscureText: false,
                              keyboardType: TextInputType.streetAddress,
                              style: const TextStyle(fontSize: 16),
                              decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
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
                                  value: profileState.dropdownvalue,
                                  items: profileState.regions.map((dynamic item) {
                                    return DropdownMenuItem(
                                      value: item,
                                      child: Text(item),
                                    );
                                  }).toList(),
                                  decoration: InputDecoration(filled: true, fillColor: Colors.white, hintStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xff1C1C1E)), border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
                                  onChanged: (dynamic newValue) {
                                    setState(() {
                                      profileState.dropdownvalue = newValue!;
                                    });
                                  },
                                  validator: (value) => value == 'Мой регион' ? 'Мой регион' : null,
                                ),
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
                                    profileState.saveProfile();
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
                                                    const Text(
                                                      'Профиль сохранён',
                                                      style: TextStyle(color: Color(0xff080696), fontSize: 16, fontWeight: FontWeight.w700),
                                                    ),
                                                    Image.asset('assets/img/check.png'),
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
                                                )),
                                          );
                                        });
                                  }
                                },
                                child: const Text('Подтвердить', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                              ),
                            ),
                          )
                        ],
                      );
                    }),
                  )))),
    );
  }
}
