import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:frontend/screen/user/dashboard_user.dart';
=======
import 'package:frontend/sistem_login/login_page.dart';
>>>>>>> 948292890770667acdc553f21055e39f91e8412f

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KeepTel',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
<<<<<<< HEAD
      home: const DashboardUserScreen (),
=======
      home: const LoginPage (),
>>>>>>> 948292890770667acdc553f21055e39f91e8412f
    );
  }
}