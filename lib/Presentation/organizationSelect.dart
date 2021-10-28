import 'dart:ui';
import 'package:dutchmenserve/Presentation/widgets.dart';
import 'package:dutchmenserve/Presentation/homePage.dart';
import 'package:dutchmenserve/models/user.dart';
import 'package:dutchmenserve/models/organization.dart';
import 'package:dutchmenserve/Infrastructure/cubit/organization_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/*
Scrollable checklist for user to select the orgnizations they are interested in, 
want to follow to see events that this service organization does.

Offers option to set up later.
*/

class SetUpOrgPage extends StatefulWidget {
  final User user;
  SetUpOrgPage({Key key, @required this.user}) : super(key: key);

  @override
  SetUpOrgState createState() {
    return SetUpOrgState(user);
  }
}

class SetUpOrgState extends State<SetUpOrgPage> {
  User user;
  SetUpOrgState(this.user);

  // final List<String> entries = <String>[
  //   'Alpha Phi Omega',
  //   'B',
  //   'C',
  //   'D',
  //   'E',
  //   'F',
  //   'G',
  //   'H',
  //   'I',
  //   'J',
  //   'K',
  //   'L',
  //   'M'
  // ];
  List<String> getEntries(List<Organization> orgs) {
    List<String> entries = [];
    for (var i = 0; i < orgs.length; i++) {
      String name = orgs[i].getOrgName();
      entries.add(name);
    }
    return entries;
  }

  // 13 is a hardcoded number
  List<bool> _isChecked = List.generate(13, (index) => false);

  void sendToCubit(User user) {
    // tell user cubit to add user
  }

  void next() {
    sendToCubit(user);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xff002A4E),
      systemNavigationBarColor: Color(0xfff9f9f9),
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(user),
      ),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Select your organizations')),
        body: Column(
          children: [
            new Expanded(
              child: BlocBuilder<OrganizationCubit, OrganizationState>(
                  builder: (context, state) {
                if (state is LoadedState) {
                  List<String> entries = getEntries(state.orgs);
                  return ListView.separated(
                    padding: const EdgeInsets.all(20.0),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          decoration: BoxDecoration(
                            // border: Border.all(color: Colors.black),
                            color: Colors.white,
                          ),
                          child: CheckboxListTile(
                              title: Text('${entries[index]}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300,
                                  )),
                              activeColor: Color(0xff006ecc),
                              value: _isChecked[index],
                              onChanged: (value) {
                                setState(() {
                                  _isChecked[index] = !_isChecked[index];
                                });
                              }));
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(color: Colors.blueGrey),
                    itemCount: entries.length,
                  );
                } else {
                  return Text("test");
                }
              }),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: BlocBuilder<OrganizationCubit, OrganizationState>(
                  builder: (context, state) {
                if (state is LoadedState) {
                  List<String> entries = getEntries(state.orgs);
                  return NormalButton(
                    'Next',
                    () {
                      for (int i = 0; i < entries.length; i++) {
                        if (_isChecked[i]) user.organizations.add(i);
                      }
                      next();
                    },
                  );
                } else {
                  return Text("test");
                }
              }),
            ),
            TextButton(
              child: Text(
                'Set up later',
                style: TextStyle(
                  color: Color(0xff002A4E),
                  decoration: TextDecoration.underline,
                  fontSize: 16,
                ),
              ),
              onPressed: () {
                next();
              },
            ),
          ],
        ));
  }
}
