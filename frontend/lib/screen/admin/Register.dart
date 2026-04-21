import 'package:flutter/material.dart';
import 'package:frontend/constants/app_assets.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
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
                _buildRegisterCard(),
                const SizedBox(height: 32),
                _buildBottomButtons(),
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
          AppAssets.registrasi,
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

  Widget _buildRegisterCard() {
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
            'REGISTER',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Colors.black,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 20),
          _inputField(
            controller: _usernameController,
            hint: 'Username',
            isPassword: false,
          ),
          const SizedBox(height: 14),
          _inputField(
            controller: _passwordController,
            hint: 'Password',
            isPassword: true,
            obscure: _obscurePassword,
            toggle: () => setState(() => _obscurePassword = !_obscurePassword),
          ),
          const SizedBox(height: 14),
          _inputField(
            controller: _confirmController,
            hint: 'Confirm Password',
            isPassword: true,
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
    required bool isPassword,
    bool obscure = false,
    VoidCallback? toggle,
  }) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: const Color(0xFF1B3A6B),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword ? obscure : false,
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
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    obscure ? Icons.visibility_off : Icons.visibility,
                    color: Colors.white60,
                    size: 20,
                  ),
                  onPressed: toggle,
                )
              : null,
        ),
      ),
    );
  }

  Widget _buildBottomButtons() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _outlinedButton(
          label: 'Kembali',
          onTap: () => Navigator.of(context).pop(),
        ),
        const Spacer(),
        _outlinedButton(label: 'REGISTER', onTap: _onRegister),
      ],
    );
  }

  void _onRegister() {
    final user = _usernameController.text.trim();
    final pass = _passwordController.text;
    final confirm = _confirmController.text;
    if (user.isEmpty || pass.isEmpty || confirm.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lengkapi semua field terlebih dahulu')),
      );
      return;
    }
    if (pass != confirm) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password dan konfirmasi tidak sama')),
      );
      return;
    }
    Navigator.of(context).pop();
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
