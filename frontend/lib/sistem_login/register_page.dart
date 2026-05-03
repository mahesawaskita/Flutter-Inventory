import 'package:flutter/material.dart';
import '/service/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  bool isLoading = false;

  // ✅ Disesuaikan dengan AuthService.register() yang return Map
  void handleRegister() async {
    if (passwordController.text != confirmController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password tidak sama")),
      );
      return;
    }

    setState(() => isLoading = true);

    // AuthService.register() sekarang return Map {success, message}
    final result = await AuthService.register(
      usernameController.text.trim(),
      passwordController.text,
    );

    if (!mounted) return;
    setState(() => isLoading = false);

    if (result['success'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Register berhasil, silakan login")),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message'] ?? "Register gagal")),
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
              colors: [Color(0xFF1A1A1A), Color(0xFF000000)],
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

                  Image.asset(
                    'assets/logo.png',
                    height: 120,
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.inventory_2_outlined,
                      size: 100,
                      color: Colors.yellow,
                    ),
                  ),

                  const SizedBox(height: 20),

                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'TELE ',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: 'MATIKA',
                          style: TextStyle(
                              color: Colors.yellow,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

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
                          "REGISTRATION",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 20),

                        // USERNAME
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
                            hintStyle:
                                const TextStyle(color: Colors.white70),
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),

                        const SizedBox(height: 15),

                        // PASSWORD
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
                            hintStyle:
                                const TextStyle(color: Colors.white70),
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),

                        const SizedBox(height: 15),

                        // CONFIRM PASSWORD
                        TextField(
                          controller: confirmController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "Confirm Password",
                            filled: true,
                            fillColor: const Color(0xFF0B2E59),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                            hintStyle:
                                const TextStyle(color: Colors.white70),
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Kembali",
                            style: TextStyle(color: Colors.black)),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        onPressed: isLoading ? null : handleRegister,
                        child: isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                    strokeWidth: 2, color: Colors.black),
                              )
                            : const Text("Register",
                                style: TextStyle(color: Colors.black)),
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