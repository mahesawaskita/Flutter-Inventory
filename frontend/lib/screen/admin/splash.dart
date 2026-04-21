import 'package:flutter/material.dart';
import 'dart:async';
import 'package:frontend/constants/app_assets.dart';
import 'package:frontend/screen/admin/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset(
          AppAssets.splash,
          width: 200,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}