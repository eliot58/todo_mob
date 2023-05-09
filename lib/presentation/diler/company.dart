import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todotodo/domain/state/company/company_state.dart';
import 'package:todotodo/internal/dependencies/company_module.dart';

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
  late CompanyState companyState;

  @override
  void initState() {
    super.initState();
    companyState = CompanyModule.companyState();
    companyState.getComapnyData(widget.id);
  }

  Decoration _imgget() {
    if (companyState.logourl == null) {
      return BoxDecoration(borderRadius: BorderRadius.circular(50), shape: BoxShape.rectangle, color: Colors.grey);
    }
    return BoxDecoration(
      borderRadius: BorderRadius.circular(50),
      image: DecorationImage(
        image: NetworkImage('http://127.0.0.1:8000${companyState.logourl}'),
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
              child: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Observer(
            builder: (context) {
              if (companyState.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: Row(
                      children: [
                        IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back_ios)),
                        Expanded(flex: 1, child: Text('Профиль компании', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600), textAlign: TextAlign.center)),
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
                                Container(width: 66, height: 66, decoration: _imgget()),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 20),
                                        child: Text(companyState.company, style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600)),
                                      ),
                                      Text('Руководитель : ${companyState.contactentity}', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400))
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
                                  child: SvgPicture.asset('assets/img/location.svg'),
                                ),
                                Text(companyState.address, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500))
                              ],
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: SvgPicture.asset('assets/img/phone.svg'),
                              ),
                              Text(companyState.contactphone, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500))
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
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Text('Менеджер : ${companyState.serviceentity}', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: SvgPicture.asset('assets/img/ico/phone.svg'),
                              ),
                              Text(companyState.servicephone, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500))
                            ],
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: SvgPicture.asset('assets/img/ico/mail.svg'),
                            ),
                            Text(companyState.serviceemail, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500))
                          ],
                        ),
                      ]),
                    )),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Card(
                        child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            children: <Widget>[Text('Профили:', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400)), Expanded(child: Text(companyState.shapes, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500)))],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            children: <Widget>[Text('Фурнитуры:', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400)), Expanded(child: Text(companyState.implements, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500)))],
                          ),
                        ),
                        Row(
                          children: <Widget>[Text('Регионы:', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400)), Expanded(child: Text(companyState.regions, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500)))],
                        ),
                      ]),
                    )),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Card(child: Padding(padding: const EdgeInsets.all(10), child: Text(companyState.description, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500)))),
                  ),
                ],
              );
            }
          ),
        ),
      ))),
    );
  }
}
