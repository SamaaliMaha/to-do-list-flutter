import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todolist_app/apicodes/base_url.dart';
import 'package:todolist_app/models/task.dart';
import 'package:todolist_app/outils.dart';

class ApiTask {
  //get all tasks method
  static Future<List<Task>> getAllTasks() async {
    List<Task> listTasks = [];
    await getTokenSharedPref().then((token) async {
      final response = await http.get('${URLS.BASE_URL}/task', headers: {
        "Content-type": "application/json",
        "Authorization": "Bearer $token"
      });
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        for (Map i in data) {
          listTasks.add(Task.fromJson(i));
        }
      }
    });
    return listTasks;
  }

  static Future<bool> updateTaskbyId(id, body) async {
    bool resp = false;
    await getTokenSharedPref().then((token) async {
      final response = await http.put('${URLS.BASE_URL}/task/$id',
          body: jsonEncode(body),
          headers: {
            "Content-type": "application/json",
            "Authorization": "Bearer $token"
          });
      if (response.statusCode == 200) {
        resp = true;
      } else {
        resp = false;
      }
    });
    return resp;
  }

  static Future<int> addNewtask(body) async {
    int statusCode = 0;
    await getTokenSharedPref().then((token) async {
      final response = await http.post('${URLS.BASE_URL}/task',
          body: jsonEncode(body),
          headers: {
            "Content-type": "application/json",
            "Authorization": "Bearer $token"
          });
      statusCode = response.statusCode;
    });
    return statusCode;
  }

  static Future<bool> deleteTaskbyId(id) async {
    bool resp = false;
    await getTokenSharedPref().then((token) async {
      final response = await http.delete('${URLS.BASE_URL}/task/$id', headers: {
        "Content-type": "application/json",
        "Authorization": "Bearer $token"
      });
      if (response.statusCode == 200) {
        resp = true;
      } else {
        resp = false;
      }
    });
    return resp;
  }
}
