import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:todolist_app/apicodes/api_auth.dart';
import 'package:todolist_app/colors.dart';
import 'package:todolist_app/outils.dart';
import 'package:todolist_app/widgets.dart';

class loginpage extends StatefulWidget {
  @override
  _loginpageState createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  bool isRemember = false;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool isInAsyncCall = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: ModalProgressHUD(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  height: (MediaQuery.of(context).size.height) / 3.5,
                  child: Stack(
                    children: <Widget>[
                      Image.asset('assets/t3.png',
                          fit: BoxFit.fill,
                          width: MediaQuery.of(context).size.width),
                      Container(
                        margin: EdgeInsets.only(left: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Inchalah',
                              style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'List',
                              style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.topRight,
                  margin: EdgeInsets.only(right: 45),
                  transform: Matrix4.translationValues(25, -45, 0),
                  child: Image.asset(
                    'assets/todo.png',
                    height: 100,
                    width: 100,
                  ),
                ),
                t3EditTextField('Email', emailController, isPassword: false),
                SizedBox(height: 16),
                t3EditTextField('password', passwordController,
                    isPassword: true),
                SizedBox(height: 14),
                Container(
                  margin: EdgeInsets.only(left: 16),
                  child: Row(
                    children: [
                      Checkbox(
                        focusColor: t3_colorPrimary,
                        activeColor: t3_colorPrimary,
                        value: isRemember,
                        onChanged: (bool value) {
                          setState(() {
                            isRemember = value;
                          });
                        },
                      ),
                      Text('Remember'),
                    ],
                  ),
                ),
                SizedBox(height: 14),
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: appbutton(
                      textContent: 'sign in ',
                      onPressed: () {
                        setState(() {
                          isInAsyncCall = true;
                        });
                        var body = {
                          "email": emailController.text.toString(),
                          "password": passwordController.text.toString(),
                        };
                        ApiAuth.login(body).then((response) {
                          setState(() {
                            isInAsyncCall = false;
                          });

                          if (response.statusCode == 200) {
                            //save token
                            var body = jsonDecode(response.body);
                            String myToken = body['token'];
                            saveTokenSharedPref(myToken);

                            Navigator.pushNamed(context, '/home');
                          } else {
                            var message = json.decode(response.body)['msg'];
                            showMyDialog(context, 'error', message, () {
                              Navigator.pop(context);
                            });
                          }
                        });
                      }),
                ),
                SizedBox(height: 20),
                Text('forgot password?', style: TextStyle(fontSize: 16)),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Don\'t have an account?',
                      style: TextStyle(fontSize: 18),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 4),
                      child: GestureDetector(
                        child: Text('sign up',
                            style: TextStyle(
                                fontSize: 18.0,
                                decoration: TextDecoration.underline,
                                color: t3_colorPrimary)),
                        onTap: () {
                          Navigator.pushNamed(context, '/signup');
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          inAsyncCall: isInAsyncCall,
          opacity: 0.5,
          progressIndicator: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
