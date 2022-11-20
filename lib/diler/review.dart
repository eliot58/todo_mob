import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:multiselect/multiselect.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todotodo/diler/archive.dart';
import 'package:todotodo/diler/card.dart';
import 'package:todotodo/diler/create.dart';
import 'package:todotodo/diler/orders.dart';
import 'package:todotodo/diler/profile.dart';
import 'package:todotodo/diler/work.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class DilerReview extends StatefulWidget {
  final int id;
  final String companyname;

  const DilerReview({
    super.key,
    required this.id,
    required this.companyname
  });

  @override
  State<DilerReview> createState() => _DilerReviewState();
}

class _DilerReviewState extends State<DilerReview> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Отзыв"),
          backgroundColor: const Color(0xff07995c),
        ),
        body: Container(
          color: Colors.white,
          child: Card(
            child: ListTile(
              title: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: <Widget>[
                    const Text('Заказчик: ', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(50, 30),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        alignment: Alignment.centerLeft
                      ),
                      onPressed: () async {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> CompanyCard(id: widget.id)));
                      },
                      child: Text(widget.companyname, style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 16))
                    ),
                  ],
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text('Качество продукции'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: RatingBar.builder(
                      initialRating: 4,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text('Качество доставки'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: RatingBar.builder(
                      initialRating: 4,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text('Лояльность поставщика'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: RatingBar.builder(
                      initialRating: 4,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: ElevatedButton(
                      onPressed: () async {
                        
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(const Color(0xff07995c))
                      ),
                      child: const Text('Отправить', style: TextStyle(color: Colors.white))
                    ),
                  )
                ],
              ),
            ),
          )
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              ListTile(
                title: const Text('Профиль'),
                leading: const Icon(Icons.account_box),
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const DilerProfile()));
                }
              ),
              ListTile(
                title: const Text('Создать заказ'),
                leading: const Icon(Icons.create),
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const DilerCreate()));
                }
              ),
              ListTile(
                title: const Text('Мои заказы'),
                leading: const Icon(Icons.receipt_long_outlined),
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const DilerOrders()));
                }
              ),
              ListTile(
                title: const Text('В работе'),
                leading: const Icon(Icons.work),
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const DilerWork()));
                }
              ),
              ListTile(
                title: const Text('Архив'),
                leading: const Icon(Icons.archive),
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const DilerArchive()));
                }
              ),
              ListTile(
                title: const Text('Выход'),
                leading: const Icon(Icons.exit_to_app),
                onTap: () async {
                  final SharedPreferences prefs = await _prefs;
                  final String? token = prefs.getString('token');
                  await Dio().get('https://xn----gtbdlmdrgbq5j.xn--p1ai/api/v1/auth/token/logout/', options: Options(headers: {'Authorization': 'Token $token'}));
                  await prefs.remove('token');
                  Navigator.pushReplacementNamed(context, '/');
                }
              ),
            ],
          ),
        )

      ),
    );
  }
}