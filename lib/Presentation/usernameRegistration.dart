import 'package:dutchmenserve/Infrastructure/cubit/users_cubit.dart';
import 'package:dutchmenserve/Presentation/widgets.dart';
import 'package:dutchmenserve/Presentation/initialHomePage.dart';
import 'package:dutchmenserve/Presentation/interestSelection.dart';
import 'package:dutchmenserve/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/*
This class will prompt for a username, password, and password confirmation 
for registration.  The next pages will ask for further info.
*/

class UserNameReg extends StatefulWidget {
  @override
  RegisterFormState createState() {
    return RegisterFormState();
  }
}

class RegisterFormState extends State<UserNameReg> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.

  // Note: This is a `GlobalKey<FormState>`, not a GlobalKey<MyCustomFormState>.
  final _registerFormKey = GlobalKey<FormState>();

  // text controller to retrieve textfield value
  final unController = TextEditingController();
  final pwController = TextEditingController();
  // final fnController = TextEditingController();
  // final lnController = TextEditingController();

  @override
  void dispose() {
    unController.dispose();
    pwController.dispose();
    // fnController.dispose();
    // lnController.dispose();
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
    // Build a Form widget using the _formKey created above.
    final FocusScopeNode currentFocus = FocusScope.of(context);
    return Scaffold(
      body: BlocProvider(
        create: (context) => UsersCubit(),
        child: GestureDetector(
          onTap: () {
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Form(
            key: _registerFormKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: Text('Register an account'),
                  brightness: Brightness.dark,
                  floating: true,
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
                        MaterialPageRoute(
                            builder: (context) => InitialLoginHome()),
                      );
                    },
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: <Widget>[
                        Spacer(flex: 3),
                        TextFormField(
                          controller: unController,
                          decoration:
                              decor('LVC Username', currentFocus, false),
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
                            if (_registerFormKey.currentState.validate()) {
                              // and database verifies LVC user login
                              // get user info (first name, last name)
                              String fn = 'First';
                              String ln = 'Last';

                              // save new User in DB
                              User u = User(
                                  fn, ln, unController.text, pwController.text,
                                  id: 1);

                              // If the form is valid, display a snackbar. In the real world,
                              // you'd often call a server or save the information in a database.
                              // Scaffold.of(context).showSnackBar(
                              //     SnackBar(content: Text('Account verified')));

                              // unfocus keyboard
                              currentFocus.unfocus();

                              SystemChrome.setSystemUIOverlayStyle(
                                  SystemUiOverlayStyle(
                                statusBarColor: const Color(0xff002A4E),
                                systemNavigationBarColor:
                                    const Color(0xfff9f9f9),
                                systemNavigationBarIconBrightness:
                                    Brightness.dark,
                              ));
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (contextProfilePage) =>
                                        BlocProvider.value(
                                          value: context.read<UsersCubit>(),
                                          child: SelectInterests(user: u),
                                        )),
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
        ),
      ),
    );
  }
}
