import 'package:dutchmenserve/models/Constants.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/cupertino.dart';

/*
This class defines custom widgets to simplify code.
*/

// normal button
class NormalButton extends StatelessWidget {
  final String s;
  final Function press;
  final EdgeInsets padding;
  final Color color;
  final Color textColor;

  NormalButton(this.s, this.press, {this.padding, this.color, this.textColor});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: press,
      padding: padding ?? EdgeInsets.all(0.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(90)),
          color: color ?? null,
        ),
        padding: EdgeInsets.symmetric(horizontal: 90, vertical: 12),
        child: Text(s,
            style: TextStyle(
              fontSize: 21,
              color: textColor ?? Color(0xffaacde3),
              fontWeight: FontWeight.w900,
            )),
      ),
    );
  }
}

class CustomDialogBox extends StatefulWidget {
  final String title, description, buttonLeft, buttonRight;
  final Widget child;
  final bool showCheckbox;

  const CustomDialogBox(
      {Key key,
      this.title,
      this.description,
      this.buttonLeft,
      this.buttonRight,
      this.child,
      this.showCheckbox})
      : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  bool checkboxValue = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              left: Constants.padding,
              top: Constants.avatarRadius + Constants.padding,
              right: Constants.padding,
              bottom: Constants.padding),
          margin: EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                widget.title,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 15,
              ),
              showBody(widget.showCheckbox),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: Text(widget.buttonLeft, // Cancel
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.blueGrey[700],
                          ))),
                  FlatButton(
                      onPressed: () {
                        if (widget.showCheckbox && !checkboxValue) {
                          return null;
                        }
                        Navigator.of(context).pop(true);
                      },
                      child: Text(
                        widget.buttonRight,
                        style: TextStyle(
                            fontSize: 18,
                            color: (widget.showCheckbox && !checkboxValue)
                                ? Colors.grey
                                : Colors.blueGrey[700]),
                      )),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          left: Constants.padding,
          right: Constants.padding,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: Constants.avatarRadius,
            child: widget.child,
          ),
        ),
      ],
    );
  }

  Widget showBody(bool checkbox) {
    if (checkbox) {
      return Container(
        child: CheckboxListTile(
            title: Text(widget.description, style: TextStyle(fontSize: 14)),
            controlAffinity: ListTileControlAffinity.leading,
            value: checkboxValue,
            activeColor: Color(0xff206090),
            onChanged: (bool value) {
              setState(() {
                checkboxValue = !checkboxValue;
              });
            }),
      );
    } else {
      if (widget.description == '') return Container();
      return Text(
        widget.description,
        style: TextStyle(fontSize: 14),
        textAlign: TextAlign.center,
      );
    }
  }
}

// // function to create gradient filled button
// RaisedButton createGradient(String s, Gradient grad, Function press) {
//   return RaisedButton(
//     onPressed: press,
//     padding: EdgeInsets.all(0.0),
//     child: Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.all(Radius.circular(90)),
//         gradient: grad,
//       ),
//       padding: EdgeInsets.symmetric(horizontal: 90, vertical: 12),
//       child: Text(s, style: TextStyle(fontSize: 21)),
//     ),
//   );
// }

// // function to create gradient outline button
// RaisedButton createGradButton(String s, LinearGradient lg, Function press) {
//   return RaisedButton(
//     onPressed: press,
//     padding: EdgeInsets.all(0.0),
//     textColor: Colors.white,
//     child: Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.all(Radius.circular(90)),
//         gradient: lg,
//       ),
//       padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
//       child: Container(
//           decoration: BoxDecoration(
//               border: null,
//               borderRadius: BorderRadius.all(Radius.circular(90)),
//               boxShadow: null,
//               color: Color(0xfff9f9f9)),
//           padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 11),
//           child: Text(s, style: TextStyle(color: Colors.black))),
//     ),
//   );
// }

// gradient appbar
//   flexibleSpace: Container(
//     decoration: BoxDecoration(
//       gradient: LinearGradient(
//         begin: Alignment.topLeft,
//         end: Alignment.bottomRight,
//         colors: <Color>[
//           Color(0xff080644),
//           Color(0xff080644),
//           Colors.indigo[900],
//           Colors.deepPurple[900],
//           Colors.indigo[900],
//         ],
//       ),
//     ),
//   ),
