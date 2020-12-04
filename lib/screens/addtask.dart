import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:todolist_app/apicodes/api_tasks.dart';
import 'package:todolist_app/colors.dart';
import 'package:todolist_app/widgets.dart';

class AddTaskPage extends StatefulWidget {
  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  bool isInasyncCall = false;
  var taskController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('inchalah List'),
          backgroundColor: t3_colorPrimary,
        ),
        body: ModalProgressHUD(
          child: SingleChildScrollView(
              child: Column(
            children: [
              SizedBox(height: 40),
              Text(
                'inchalah i will:',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 40),
              t3EditTextField('task', taskController, isPassword: false),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: appbutton(
                    textContent: 'add',
                    onPressed: () {
                      setState(() {
                        isInasyncCall = true;
                      });
                      var body = {
                        "description": taskController.text.toString(),
                      };
                      ApiTask.addNewtask(body).then((statusCode) {
                        setState(() {
                          isInasyncCall = false;
                        });
                        if (statusCode == 201) {
                          Navigator.pop(context, 'added');
                        } else {
                          showMyDialog(
                            context,
                            'Error',
                            'sorry something went wrong!',
                            () {
                              Navigator.pop(context);
                            },
                          );
                        }
                      });
                    }),
              ),
            ],
          )),
          inAsyncCall: isInasyncCall,
          opacity: 0.1,
          progressIndicator: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(t3_colorPrimary),
          ),
        ));
  }
}
