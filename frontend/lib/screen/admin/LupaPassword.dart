import 'package:flutter/material.dart';
import 'package:frontend/constants/app_assets.dart';
import 'package:frontend/screen/admin/BuatPasswordBaru.dart';

// ════════════════════════════════════════════════════════════════════════════
//  LUPA PASSWORD PAGE
// ════════════════════════════════════════════════════════════════════════════
class LupaPasswordPage extends StatefulWidget {
  const LupaPasswordPage({super.key});

  @override
  State<LupaPasswordPage> createState() => _LupaPasswordPageState();
}

class _LupaPasswordPageState extends State<LupaPasswordPage> {
  final TextEditingController _emailController = TextEditingController();

  static const _bg = Color(0xFF1A1A1A);
  static const _navyField = Color(0xFF002147);
  static const _brandYellow = Color(0xFFFFEB3B);

  @override
  void dispose() {
    _emailController.dispose();
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
                        SizedBox(height: MediaQuery.paddingOf(context).top > 20 ? 24 : 40),
                        _buildLogo(),
                        const SizedBox(height: 28),
                        _buildTitle(),
                        const SizedBox(height: 40),
                        _buildCard(),
                        const SizedBox(height: 28),
                        _buildBottomButtons(),
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
      AppAssets.lupaPassword,
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
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: const [
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
              color: Color(0xFFFFEB3B),
              letterSpacing: 1.2,
              height: 1.1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(22, 26, 22, 28),
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
        children: [
          const Text(
            'Lupa Password?',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w900,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          _buildEmailField(),
        ],
      ),
    );
  }

  Widget _buildEmailField() {
    return TextField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      cursorColor: Colors.white70,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontStyle: FontStyle.italic,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: _navyField,
        hintText: '*Email Address*',
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

  Widget _buildBottomButtons() {
    return Row(
      children: [
        Expanded(
          child: _pillButton(
            label: 'Kembali',
            onTap: () => Navigator.of(context).pop(),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _pillButton(
            label: 'Lanjut',
            onTap: () {
              final email = _emailController.text.trim();
              if (email.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Masukkan email terlebih dahulu')),
                );
                return;
              }
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (context) => const CreatePasswordPage(),
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

/// Segitiga putih besar di pojok kiri atas (mockup).
class _TopLeftWedgePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width * 0.95, 0)
      ..lineTo(0, size.height * 0.92)
      ..close();
    canvas.drawPath(
      path,
      Paint()..color = Colors.white,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Dua garis diagonal paralel di pojok kanan bawah (mockup).
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
