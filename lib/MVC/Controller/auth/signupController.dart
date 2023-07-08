import 'dart:developer';

import 'package:drift/drift.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Database/dbController.dart';

class SignupController extends ChangeNotifier{
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final db = MyDatabase.instance;

  bool isSignUp = false;



  signUp(){
    validatorFiled();
   // clear();
  }

  Future<bool> checkUserExist() async {

    List<UserTableData> user = await db.getUserByEmail(emailController.text);
    if (user.isNotEmpty) {
      isSignUp = true;
      user.clear();
      notifyListeners();
      return false; // User already exists

    } else {
      isSignUp = false;
      notifyListeners();
      log("User Not Exist");
      return true; // User does not exist
    }
  }


  createUser() async {

    var user = UserTableCompanion(
      firstName: Value(firstNameController.text),
      lastName: Value(lastNameController.text),
      email: Value(emailController.text),
      password: Value(passwordController.text),
    );
     await db.insertUser(user);

     await db.getAllUsers().then((value) {
        log("User Data: ${value[0].firstName}");
        log("User Data: ${value[0].lastName}");
        log("User Data: ${value[0].email}");
        log("User Data: ${value[0].password}");
     });

  }

  signUpController() async {
    bool check = await checkUserExist();
    if(check){
      createUser();
      log("User Created");
    }else{
      log("User Already Exist");
    }
  }

  validatorFiled(){
    if(formKey.currentState!.validate()){
      signUpController();
    }
  }

  clear(){
    emailController.clear();
    passwordController.clear();
    firstNameController.clear();
    lastNameController.clear();
    notifyListeners();
  }

  showSnackBar(BuildContext context, String message){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }



}