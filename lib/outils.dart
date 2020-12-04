import 'package:shared_preferences/shared_preferences.dart';

saveTokenSharedPref(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token);
}

Future<String> getTokenSharedPref() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.getString('token');
}
