import 'dart:ui';
import 'package:dutchmenserve/Presentation/widgets.dart';
import 'package:dutchmenserve/Presentation/homePage.dart';
import 'package:dutchmenserve/Presentation/initialHomePage.dart';
import 'package:dutchmenserve/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/*
This class builds the page allowing users that have already 
registered to login.

Asks only for LVC username and password.
*/

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log in'),
        brightness: Brightness.dark,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
              statusBarColor: const Color(0xff002A4E),
              systemNavigationBarColor: const Color(0xffFFE400),
              systemNavigationBarIconBrightness: Brightness.dark,
            ));
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => InitialLoginHome()),
            );
          },
        ),
      ),
      body: LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final _loginFormKey = GlobalKey<FormState>();

  final unController = TextEditingController();
  final pwController = TextEditingController();

  @override
  void dispose() {
    unController.dispose();
    pwController.dispose();

    super.dispose();
  }

  bool _obscurePW = true;

  // Textfield decoration
  InputDecoration decor(String labelText, FocusScopeNode focusNode, bool pw) {
    return InputDecoration(
      isDense: true,
      filled: true,
      fillColor: const Color(0xfff9f9f9),
      labelText: labelText,
      labelStyle: TextStyle(fontSize: 16, color: Colors.grey[700]),
      errorStyle:
          focusNode.hasFocus ? TextStyle(fontSize: 0, height: 0) : TextStyle(),
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      suffixIcon: pw
          ? IconButton(
              onPressed: () {
                setState(() {
                  _obscurePW = !_obscurePW;
                });
              },
              icon: Icon(Icons.remove_red_eye),
              color: _obscurePW ? Colors.blueGrey : Colors.grey[300],
              splashRadius: .01,
            )
          : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentFocus = FocusScope.of(context);
    return GestureDetector(
      onTap: () {
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Form(
        key: _loginFormKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: <Widget>[
                    Spacer(flex: 3),
                    TextFormField(
                      controller: unController,
                      decoration: decor('LVC Username', currentFocus, false),
                      validator: (value) {
                        if (value.isEmpty) {
                          return '*required';
                        }
                        return value.contains('@')
                            ? 'Do not use the @ char.'
                            : null;
                      },
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => currentFocus.nextFocus(),
                    ),
                    Spacer(),
                    TextFormField(
                      controller: pwController,
                      obscureText: _obscurePW,
                      decoration: decor('LVC Password', currentFocus, true),
                      validator: (value) {
                        if (value.isEmpty) {
                          return '*required';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => currentFocus.unfocus(),
                    ),
                    Spacer(flex: 4),
                    NormalButton(
                      'Next',
                      () {
                        if (_loginFormKey.currentState.validate()) {
                          // TODO: and database verifies User
                          User user = User('first', 'last', unController.text,
                              pwController.text,
                              id: 2);

                          SystemChrome.setSystemUIOverlayStyle(
                              SystemUiOverlayStyle(
                            statusBarColor: const Color(0xff002A4E),
                            systemNavigationBarColor: const Color(0xfff9f9f9),
                            systemNavigationBarIconBrightness: Brightness.dark,
                          ));
                          // user cubit{
                          // if (state is LoadingState){
                          //  return loadingwidget;}
                          // if (state is loadedState)
                          //  return HomePage(state.users[0])} We would get actual user later
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(user),
                            ),
                            (Route<dynamic> route) => false,
                          );
                        }
                      },
                    ),
                    Spacer(flex: 9),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
