import 'package:flutter/material.dart';
import 'screen/login_page.dart';
import 'screen/item_page.dart';
import 'service/auth_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget home = const Scaffold(
    body: Center(child: CircularProgressIndicator()),
  );

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    String? token = await AuthService.getToken();

    setState(() {
      if (token != null) {
        home = const ItemPage(); // langsung ke items
      } else {
        home = const LoginPage(); // ke login
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: home);
  }
}