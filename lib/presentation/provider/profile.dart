import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multiselect/multiselect.dart';
import 'package:todotodo/custom_icons.dart';
import 'package:todotodo/domain/state/provider/profile_state.dart';
import 'package:todotodo/internal/dependencies/provider_profile_module.dart';
import 'package:todotodo/presentation/provider/contacts.dart';

import 'archive.dart';
import 'balance.dart';
import 'orders.dart';
import 'works.dart';

class ProviderProfile extends StatefulWidget {
  const ProviderProfile({super.key});

  @override
  State<ProviderProfile> createState() => _ProviderProfileState();
}

class _ProviderProfileState extends State<ProviderProfile> {
  late ProfileState profileState;

  final _formKey = GlobalKey<FormState>();

  Widget _imgget() {
    if (profileState.isPicked) {
      return IconButton(icon: CircleAvatar(radius: 50, backgroundImage: MemoryImage(profileState.logopath!.first.bytes!)), onPressed: profileState.pickImg, iconSize: 47);
    }
    if (profileState.logourl == null) {
      return IconButton(icon: Image.asset('assets/img/avatar.png'), onPressed: profileState.pickImg, iconSize: 47);
    }
    return IconButton(icon: CircleAvatar(radius: 50, backgroundImage: NetworkImage('${dotenv.env["api_url"]}${profileState.logourl}')), onPressed: profileState.pickImg, iconSize: 47);
  }

  @override
  void initState() {
    super.initState();
    profileState = ProviderProfileModule.profileState();
    profileState.getProfile();
  }

  void _bottomTab(int index) async {
    if (index == 0) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ProviderOrders()));
    } else if (index == 1) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const Balance()));
    } else if (index == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ProviderWorks()));
    } else if (index == 3) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ProviderArchive()));
    } else if (index == 4) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ProviderProfile()));
    } else if (index == 5) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const Contacts()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: CustomNavigationBar(onTap: _bottomTab, currentIndex: 4, unSelectedColor: const Color(0xff8A8A8A), selectedColor: const Color(0xff080696), items: <CustomNavigationBarItem>[
            CustomNavigationBarItem(icon: const Icon(CustomIcon.orders), title: Text('Заказы', style: TextStyle(fontSize: 10.sp))),
            CustomNavigationBarItem(icon: const Icon(CustomIcon.wallet), title: Text('Подписка', style: TextStyle(fontSize: 10.sp))),
            CustomNavigationBarItem(icon: const Icon(CustomIcon.redo), title: Text('Статусы', style: TextStyle(fontSize: 10.sp))),
            CustomNavigationBarItem(icon: const Icon(CustomIcon.archive), title: Text('Архив', style: TextStyle(fontSize: 10.sp))),
            CustomNavigationBarItem(icon: const Icon(CustomIcon.bag), title: Text('Профиль', style: TextStyle(fontSize: 10.sp))),
            CustomNavigationBarItem(icon: const Icon(CustomIcon.friends), title: Text('Контакты', style: TextStyle(fontSize: 10.sp)))
          ]),
          body: SingleChildScrollView(
              child: Form(
                  key: _formKey,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Observer(builder: (context) {
                        if (profileState.isLoading) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 60, bottom: 30),
                                child: Text('Профиль компании', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600)),
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
                                        children: <Widget>[Text(profileState.contactentity.text, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600)), Text(profileState.productaddress.text, style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500))],
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
                                controller: profileState.company,
                                obscureText: false,
                                style: TextStyle(fontSize: 16.sp),
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
                              child: Text('Юридическое лицо'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: TextFormField(
                                controller: profileState.legalentity,
                                obscureText: false,
                                style: TextStyle(fontSize: 16.sp),
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
                              child: Text('Адрес производства'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: TextFormField(
                                controller: profileState.productaddress,
                                obscureText: false,
                                keyboardType: TextInputType.streetAddress,
                                style: TextStyle(fontSize: 16.sp),
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
                              child: Text('Руководитель'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: TextFormField(
                                controller: profileState.contactentity,
                                obscureText: false,
                                style: TextStyle(fontSize: 16.sp),
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
                              child: Text('Телефон производства'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: TextFormField(
                                controller: profileState.contactphone,
                                obscureText: false,
                                keyboardType: TextInputType.phone,
                                style: TextStyle(fontSize: 16.sp),
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
                              child: Text('Менеджер'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: TextFormField(
                                controller: profileState.serviceentity,
                                obscureText: false,
                                style: TextStyle(fontSize: 16.sp),
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
                              child: Text('Контактный телефон'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: TextFormField(
                                controller: profileState.servicephone,
                                obscureText: false,
                                keyboardType: TextInputType.phone,
                                style: TextStyle(fontSize: 16.sp),
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
                                controller: profileState.serviceemail,
                                obscureText: false,
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(fontSize: 16.sp),
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
                              child: Text('Профили'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: DropDownMultiSelect(
                                onChanged: (List<String> x) {
                                  setState(() {
                                    profileState.selectedShapes = x;
                                  });
                                },
                                options: profileState.shapes,
                                selectedValues: profileState.selectedShapes,
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
                                    profileState.selectedImpl = x;
                                  });
                                },
                                options: profileState.implements,
                                selectedValues: profileState.selectedImpl,
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
                                    profileState.selectedRegions = x;
                                  });
                                },
                                options: profileState.regions,
                                selectedValues: profileState.selectedRegions,
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
                                controller: profileState.description,
                                obscureText: false,
                                style: TextStyle(fontSize: 16.sp),
                                decoration: InputDecoration(filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
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
                                                      Text(
                                                        'Профиль сохранён',
                                                        style: TextStyle(color: const Color(0xff080696), fontSize: 16.sp, fontWeight: FontWeight.w700),
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
                                                          child: Text('Закрыть', style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w600)),
                                                        ),
                                                      )
                                                    ],
                                                  )),
                                            );
                                          });
                                    }
                                  },
                                  child: Text('Подтвердить', style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w600)),
                                ),
                              ),
                            )
                          ],
                        );
                      }),
                    ),
                  )))),
    );
  }
}
