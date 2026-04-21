import 'package:flutter/material.dart';
import 'package:lemigas/constants/app_assets.dart';
import 'package:lemigas/screen/admin/AdminDashboard.dart';
import 'package:lemigas/screen/admin/LupaPassword.dart';
import 'package:lemigas/screen/admin/Register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  static const _bg = Color(0xFF1A1A1A);
  static const _navyField = Color(0xFF002147);
  static const _brandYellow = Color(0xFFFFEB3B);

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: CustomPaint(
              size: const Size(200, 220),
              painter: _TopLeftWedgePainter(),
            ),
          ),
          Positioned(
            bottom: -24,
            right: -16,
            child: CustomPaint(
              size: const Size(160, 140),
              painter: _BottomRightStripesPainter(),
            ),
          ),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.paddingOf(context).top > 20 ? 24 : 40,
                        ),
                        _buildLogo(),
                        const SizedBox(height: 28),
                        _buildTitle(),
                        const SizedBox(height: 40),
                        _buildCard(context),
                        const SizedBox(height: 28),
                        _buildBottomButtons(context),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Image.asset(
      AppAssets.login,
      width: 132,
      height: 132,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) => Icon(
        Icons.account_circle_outlined,
        size: 100,
        color: _brandYellow.withValues(alpha: 0.9),
      ),
    );
  }

  Widget _buildTitle() {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
        children: [
          TextSpan(
            text: 'TELE ',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic,
              color: Colors.white,
              letterSpacing: 1.2,
              height: 1.1,
            ),
          ),
          TextSpan(
            text: 'MATIKA',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.normal,
              color: _brandYellow,
              letterSpacing: 1.2,
              height: 1.1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(22, 26, 22, 22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'LOGIN',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w900,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          _buildField(
            controller: _usernameController,
            hintText: '*Username*',
          ),
          const SizedBox(height: 14),
          _buildField(
            controller: _passwordController,
            hintText: '*Password*',
            obscureText: true,
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (context) => const LupaPasswordPage(),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(8),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                child: Text(
                  'Lupa Password ?',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                    color: Colors.black87,
                    decoration: TextDecoration.underline,
                    decorationThickness: 1.2,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      cursorColor: Colors.white70,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontStyle: FontStyle.italic,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: _navyField,
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.white.withValues(alpha: 0.65),
          fontSize: 15,
          fontStyle: FontStyle.italic,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(999),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
      ),
    );
  }

  Widget _buildBottomButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _pillButton(
            label: 'REGISTER',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (context) => const RegisterPage(),
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _pillButton(
            label: 'Login',
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute<void>(
                  builder: (context) => const AdminDashboard(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _pillButton({required String label, required VoidCallback onTap}) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(999),
      elevation: 2,
      shadowColor: Colors.black.withValues(alpha: 0.2),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TopLeftWedgePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width * 0.95, 0)
      ..lineTo(0, size.height * 0.92)
      ..close();
    canvas.drawPath(path, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _BottomRightStripesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    const gap = 22.0;
    void drawStripe(double offset) {
      canvas.drawLine(
        Offset(size.width * 0.15 + offset, size.height),
        Offset(size.width + offset, size.height * 0.08),
        paint,
      );
    }

    drawStripe(0);
    drawStripe(gap);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
