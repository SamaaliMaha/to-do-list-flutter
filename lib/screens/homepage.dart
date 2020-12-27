import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:todolist_app/apicodes/api_tasks.dart';
import 'package:todolist_app/colors.dart';
import 'package:todolist_app/models/task.dart';
import 'package:todolist_app/screens/addtask.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String token = '';
  bool isInAsyncCall = true;
  List<Task> listTasks = [];

  @override
  void initState() {
    super.initState();
    callApi();
  }

  void _ShowSnackBar(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  //getTokenSharedPref().then((value) {
  //setState(() {
  //token = value;
  /* print(value);
      });
    });
  }*/
  callApi() async {
    var value = await ApiTask.getAllTasks();
    setState(() {
      listTasks = value;
      isInAsyncCall = false;
    });
  }

  TextDecoration getTextDecoration(bool value) {
    if (value) {
      return TextDecoration.lineThrough;
    } else {
      return TextDecoration.none;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(),
        appBar: AppBar(
          title: Text('inchalah list'),
          backgroundColor: t3_colorPrimary,
        ),
        body: Column(
          children: [
            Expanded(
              child: ModalProgressHUD(
                child: ListView.builder(
                  padding: EdgeInsets.all(5.0),
                  itemBuilder: (BuildContext context, int index) => Slidable(
                    key: Key(listTasks[index].description),
                    actionPane: SlidableDrawerActionPane(),
                    secondaryActions: <Widget>[
                      IconSlideAction(
                        caption: 'delete',
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () async {
                          setState(() {
                            isInAsyncCall = true;
                          });

                          var value =
                              await ApiTask.deleteTaskbyId(listTasks[index].id);

                          setState(() {
                            listTasks.removeAt(index);
                            isInAsyncCall = false;
                          });
                          _ShowSnackBar(context, 'Task Deleted');
                        },
                      ),
                    ],
                    child: Card(
                      child: CheckboxListTile(
                        activeColor: t3_colorPrimary,
                        title: Text(
                          listTasks[index].description,
                          style: TextStyle(
                              decoration: getTextDecoration(
                                  listTasks[index].completed)),
                        ),
                        onChanged: (bool value) {
                          setState(() {
                            listTasks[index].completed = value;
                          });
                          var body = {
                            "completed": value,
                          };
                          ApiTask.updateTaskbyId(listTasks[index].id, body);
                        },
                        value: listTasks[index].completed,
                      ),
                    ),
                  ),
                  itemCount: listTasks.length,
                ),
                inAsyncCall: isInAsyncCall,
                opacity: 0.1,
                progressIndicator: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(t3_colorPrimary),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            String added = await Navigator.push(
                context, MaterialPageRoute(builder: (_) => AddTaskPage()));
            setState(() {
              isInAsyncCall = true;
            });
            callApi();
          },
          backgroundColor: t3_colorPrimary,
          child: Icon(
            Icons.playlist_add,
            color: Colors.white,
          ),
        ));
  }
}
