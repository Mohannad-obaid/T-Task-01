import 'package:flutter/material.dart';

import '../../Controller/auth/signupController.dart';
import 'package:provider/provider.dart';

import '../utils/helper.dart';
import 'widget/textFieldWidget.dart';

class SignUpScreen extends StatelessWidget with Helpers {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: Provider.of<SignupController>(context).formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                height > 600 ? const SizedBox(height: 100,) : const SizedBox(height: 60,),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                height > 600 ? const SizedBox(height: 85,) : const SizedBox(height: 45,),

                TextFiledWidget(
                  controller: Provider.of<SignupController>(context ,listen: false).firstNameController,
                  hintText: 'First Name',
                  isPassword: false,
                  keyboardType: TextInputType.text,
                  prefixIcon: const Icon(Icons.person),
                ),
                height > 600 ? const SizedBox(height: 20,) : const SizedBox(height: 10,),
                TextFiledWidget(
                  controller: Provider.of<SignupController>(context ,listen: false).lastNameController,
                  hintText: 'Last Name',
                  isPassword: false,
                  keyboardType: TextInputType.text,
                  prefixIcon: const Icon(Icons.person),
                ),
                height > 600 ? const SizedBox(height: 20,) : const SizedBox(height: 10,),

                TextFiledWidget(
                  controller: Provider.of<SignupController>(context ,listen: false).emailController,
                  hintText: 'Email',
                  isPassword: false,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.email_rounded),
                ),
                height > 600 ? const SizedBox(height: 20,) : const SizedBox(height: 10,),
                TextFiledWidget(
                  controller: Provider.of<SignupController>(context, listen: false).passwordController,
                  hintText: 'Password',
                  isPassword: true,
                  keyboardType: TextInputType.visiblePassword,
                  prefixIcon: const Icon(Icons.lock),
                ),
                height > 600 ? const SizedBox(height: 30,) : const SizedBox(height: 15,),

                ElevatedButton(
                    onPressed: () {
                      Provider.of<SignupController>(context, listen: false).signUp();
                      Future.delayed(const Duration(seconds: 1), () {
                        Provider.of<SignupController>(context, listen: false).isSignUp
                            ? showSnackBar(context: context, content: 'User Already Exist',error: true)
                            : Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(width * 0.8, 50),
                    ),
                    child: const Text('Sign Up')
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
