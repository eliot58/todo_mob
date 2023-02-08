import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Company extends StatefulWidget {
  final int id;

  const Company({
    super.key,
    required this.id,
  });

  @override
  State<Company> createState() => _CompanyState();
}

class _CompanyState extends State<Company> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  
  dynamic _logourl;
  String _company = '';
  String _address = '';
  String _contactentity = '';
  String _contactphone = '';
  String _serviceentity = '';
  String _serviceemail = '';
  String _servicephone = '';
  String _shapes = '';
  String _implements = '';
  String _regions = '';
  String _description = '';

  _setdata() async {
    final SharedPreferences prefs = await _prefs;
    final String? token = prefs.getString('token');
    var response = await Dio().get('https://xn----gtbdlmdrgbq5j.xn--p1ai/api/v1/providercard/${widget.id}/', options: Options(headers: {'Authorization': 'Token $token'}));
    if (!mounted) return;
    setState(() {
      _logourl = response.data['logo'];
      _company = response.data['company'];
      _address = response.data['product_address'];
      _contactentity = response.data['contact_entity'];
      _contactphone = response.data['contact_phone'];
      _serviceentity = response.data['service_entity'];
      _serviceemail = response.data['service_email'];
      _servicephone = response.data['service_phone'];
      _shapes = response.data['shapes'].join(', ');
      _implements = response.data['implements'].join(', ');
      _regions = response.data['regions'].join(', ');
      _description = response.data['description'];
    });
  }

  @override
  void initState() {
    super.initState();
    _setdata();
  }


  Decoration _imgget(){
    if (_logourl==null) {
      return BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        shape: BoxShape.rectangle,
        color: Colors.grey
      );
    }
    return BoxDecoration(
      borderRadius: BorderRadius.circular(50),
      image: DecorationImage(
        image: NetworkImage('https://xn----gtbdlmdrgbq5j.xn--p1ai$_logourl'),
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Row(
                    children: [
                      IconButton(padding: EdgeInsets.zero,onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.arrow_back_ios)),
                      const Expanded(flex: 1,child: Text('Профиль компании', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600), textAlign: TextAlign.center)),
                    ],
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: 66,
                                height: 66,
                                decoration: _imgget()
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 20),
                                      child: Text(_company, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                                    ),
                                    Text('Руководитель : $_contactentity', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: SvgPicture.asset('assets/img/ico/location.svg'),
                              ),
                              Text(_address, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500))
                            ],
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: SvgPicture.asset('assets/img/ico/phone.svg'),
                            ),
                            Text(_contactphone, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 16),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Text('Менеджер : $_serviceentity', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: SvgPicture.asset('assets/img/ico/phone.svg'),
                                ),
                                Text(_servicephone, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500))
                              ],
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: SvgPicture.asset('assets/img/ico/mail.svg'),
                              ),
                              Text(_serviceemail, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500))
                            ],
                          ),
                        ]
                      ),
                    )
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Row(
                              children: <Widget>[
                                const Text('Профили:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                                Expanded(child: Text(_shapes, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)))
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Row(
                              children: <Widget>[
                                const Text('Фурнитуры:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                                Expanded(child: Text(_implements, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)))
                              ],
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              const Text('Регионы:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                              Expanded(child: Text(_regions, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)))
                            ],
                          ),                          
                        ]
                      ),
                    )
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(_description, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500))
                    )
                  ),
                ),
              ],
            ),
          ),
        )
      )
    );
  }
}