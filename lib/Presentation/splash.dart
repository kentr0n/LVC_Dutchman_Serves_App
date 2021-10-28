import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

/*
This class builds a splash page with cute LVC gif.

Currently unused :(
*/

class SplashPage extends StatelessWidget {
  // static Route route() {
  //   return MaterialPageRoute<void>(builder: (_) => SplashPage());
  // }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xff002A4E),
      systemNavigationBarColor: Color(0xff002A4E),
    ));

    return Scaffold(
      backgroundColor: Color(0xff002A4E),
      body: Center(
        child: Image(
          image: AssetImage('images/giphy.gif'),
          width: 120,
        ),
      ),
    );
  }
}
