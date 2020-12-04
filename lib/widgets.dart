import 'package:flutter/material.dart';
import 'package:todolist_app/colors.dart';

Future<void> showMyDialog(BuildContext context, String title, String message,
    Function onPressed) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: Text(message),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('OK'),
            onPressed: onPressed,
          ),
        ],
      );
    },
  );
}

const t3_edit_background = Color(0xFFF5F4F4);

Padding t3EditTextField(var hintText, TextEditingController controller,
    {isPassword = true}) {
  return Padding(
      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: TextFormField(
        controller: controller,
        style: TextStyle(fontSize: 18),
        obscureText: isPassword,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(26, 18, 4, 18),
          hintText: hintText,
          filled: true,
          fillColor: t3_edit_background,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide(color: t3_edit_background, width: 0.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide(color: t3_edit_background, width: 0.0),
          ),
        ),
      ));
}

class appbutton extends StatefulWidget {
  var textContent;
  VoidCallback onPressed;
  appbutton({@required this.textContent, @required this.onPressed});

  @override
  _appbuttonState createState() => _appbuttonState();
}

class _appbuttonState extends State<appbutton> {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: widget.onPressed,
      textColor: t3_white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(80.0),
      ),
      padding: EdgeInsets.all(0.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: <Color>[t3_colorPrimary, t3_colorPrimaryDark]),
          borderRadius: BorderRadius.all(
            Radius.circular(80.0),
          ),
        ),
        child: Center(
          child: Padding(
              padding: EdgeInsets.all(18.0),
              child: Text(
                widget.textContent,
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              )),
        ),
      ),
    );
  }
}

// ALERT DIALOG
