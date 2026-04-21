import 'package:flutter/material.dart';
import 'register_page.dart';
import '/service/auth_service.dart';
import 'item_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;

  /// Handle proses login
  void handleLogin() async {
    setState(() => isLoading = true);

    bool success = await AuthService.login(
      usernameController.text,
      passwordController.text,
    );

    setState(() => isLoading = false);

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ItemPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login gagal")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF1A1A1A),
                Color(0xFF000000),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),

                  // 🔰 LOGO
                  Image.asset(
                    'assets/logo.png',
                    height: 120,
                  ),

                  const SizedBox(height: 20),

                  // 🔰 TEXT TELE MATIKA
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'TELE ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: 'MATIKA',
                          style: TextStyle(
                            color: Colors.yellow,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // 🔰 CARD LOGIN
                  Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "LOGIN",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 20),

                        TextField(
                          controller: usernameController,
                          decoration: InputDecoration(
                            hintText: "Username",
                            filled: true,
                            fillColor: const Color(0xFF0B2E59),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                            hintStyle: const TextStyle(color: Colors.white70),
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),

                        const SizedBox(height: 15),

                        TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "Password",
                            filled: true,
                            fillColor: const Color(0xFF0B2E59),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                            hintStyle: const TextStyle(color: Colors.white70),
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),

                        const SizedBox(height: 10),

                        const Text("Lupa Password?"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // 🔰 BUTTON
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),

                        /// 🔥 INI BAGIAN YANG DITAMBAHKAN
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const RegisterPage(),
                            ),
                          );
                        },

                        child: const Text(
                          "Register",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: isLoading ? null : handleLogin,
                        child: isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.black,
                                ),
                              )
                            : const Text(
                                "Login",
                                style: TextStyle(color: Colors.black),
                              ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}