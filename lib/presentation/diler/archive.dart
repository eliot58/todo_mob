import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todotodo/custom_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:todotodo/domain/state/archive/archive_state.dart';
import 'package:todotodo/internal/dependencies/archive_module.dart';
import 'package:todotodo/presentation/auth/login.dart';
import 'package:todotodo/presentation/diler/ordercreate.dart';
import 'package:todotodo/presentation/diler/orders.dart';
import 'package:todotodo/presentation/diler/profile.dart';
import 'package:todotodo/presentation/diler/works.dart';

class DilerArchive extends StatefulWidget {
  const DilerArchive({super.key});

  @override
  State<DilerArchive> createState() => _DilerArchiveState();
}

class _DilerArchiveState extends State<DilerArchive> {
  late ArchiveState archivesState;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

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
  void initState() {
    super.initState();
    archivesState = ArchivesModule.archivesState();
    archivesState.getArchives();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: CustomNavigationBar(onTap: _bottomTab, unSelectedColor: const Color(0xff8A8A8A), selectedColor: const Color(0xff15CE73), currentIndex: 3, items: <CustomNavigationBarItem>[
          CustomNavigationBarItem(icon: const Icon(CustomIcon.orders), title: const Text('Заказы')),
          CustomNavigationBarItem(icon: const Icon(CustomIcon.works), title: const Text('В работе')),
          CustomNavigationBarItem(icon: SvgPicture.asset('assets/img/create.svg'), title: const Text('Создать')),
          CustomNavigationBarItem(icon: const Icon(CustomIcon.archive), title: const Text('Архив')),
          CustomNavigationBarItem(icon: const Icon(CustomIcon.profile), title: const Text('Профиль'))
        ]),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Observer(
              builder: (context) {
                if (archivesState.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 100, bottom: 25),
                      child: Center(
                        child: Row(crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Image.asset('assets/img/todotodo_logo.png', width: 43, height: 43),
                          ),
                          const Text('Todotodo.дилеры', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Color(0xff15CE73))),
                          GestureDetector(
                            onTap: () async {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Login()));
                              final SharedPreferences prefs = await _prefs;
                              final String? token = prefs.getString('token');
                              await prefs.remove('token');
                              Dio().get('http://127.0.0.1:8000/api/v1/auth/token/logout/', options: Options(headers: {'Authorization': 'Token $token'}));
                            },
                            child: const Icon(Icons.exit_to_app),
                          )
                        ]),
                      ),
                    ),
                    ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: archivesState.archives.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Card(
                              elevation: 16,
                              shadowColor: Colors.black,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: const BorderSide(color: Color(0xff15CE73))),
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                  child: ListTile(
                                    trailing: ElevatedButton(
                                        onPressed: archivesState.archives[index]["isreview"]
                                            ? null
                                            : () async {
                                                showDialog(
                                                    context: context,
                                                    builder: (BuildContext context) {
                                                      return StatefulBuilder(
                                                        builder: (BuildContext context, void Function(void Function()) setState) {
                                                          return Dialog(
                                                              backgroundColor: const Color(0xffF2F2F2),
                                                              insetPadding: const EdgeInsets.all(2),
                                                              child: SizedBox(
                                                                width: double.infinity,
                                                                height: MediaQuery.of(context).size.height * 0.75,
                                                                child: Padding(
                                                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    children: <Widget>[
                                                                      const Padding(
                                                                        padding: EdgeInsets.only(bottom: 15),
                                                                        child: Center(child: Text('Оцените работу поставщика', style: TextStyle(color: Color(0xff080696), fontSize: 16, fontWeight: FontWeight.w700))),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(bottom: 20),
                                                                        child: Center(child: Text(archivesState.archives[index]['author_company'], textAlign: TextAlign.center, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700))),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(bottom: 20),
                                                                        child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          children: <Widget>[
                                                                            const Text('Качество продукции', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xff353A3D))),
                                                                            RatingBar.builder(
                                                                              itemSize: 20,
                                                                              initialRating: archivesState.productQuality,
                                                                              direction: Axis.horizontal,
                                                                              allowHalfRating: true,
                                                                              itemCount: 5,
                                                                              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                                                                              itemBuilder: (context, _) => const Icon(
                                                                                Icons.star,
                                                                                color: Colors.amber,
                                                                              ),
                                                                              onRatingUpdate: (rating) {
                                                                                setState(() {
                                                                                  archivesState.productQuality = rating;
                                                                                });
                                                                              },
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(bottom: 20),
                                                                        child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          children: <Widget>[
                                                                            const Text('Качество доставки', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xff353A3D))),
                                                                            RatingBar.builder(
                                                                              itemSize: 20,
                                                                              initialRating: archivesState.deliveryQuality,
                                                                              direction: Axis.horizontal,
                                                                              allowHalfRating: true,
                                                                              itemCount: 5,
                                                                              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                                                                              itemBuilder: (context, _) => const Icon(
                                                                                Icons.star,
                                                                                color: Colors.amber,
                                                                              ),
                                                                              onRatingUpdate: (rating) {
                                                                                setState(() {
                                                                                  archivesState.deliveryQuality = rating;
                                                                                });
                                                                              },
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(bottom: 20),
                                                                        child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          children: <Widget>[
                                                                            const Text('Лояльность поставщика', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xff353A3D))),
                                                                            RatingBar.builder(
                                                                              itemSize: 20,
                                                                              initialRating: archivesState.supplierLoyalty,
                                                                              direction: Axis.horizontal,
                                                                              allowHalfRating: true,
                                                                              itemCount: 5,
                                                                              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                                                                              itemBuilder: (context, _) => const Icon(
                                                                                Icons.star,
                                                                                color: Colors.amber,
                                                                              ),
                                                                              onRatingUpdate: (rating) {
                                                                                setState(() {
                                                                                  archivesState.supplierLoyalty = rating;
                                                                                });
                                                                              },
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width: 400,
                                                                        height: 50,
                                                                        child: ElevatedButton(
                                                                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color(0xff15CE73))),
                                                                          onPressed: () async {
                                                                            archivesState.sendReview(id: archivesState.archives[index]['author_id']);
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child: const Text('Оставить отзыв', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ));
                                                        },
                                                      );
                                                    });
                                              },
                                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color(0xff07995c))),
                                        child: Text(archivesState.archives[index]["isreview"] ? 'Отзыв поставлен' : 'Оценить', style: const TextStyle(color: Colors.white))),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 12),
                                          child: Text(archivesState.archives[index]['date'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 12),
                                          child: RichText(
                                              text: TextSpan(
                                            text: 'Количество КП: ',
                                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff15CE73)),
                                            children: <TextSpan>[TextSpan(text: archivesState.archives[index]["kpcount"].toString(), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black))],
                                          )),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 12),
                                          child: RichText(
                                              text: TextSpan(
                                            text: 'Желаемая цена: ',
                                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff15CE73)),
                                            children: <TextSpan>[TextSpan(text: archivesState.archives[index]["price"].toString(), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black))],
                                          )),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 12),
                                          child: RichText(
                                              text: TextSpan(
                                            text: 'Профиль: ',
                                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff15CE73)),
                                            children: <TextSpan>[TextSpan(text: archivesState.archives[index]["shape"], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black))],
                                          )),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 12),
                                          child: RichText(
                                              text: TextSpan(
                                            text: 'Фурнитура: ',
                                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff15CE73)),
                                            children: <TextSpan>[TextSpan(text: archivesState.archives[index]["implement"], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black))],
                                          )),
                                        )
                                      ],
                                    ),
                                  ))),
                        );
                      },
                    )
                  ],
                );
              }
            ),
          ),
        ),
      ),
    );
  }
}
