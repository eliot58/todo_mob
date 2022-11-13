import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

// class DilerOrder extends StatefulWidget {
//   final int id;

//   const DilerOrder({
//     super.key,
//     required this.id,
//   });



//   @override
//   State<DilerOrder> createState() => _DilerOrderState(id);
// }

// class _DilerOrderState extends State<DilerOrder> {
//   final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
//   final int id;
  
//   dynamic _orderdata;
  
//   _DilerOrderState(this.id);

//   _setdata() async {
//     var response =  await Dio().get('http://127.0.0.1:8000/api/v1/order/${id}/', options: Options(headers: {'Authorization': 'Token 62889d1f4515f03411220f9d27e01fb2db2eba9e'}));
//     setState(() {
//       _orderdata = response.data;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     _setdata();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           title: const Text("Инфо о заказе"),
//           backgroundColor: const Color(0xff07995c),
//         ),
//         body: Container(
//           color: Colors.white,
//           child: Column(
//             children: <Widget>[
//               Padding(
//                 padding: const EdgeInsets.only(top: 5, bottom: 5),
//                 child: Card(
//                   child: ListTile(
//                     title: Padding(
//                       padding: const EdgeInsets.only(bottom: 10),
//                       child: Text(_orderdata['address'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
//                     ),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Padding(
//                           padding: const EdgeInsets.only(bottom: 5),
//                           child: Row(
//                             children: <Widget>[
//                               const Text('Тип оплаты:', style: TextStyle(color: Colors.black)),
//                               Text(_orderdata['type_pay'], style: const TextStyle(color: Colors.black)),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(bottom: 5),
//                           child: Row(
//                             children: <Widget>[
//                               const Text('Тип доставки:', style: TextStyle(color: Colors.black)),
//                               Text(_orderdata['type_delivery'], style: const TextStyle(color: Colors.black)),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(bottom: 5),
//                           child: Text('Профиль: ${_orderdata["shape"]}', style: const TextStyle(color: Colors.black)),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(bottom: 5),
//                           child: Text('Фурнитура: ${_orderdata["implement"]}', style: const TextStyle(color: Colors.black)),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(bottom: 5),
//                           child: Text('Желаемая сумма: ${_orderdata["price"]}', style: const TextStyle(color: Colors.black)),
//                         )
//                       ]
//                     )
//                   ),
//                 ),
//               ),
//               Card(
//                 child: ListTile(
//                   title: const Padding(
//                     padding: EdgeInsets.only(bottom: 10),
//                     child: Text('Комментарий', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
//                   ),
//                   subtitle: Padding(
//                     padding: const EdgeInsets.only(bottom: 10),
//                     child: Text(_orderdata['comment'], style: const TextStyle(color: Colors.black)),
//                   ),
//                 )
//               ),
//               const Padding(
//                 padding: EdgeInsets.only(top: 5, bottom: 5),
//                 child: Text('Предложение', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
//               ),
//               ListView.builder(
//                 itemCount: _orderdata['kp'].length,
//                 scrollDirection: Axis.vertical,
//                 shrinkWrap: true,
//                 itemBuilder: (BuildContext context, int index){
//                   return Card(
//                     child: ListTile(
//                       title: const Padding(
//                         padding: EdgeInsets.only(bottom: 10),
//                         child: Text('Naryn Chorobaev 3', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
//                       ),
//                       subtitle: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Padding(
//                             padding: const EdgeInsets.only(bottom: 5),
//                             child: Text('Заказчик: ${_orderdata["kp"][index]["author_company"]}', style: const TextStyle(color: Colors.black)),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(bottom: 5),
//                             child: Row(
//                               children: <Widget>[
//                                 Text('Дата : ${_orderdata["kp"][index]["date_create"]}', style: const TextStyle(color: Colors.black)),
//                                 Text('Поставка : ${_orderdata["kp"][index]["date"]}', style: const TextStyle(color: Colors.black)),
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(bottom: 5),
//                             child: Text('Профиль: ${_orderdata["kp"][index]["shape"]}', style: const TextStyle(color: Colors.black)),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(bottom: 5),
//                             child: Text('Фурнитура: ${_orderdata["kp"][index]["implement"]}', style: const TextStyle(color: Colors.black)),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(bottom: 5),
//                             child: TextButton(
//                               onPressed: () async {
//                                 var url = Uri.parse(_orderdata["kp"][index]["fileurl"]);
//                                 if (!await launchUrl(url)) {
//                                   throw 'Could not launch $url';
//                                 }
//                               },
//                               child: Text(_orderdata["kp"][index]["file"], style: const TextStyle(color: Colors.black))
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(bottom: 5),
//                             child: Text('Желаемая сумма: ${_orderdata["kp"][index]["price"]}', style: const TextStyle(color: Colors.black)),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(bottom: 5),
//                             child: TextButton(
//                               onPressed: _orderdata["kp"][index]["isresponse"] ? null : () async {
//                                 var response =  await Dio().get('http://127.0.0.1:8000/api/v1/response/${_orderdata["kp"][index]["id"]}/', options: Options(headers: {'Authorization': 'Token 62889d1f4515f03411220f9d27e01fb2db2eba9e'}));
//                                 if (response.data['detail']=='success'){
//                                   setState(() {
//                                     _orderdata["kp"][index]["isresponse"] = false;
//                                   });
//                                 }
//                               },
//                               child: Text(_orderdata["kp"][index]["isresponse"] ? 'заказано' : 'заказать', style: const TextStyle(color: Colors.black))
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               )
//             ],
//           )
//         ),
//         drawer: Drawer(
//           child: ListView(
//             children: <Widget>[
//               ListTile(
//                 title: const Text('Профиль'),
//                 leading: const Icon(Icons.account_box),
//                 onTap: (){
//                   Navigator.pushReplacementNamed(context, '/diler_profile');
//                 }
//               ),
//               ListTile(
//                 title: const Text('Создать заказ'),
//                 leading: const Icon(Icons.create),
//                 onTap: (){
//                   Navigator.pushReplacementNamed(context, '/diler_order_create');
//                 }
//               ),
//               ListTile(
//                 title: const Text('Заказы в регионе'),
//                 leading: const Icon(Icons.receipt_long_outlined),
//                 onTap: (){
//                   Navigator.pushReplacementNamed(context, '/diler_orders');
//                 }
//               ),
//               ListTile(
//                 title: const Text('В работе'),
//                 leading: const Icon(Icons.work),
//                 onTap: (){
//                   Navigator.pushReplacementNamed(context, '/diler_work');
//                 }
//               ),
//               ListTile(
//                 title: const Text('Архив'),
//                 leading: const Icon(Icons.archive),
//                 onTap: (){
//                   Navigator.pushReplacementNamed(context, '/diler_archive');
//                 }
//               ),
//               ListTile(
//                 title: const Text('Выход'),
//                 leading: const Icon(Icons.exit_to_app),
//                 onTap: () async {
//                   final SharedPreferences prefs = await _prefs;
//                   final String? token = prefs.getString('token');
//                   await Dio().get('http://127.0.0.1:8000/api/v1/auth/token/logout/', options: Options(headers: {'Authorization': 'Token $token'}));
//                   await prefs.remove('token');
//                 }
//               ),
//             ],
//           ),
//         )

//       ),
//     );
//   }
// }