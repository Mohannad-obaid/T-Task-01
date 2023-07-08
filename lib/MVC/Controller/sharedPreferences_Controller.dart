import 'package:shared_preferences/shared_preferences.dart';

class SpHelper {
  static late SharedPreferences  sharedPreferences;

  static initSp() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static saveName(String name) async {
    sharedPreferences.setString('name', name);
  }
  static String? getName(){
    return sharedPreferences.getString('name');
  }
  static deleteName() async{
    sharedPreferences.remove('name');
  }

  static saveId(String id) async {
    sharedPreferences.setString('id', id);
  }
  static String? getId(){
    return sharedPreferences.getString('id');
  }
  static deleteId() async{
    sharedPreferences.remove('id');
  }

  static saveEmail(String image) async {
    sharedPreferences.setString('email', image);
  }
  static String? getEmail(){
    return sharedPreferences.getString('email');
  }
  static deleteEmail() async{
    sharedPreferences.remove('email');
  }




}