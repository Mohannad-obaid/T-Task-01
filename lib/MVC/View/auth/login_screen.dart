import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:task/MVC/View/utils/helper.dart';

import '../../Controller/auth/loginController.dart';
import 'widget/textFieldWidget.dart';

class LoginScreen extends StatelessWidget with Helpers {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: Provider.of<LoginController>(context).formKeyLogin,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                height > 600 ? const SizedBox(height: 130,) : const SizedBox(height: 60,),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Welcome',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                height > 600 ? const SizedBox(height: 100,) : const SizedBox(height: 45,),
                TextFiledWidget(
                  controller: Provider.of<LoginController>(context ,listen: false).emailController,
                  hintText: 'Email',
                  isPassword: false,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.person),
                ),
                height > 600 ? const SizedBox(height: 20,) : const SizedBox(height: 10,),
                TextFiledWidget(
                  controller: Provider.of<LoginController>(context, listen: false).passwordController,
                  hintText: 'Password',
                  isPassword: true,
                  keyboardType: TextInputType.visiblePassword,
                  prefixIcon: const Icon(Icons.lock),
                ),
                height > 600 ? const SizedBox(height: 30,) : const SizedBox(height: 15,),
                ElevatedButton(
                  onPressed: () {
                    Provider.of<LoginController>(context, listen: false).login();

                    Future.delayed(const Duration(seconds: 2), () {
                      if(Provider.of<LoginController>(context, listen: false).checkUser == true) {
                        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                        log('Login Success');
                      }else{
                        showSnackBar(context:context,content: 'Email or Password is incorrect',error: true);
                      }
                    });
                  },
                 style: ElevatedButton.styleFrom(
                   minimumSize: Size(width * 0.8, 50),
                 ),
                  child: const Text('Login')
                ),

                height > 600 ? const SizedBox(height: 130,) : const SizedBox(height: 100,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an account?'),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');

                      },
                      child: const Text('Sign Up'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
