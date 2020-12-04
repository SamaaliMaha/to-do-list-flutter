import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:todolist_app/apicodes/api_auth.dart';
import 'package:todolist_app/colors.dart';
import 'package:todolist_app/widgets.dart';

class signup extends StatefulWidget {
  @override
  _signupState createState() => _signupState();
}

class _signupState extends State<signup> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      transform: Matrix4.translationValues(0, 20, 0),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
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
                  ],
                ),
                t3EditTextField('Name', nameController, isPassword: false),
                SizedBox(height: 16),
                t3EditTextField('Email', emailController, isPassword: false),
                SizedBox(height: 16),
                t3EditTextField('password', passwordController,
                    isPassword: true),
                SizedBox(height: 14),
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: appbutton(
                      textContent: 'sign up ',
                      onPressed: () {
                        setState(() {
                          isInAsyncCall = true;
                        });
                        var body = {
                          "name": nameController.text.toString(),
                          "email": emailController.text.toString(),
                          "password": passwordController.text.toString(),
                          "age": 20
                        };
                        ApiAuth.register(body).then((response) {
                          setState(() {
                            isInAsyncCall = false;
                          });

                          if (response.statusCode == 201) {
                            Navigator.pushNamed(context, '/home');
                          } else {
                            showMyDialog(
                                context, 'error', response.body.toString(), () {
                              Navigator.pop(context);
                            });
                            print(response.body);
                          }
                        });
                      }),
                ),
                SizedBox(height: 30),
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
                        child: Text('sign in',
                            style: TextStyle(
                                fontSize: 18.0,
                                decoration: TextDecoration.underline,
                                color: t3_colorPrimary)),
                        onTap: () {
                          Navigator.pop(
                            context,
                          );
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          inAsyncCall: isInAsyncCall,
          // demo of some additional parameters
          opacity: 0.5,
          progressIndicator: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
