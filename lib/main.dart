import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'MVC/Controller/Database/dbController.dart';
import 'MVC/Controller/auth/loginController.dart';
import 'MVC/Controller/auth/signupController.dart';
import 'MVC/Controller/sharedPreferences_Controller.dart';
import 'MVC/View/auth/login_screen.dart';
import 'MVC/View/auth/signup_screen.dart';
import 'MVC/View/main/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SpHelper.initSp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginController()),
        ChangeNotifierProvider(create: (context) => SignupController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'T-Task 01',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: SpHelper.getId() != null ? '/home' : '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
