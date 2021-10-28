import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dutchmenserve/Presentation/app_icons.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

/*
This class builds the About page that talks about LVC service values.

*/

class AboutPage extends StatelessWidget {
  final bool _allow = true;

  @override
  Widget build(BuildContext context) {
    List<String> statement = [
      'We empower students for a life of citizenship both in our community and around the globe.',
      'We enhance our self-knowledge as we examine our own identity and purpose within a diverse world.',
      'We grow our awareness and knowledge for needs and justice issues in a variety of areas.',
    ];

    List<Widget> icons = [
      Icon(
        AppIcons.hearthands,
        size: 40,
        color: Color(0xff95C1DC),
      ),
      Icon(
        AppIcons.analysis,
        size: 44,
        color: Color(0xff95C1DC),
      ),
      Container(
          child: Icon(
            AppIcons.plant,
            size: 30,
            color: Color(0xff95C1DC),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 8)),
    ];

    return WillPopScope(
      onWillPop: () {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          systemNavigationBarColor: Color(0xfff9f9f9),
          systemNavigationBarIconBrightness: Brightness.light,
        ));
        return Future.value(_allow); // if true allow back else block it
      },
      child: Scaffold(
        backgroundColor: Color(0xff002B4E),
        appBar: AppBar(
          brightness: Brightness.dark,
          centerTitle: true,
          title: Text('Our Values'),
          backgroundColor: Color(0xff001d35),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                systemNavigationBarColor: Color(0xfff9f9f9),
                systemNavigationBarIconBrightness: Brightness.light,
              ));
              Navigator.pop(context);
            },
          ),
        ),
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(),
                Center(
                  child: Text(
                    'Dutchmen Serve',
                    style: TextStyle(
                      fontFamily: 'BebasNeue',
                      fontSize: 55,
                      fontWeight: FontWeight.normal,
                      color: Color(0xff95C1DC),
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  child: Image(image: AssetImage('images/lvc_white.png')),
                  padding: EdgeInsets.symmetric(horizontal: 80),
                ),
                Container(
                  alignment: Alignment.center,
                  child: AutoSizeText(
                    'Office of Community Service and Volunteerism',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w900,
                      fontSize: 15,
                      color: Color(0xffDDDDDE),
                    ),
                    maxLines: 2,
                  ),
                ),
                Spacer(),
                createTextContainer(statement[0], icons[0], 10, 3),
                Spacer(),
                createTextContainer(statement[1], icons[1], 40, 4),
                Spacer(),
                createTextContainer(statement[2], icons[2], 70, 3),
                Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // function to create rounded text expandable
  Expanded createTextContainer(String s, Widget i, double margin, int mL) {
    return Expanded(
      flex: 3,
      child: Container(
        margin: EdgeInsets.only(right: margin),
        decoration: BoxDecoration(
          // color: Color(0xfff9f9f9),
          color: Colors.white,
          border: Border.all(color: Color(0xff95C1DC)),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(70.0),
            bottomRight: Radius.circular(70.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Spacer(),
            Flexible(flex: 8, child: i),
            Spacer(),
            Flexible(
              flex: 25,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: AutoSizeText(
                  s,
                  style: TextStyle(
                    fontFamily: 'KiteOne',
                    color: Colors.black,
                  ),
                  maxLines: mL,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
