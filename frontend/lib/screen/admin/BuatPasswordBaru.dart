import 'package:flutter/material.dart';
import 'package:frontend/constants/app_assets.dart';
import 'package:frontend/screen/admin/login.dart';

class CreatePasswordPage extends StatefulWidget {
  const CreatePasswordPage({super.key});

  @override
  State<CreatePasswordPage> createState() => _CreatePasswordPageState();
}

class _CreatePasswordPageState extends State<CreatePasswordPage> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                _buildLogo(),
                const SizedBox(height: 24),
                _buildTitle(),
                const SizedBox(height: 36),
                _buildPasswordCard(),
                const SizedBox(height: 32),
                _buildBottomButton(),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 130,
      height: 130,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFFFFD700),
        border: Border.all(color: Colors.black, width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipOval(
        child: Image.asset(
          AppAssets.buatPasswordBaru,
          width: 130,
          height: 130,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return RichText(
      text: const TextSpan(
        children: [
          TextSpan(
            text: 'TELE ',
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic,
              color: Colors.white,
              letterSpacing: 1.5,
            ),
          ),
          TextSpan(
            text: 'MATIKA',
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w900,
              color: Color(0xFFFFD700),
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'Buat Baru Password',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Colors.black,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 20),
          _inputField(
            controller: _newPasswordController,
            hint: 'Password',
            obscure: _obscureNew,
            toggle: () => setState(() => _obscureNew = !_obscureNew),
          ),
          const SizedBox(height: 14),
          const Text(
            'Konfirmasi Password',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Colors.black,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 20),
          _inputField(
            controller: _confirmPasswordController,
            hint: 'Password',
            obscure: _obscureConfirm,
            toggle: () => setState(() => _obscureConfirm = !_obscureConfirm),
          ),
        ],
      ),
    );
  }

  Widget _inputField({
    required TextEditingController controller,
    required String hint,
    required bool obscure,
    required VoidCallback toggle,
  }) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: const Color(0xFF1B3A6B),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontStyle: FontStyle.italic,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            color: Colors.white70,
            fontSize: 15,
            fontStyle: FontStyle.italic,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 22,
            vertical: 14,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              obscure ? Icons.visibility_off : Icons.visibility,
              color: Colors.white60,
              size: 20,
            ),
            onPressed: toggle,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomButton() {
    return Align(
      alignment: Alignment.center,
        child: _outlinedButton(label: 'Login Kembali', onTap: _onLoginKembali),
    );
  }

  void _onLoginKembali() {
    final a = _newPasswordController.text;
    final b = _confirmPasswordController.text;
    if (a.isEmpty || b.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Isi password dan konfirmasi terlebih dahulu')),
      );
      return;
    }
    if (a != b) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password dan konfirmasi tidak sama')),
      );
      return;
    }
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(builder: (context) => const LoginPage()),
      (route) => false,
    );
  }

  Widget _outlinedButton({
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 13),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}
