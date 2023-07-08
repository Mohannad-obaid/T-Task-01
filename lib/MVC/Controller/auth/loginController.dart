import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:task/MVC/Controller/sharedPreferences_Controller.dart';

import '../Database/dbController.dart';

class LoginController extends ChangeNotifier{

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formKeyLogin = GlobalKey<FormState>();

  final db = MyDatabase.instance;
  bool checkUser = false;

  login(){
    validatorFiled();
   // clear();
  }


  Future<bool> checkUserExist() async {

    UserTableData? user = await db.getUserByEmailAndPassword(emailController.text, passwordController.text);
    if (user?.email == emailController.text ) {
      checkUser = true;
      String fullName = "${user!.firstName.toString()} ${user.lastName.toString()}";
      saveDataUserLogin(user.id.toString(), fullName, user.email.toString());
      notifyListeners();
      return true; // User already exists
    } else {
      checkUser = false;
      notifyListeners();
      return false; // User does not exist
    }
  }

  validatorFiled(){
    if(formKeyLogin.currentState!.validate()){
      checkUserExist();
    }
  }
  clear(){
    emailController.clear();
    passwordController.clear();
    notifyListeners();
  }


  saveDataUserLogin(String id,String name,String email) async {
    SpHelper.saveId(id);
    SpHelper.saveName(name);
    SpHelper.saveEmail(email);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }



}