import 'package:flutter/material.dart';
import 'package:e_commerce_app/pages/home_page.dart';
import 'package:e_commerce_app/pages/login_page.dart';
import 'package:e_commerce_app/pages/sign_up_page.dart';
import 'package:e_commerce_app/pages/account_page.dart';
import 'package:e_commerce_app/pages/change_pass_page.dart';
import 'package:e_commerce_app/pages/cart_page.dart';

// import 'package:e_commerce_app/pages/sign_up_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Color(0xFF2563EB))),
      home: const HomePage(),
      routes: {
        '/Home_page': (context) => const HomePage(),
        '/login_page': (context) => const LoginPage(),
        '/sign_up_page': (context) => const SignUpPage(),
        '/account_page': (context) => const AccountPage(),
        '/change_pass_page': (context) => const ChangePassPage(),
        '/cart_page': (context) => const CartPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [const Text('You have pushed the button this many times:')],
        ),
      ),
    );
  }
}
