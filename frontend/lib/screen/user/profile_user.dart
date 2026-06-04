import 'package:flutter/material.dart';
import 'package:frontend/service/api_service.dart';
import 'package:frontend/service/auth_service.dart';
import 'package:frontend/sistem_login/login_page.dart';

class ProfileUserScreen extends StatefulWidget {
  const ProfileUserScreen({super.key});

  @override
  State<ProfileUserScreen> createState() => _ProfileUserScreenState();
}

class _ProfileUserScreenState extends State<ProfileUserScreen> {
  String _username = '';
  String _email    = '';
  String _phone    = '';
  String _jabatan  = '';
  String _since    = '';

  static const _bg     = Color(0xFF0D1117);
  static const _purple = Color(0xFF8A20F7);
  static const _blue   = Color(0xFF4A6CF7);
  static const _green  = Color(0xFF10B981);
  static const _red    = Color(0xFFEF4444);
  static const _cyan   = Color(0xFF0891B2);
  static const _orange = Color(0xFFF97316);

  @override
  void initState() {
    super.initState();
    _loadFromCache();
    _loadProfile();
  }

  Future<void> _loadFromCache() async {
    final username = await AuthService.getUsername();
    final email    = await AuthService.getEmail();
    final phone    = await AuthService.getPhone();
    final jabatan  = await AuthService.getJabatan();
    final since    = await AuthService.getSince();
    if (!mounted) return;
    setState(() {
      _username = username ?? '';
      _email    = email    ?? '';
      _phone    = phone    ?? '';
      _jabatan  = jabatan  ?? '';
      _since    = since    ?? '';
    });
  }

  Future<void> _loadProfile() async {
    final token = await AuthService.getToken();
    if (token == null) return;
    final profile = await ApiService.getUserProfile(token);
    if (!mounted || profile == null) return;

    String since = _since;
    final raw = profile['created_at']?.toString();
    if (raw != null && raw.isNotEmpty) {
      try {
        since = DateTime.parse(raw).year.toString();
      } catch (_) {
        if (raw.length >= 4) since = raw.substring(0, 4);
      }
    }

    final username = profile['username']?.toString() ?? _username;
    final email    = profile['email']?.toString()    ?? _email;
    final phone    = profile['phone']?.toString()    ?? _phone;
    final jabatan  = profile['jabatan']?.toString()  ?? _jabatan;

    await AuthService.saveProfileCache(
      username: username,
      email: email,
      phone: phone,
      jabatan: jabatan,
      since: since,
    );

    if (!mounted) return;
    setState(() {
      _username = username;
      _email    = email;
      _phone    = phone;
      _jabatan  = jabatan;
      _since    = since;
    });
  }

  // ── Logout ────────────────────────────────────────────────────────────────

  Future<void> _handleLogout() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: const Color(0xFF161B27),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60, height: 60,
                decoration: BoxDecoration(
                  color: _red.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.logout_rounded, color: _red, size: 30),
              ),
              const SizedBox(height: 16),
              const Text('Konfirmasi Logout',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white)),
              const SizedBox(height: 8),
              Text('Apakah kamu yakin ingin keluar?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, color: Colors.white.withValues(alpha: 0.6))),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.pop(ctx, false),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
                        ),
                        alignment: Alignment.center,
                        child: const Text('Batal',
                            style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.pop(ctx, true),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: _red,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [BoxShadow(color: _red.withValues(alpha: 0.4), blurRadius: 8, offset: const Offset(0, 3))],
                        ),
                        alignment: Alignment.center,
                        child: const Text('Logout',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    if (confirm != true) return;
    await AuthService.logout();
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (_) => false,
    );
  }

  // ── Edit Profil ───────────────────────────────────────────────────────────

  Future<void> _openEditProfil() async {
    // Capture messenger BEFORE showing the sheet (safe — synchronous)
    final messenger = ScaffoldMessenger.of(context);

    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF161B27),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => _EditProfilSheet(
        username: _username,
        email: _email,
        phone: _phone,
        jabatan: _jabatan,
      ),
    );

    // result is null if sheet was dismissed without saving
    if (result == null) return;

    messenger.showSnackBar(SnackBar(
      content: Text(result['message']?.toString() ?? ''),
      backgroundColor: result['success'] == true ? _green : _red,
    ));

    if (result['success'] == true && mounted) await _loadProfile();
  }

  // ── Ganti Password ────────────────────────────────────────────────────────

  Future<void> _openChangePassword() async {
    final messenger = ScaffoldMessenger.of(context);

    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF161B27),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => const _ChangePasswordSheet(),
    );

    if (result == null) return;

    messenger.showSnackBar(SnackBar(
      content: Text(result['message']?.toString() ?? ''),
      backgroundColor: result['success'] == true ? _green : _red,
    ));
  }

  // ── Riwayat Aktivitas ─────────────────────────────────────────────────────

  Future<void> _openRiwayat() async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF161B27),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => const _RiwayatSheet(),
    );
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final username = _username.isEmpty ? '...' : _username;
    final email    = _email.isEmpty    ? '-'   : _email;
    final phone    = _phone.isEmpty    ? '-'   : _phone;
    final jabatan  = _jabatan.isEmpty  ? '-'   : _jabatan;
    final since    = _since.isEmpty    ? '-'   : _since;

    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [

                    // ── Header ─────────────────────────────────────────────
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.maybePop(context),
                          child: Container(
                            width: 38, height: 38,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
                            ),
                            child: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 20),
                          ),
                        ),
                        const Spacer(),
                        const Text('Profil Saya',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                        const Spacer(),
                        const SizedBox(width: 38),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // ── Profile Banner ─────────────────────────────────────
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: _purple,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [BoxShadow(color: _purple.withValues(alpha: 0.4), blurRadius: 16, offset: const Offset(0, 6))],
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            right: -12, top: -12,
                            child: Icon(Icons.person_rounded, size: 120, color: Colors.white.withValues(alpha: 0.1)),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 64, height: 64,
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: const Icon(Icons.person_rounded, size: 38, color: Colors.white),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(username,
                                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                                        maxLines: 1, overflow: TextOverflow.ellipsis),
                                    const SizedBox(height: 6),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(alpha: 0.2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.circle, size: 7, color: Colors.white),
                                          SizedBox(width: 6),
                                          Text('User', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: _openEditProfil,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.edit_rounded, size: 13, color: Colors.white),
                                      SizedBox(width: 5),
                                      Text('Edit', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ── Info Card ──────────────────────────────────────────
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
                      ),
                      child: Column(
                        children: [
                          _InfoRow(icon: Icons.email_rounded,   iconColor: _blue,   label: 'Email',           value: email),
                          _RowDivider(),
                          _InfoRow(icon: Icons.phone_rounded,   iconColor: _green,  label: 'No. Telepon',     value: phone),
                          _RowDivider(),
                          _InfoRow(icon: Icons.work_rounded,    iconColor: _orange, label: 'Jabatan',         value: jabatan),
                          _RowDivider(),
                          _InfoRow(icon: Icons.calendar_today_rounded, iconColor: _cyan, label: 'Bergabung Sejak', value: since),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // ── Menu Grid ──────────────────────────────────────────
                    const Text('Menu Profil',
                        style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),

                    GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      childAspectRatio: 1.25,
                      children: [
                        _MenuCard(
                          title: 'Data Pribadi',
                          description: 'Edit profil & info akun',
                          icon: Icons.badge_rounded,
                          color: _blue,
                          onTap: _openEditProfil,
                        ),
                        _MenuCard(
                          title: 'Data Password',
                          description: 'Ganti password akun',
                          icon: Icons.lock_rounded,
                          color: _purple,
                          onTap: _openChangePassword,
                        ),
                        _MenuCard(
                          title: 'Riwayat Aktivitas',
                          description: 'Lihat semua aktivitas',
                          icon: Icons.history_rounded,
                          color: _cyan,
                          onTap: _openRiwayat,
                        ),
                        _MenuCard(
                          title: 'Logout',
                          description: 'Keluar dari akun',
                          icon: Icons.logout_rounded,
                          color: _red,
                          onTap: _handleLogout,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Info Row ──────────────────────────────────────────────────────────────────

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.iconColor, required this.label, required this.value});
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 32, height: 32,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 16, color: iconColor),
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(label, style: TextStyle(fontSize: 13, color: Colors.white.withValues(alpha: 0.55)))),
            Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white)),
          ],
        ),
      );
}

class _RowDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Divider(height: 1, color: Colors.white.withValues(alpha: 0.08));
}

// ── Menu Card ─────────────────────────────────────────────────────────────────

class _MenuCard extends StatelessWidget {
  const _MenuCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.onTap,
  });
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: color.withValues(alpha: 0.4), blurRadius: 12, offset: const Offset(0, 5))],
          ),
          child: Stack(
            children: [
              Positioned(
                right: -10, top: -10,
                child: Icon(icon, size: 70, color: Colors.white.withValues(alpha: 0.12)),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 38, height: 38,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(icon, color: Colors.white, size: 20),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(title, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 2),
                      Text(description,
                          style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 9),
                          maxLines: 1, overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Text('Buka', style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 10, fontWeight: FontWeight.w600)),
                          const SizedBox(width: 3),
                          Icon(Icons.arrow_forward_rounded, color: Colors.white.withValues(alpha: 0.85), size: 12),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}

// ── Edit Profil Sheet ─────────────────────────────────────────────────────────
// Sheet mengelola API call sendiri dan mengembalikan result via Navigator.pop

class _EditProfilSheet extends StatefulWidget {
  const _EditProfilSheet({
    required this.username,
    required this.email,
    required this.phone,
    required this.jabatan,
  });
  final String username;
  final String email;
  final String phone;
  final String jabatan;

  @override
  State<_EditProfilSheet> createState() => _EditProfilSheetState();
}

class _EditProfilSheetState extends State<_EditProfilSheet> {
  late final TextEditingController _usernameCtrl;
  late final TextEditingController _emailCtrl;
  late final TextEditingController _phoneCtrl;
  late final TextEditingController _jabatanCtrl;
  bool _isSaving = false;

  static const _blue = Color(0xFF4A6CF7);

  @override
  void initState() {
    super.initState();
    _usernameCtrl = TextEditingController(text: widget.username);
    _emailCtrl    = TextEditingController(text: widget.email);
    _phoneCtrl    = TextEditingController(text: widget.phone);
    _jabatanCtrl  = TextEditingController(text: widget.jabatan);
  }

  @override
  void dispose() {
    _usernameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _jabatanCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    setState(() => _isSaving = true);
    try {
      final token = await AuthService.getToken();
      if (!mounted) return;
      if (token == null) {
        Navigator.pop(context, {'success': false, 'message': 'Sesi berakhir. Login ulang.'});
        return;
      }
      final result = await ApiService.updateUserProfile(token, {
        'username': _usernameCtrl.text.trim(),
        'email'   : _emailCtrl.text.trim(),
        'phone'   : _phoneCtrl.text.trim(),
        'jabatan' : _jabatanCtrl.text.trim(),
      });
      if (!mounted) return;
      Navigator.pop(context, result);
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20, right: 20, top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Handle
          Center(
            child: Container(
              width: 40, height: 4,
              decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(2)),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Edit Data Pribadi',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: Colors.white)),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 30, height: 30,
                  decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                  child: const Icon(Icons.close_rounded, color: Colors.white60, size: 16),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _DarkField(label: 'Username',    ctrl: _usernameCtrl, icon: Icons.person_rounded),
          const SizedBox(height: 10),
          _DarkField(label: 'Email',       ctrl: _emailCtrl,    icon: Icons.email_rounded,   type: TextInputType.emailAddress),
          const SizedBox(height: 10),
          _DarkField(label: 'No. Telepon', ctrl: _phoneCtrl,    icon: Icons.phone_rounded,   type: TextInputType.phone),
          const SizedBox(height: 10),
          _DarkField(label: 'Jabatan',     ctrl: _jabatanCtrl,  icon: Icons.work_rounded),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: _isSaving ? null : _save,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: _isSaving ? _blue.withValues(alpha: 0.5) : _blue,
                borderRadius: BorderRadius.circular(14),
                boxShadow: _isSaving ? null : [BoxShadow(color: _blue.withValues(alpha: 0.4), blurRadius: 10, offset: const Offset(0, 4))],
              ),
              alignment: Alignment.center,
              child: _isSaving
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5))
                  : const Text('Simpan', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w800)),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Change Password Sheet ─────────────────────────────────────────────────────

class _ChangePasswordSheet extends StatefulWidget {
  const _ChangePasswordSheet();

  @override
  State<_ChangePasswordSheet> createState() => _ChangePasswordSheetState();
}

class _ChangePasswordSheetState extends State<_ChangePasswordSheet> {
  final _oldCtrl     = TextEditingController();
  final _newCtrl     = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _showOld     = false;
  bool _showNew     = false;
  bool _showConfirm = false;
  bool _isSaving    = false;

  static const _blue = Color(0xFF4A6CF7);

  @override
  void dispose() {
    _oldCtrl.dispose();
    _newCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_newCtrl.text != _confirmCtrl.text) {
      Navigator.pop(context, {'success': false, 'message': 'Konfirmasi password tidak cocok'});
      return;
    }
    if (_newCtrl.text.trim().isEmpty) {
      Navigator.pop(context, {'success': false, 'message': 'Password baru tidak boleh kosong'});
      return;
    }

    setState(() => _isSaving = true);
    try {
      final token = await AuthService.getToken();
      if (!mounted) return;
      if (token == null) {
        Navigator.pop(context, {'success': false, 'message': 'Sesi berakhir. Login ulang.'});
        return;
      }
      final result = await ApiService.changePassword(token, _oldCtrl.text, _newCtrl.text);
      if (!mounted) return;
      Navigator.pop(context, result);
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20, right: 20, top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 40, height: 4,
              decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(2)),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Ganti Password',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: Colors.white)),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 30, height: 30,
                  decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                  child: const Icon(Icons.close_rounded, color: Colors.white60, size: 16),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _DarkPasswordField(label: 'Password Lama',          ctrl: _oldCtrl,     show: _showOld,     onToggle: () => setState(() => _showOld = !_showOld)),
          const SizedBox(height: 10),
          _DarkPasswordField(label: 'Password Baru',          ctrl: _newCtrl,     show: _showNew,     onToggle: () => setState(() => _showNew = !_showNew)),
          const SizedBox(height: 10),
          _DarkPasswordField(label: 'Konfirmasi Password Baru', ctrl: _confirmCtrl, show: _showConfirm, onToggle: () => setState(() => _showConfirm = !_showConfirm)),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: _isSaving ? null : _save,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: _isSaving ? _blue.withValues(alpha: 0.5) : _blue,
                borderRadius: BorderRadius.circular(14),
                boxShadow: _isSaving ? null : [BoxShadow(color: _blue.withValues(alpha: 0.4), blurRadius: 10, offset: const Offset(0, 4))],
              ),
              alignment: Alignment.center,
              child: _isSaving
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5))
                  : const Text('Simpan', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w800)),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Riwayat Aktivitas Sheet ───────────────────────────────────────────────────

class _RiwayatSheet extends StatefulWidget {
  const _RiwayatSheet();

  @override
  State<_RiwayatSheet> createState() => _RiwayatSheetState();
}

class _RiwayatSheetState extends State<_RiwayatSheet> {
  List<dynamic> _loans = [];
  bool _isLoading = true;

  static const _blue   = Color(0xFF4A6CF7);
  static const _green  = Color(0xFF10B981);
  static const _orange = Color(0xFFF97316);
  static const _red    = Color(0xFFEF4444);

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final token = await AuthService.getToken();
    if (!mounted) return;
    if (token == null) { setState(() => _isLoading = false); return; }
    final loans = await ApiService.getMyLoans(token);
    if (!mounted) return;
    setState(() { _loans = loans; _isLoading = false; });
  }

  String _fmt(String? s) {
    if (s == null) return '-';
    try {
      final d = DateTime.parse(s);
      const m = ['Jan','Feb','Mar','Apr','Mei','Jun','Jul','Agu','Sep','Okt','Nov','Des'];
      return '${d.day} ${m[d.month - 1]} ${d.year}';
    } catch (_) { return s; }
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'borrowed' : return _orange;
      case 'returned' : return _green;
      case 'pending'  : return _blue;
      default         : return _red;
    }
  }

  String _statusText(String status) {
    switch (status) {
      case 'borrowed' : return 'Dipinjam';
      case 'returned' : return 'Dikembalikan';
      case 'pending'  : return 'Menunggu';
      default         : return status;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.65,
      maxChildSize: 0.9,
      minChildSize: 0.4,
      builder: (ctx, scrollCtrl) => Column(
        children: [
          // Handle
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 4),
            width: 40, height: 4,
            decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(2)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
            child: Row(
              children: [
                const Text('Riwayat Aktivitas',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: Colors.white)),
                const Spacer(),
                if (!_isLoading)
                  Text('${_loans.length} data',
                      style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.45))),
              ],
            ),
          ),
          Divider(height: 1, color: Colors.white.withValues(alpha: 0.08)),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator(color: Color(0xFF4A6CF7)))
                : _loans.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.history_rounded, size: 48, color: Colors.white.withValues(alpha: 0.2)),
                            const SizedBox(height: 12),
                            Text('Belum ada aktivitas',
                                style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 13)),
                          ],
                        ),
                      )
                    : ListView.separated(
                        controller: scrollCtrl,
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                        itemCount: _loans.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 8),
                        itemBuilder: (_, i) {
                          final loan   = Map<String, dynamic>.from(_loans[i]);
                          final status = loan['status']?.toString() ?? 'borrowed';
                          final name   = loan['item_name']?.toString() ?? '-';
                          final borrow = _fmt(loan['borrow_date']?.toString());
                          final ret    = status == 'returned'
                              ? _fmt(loan['return_date']?.toString())
                              : 'Belum dikembalikan';
                          final color  = _statusColor(status);
                          final text   = _statusText(status);

                          return Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.06),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 42, height: 42,
                                  decoration: BoxDecoration(
                                    color: color.withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(11),
                                  ),
                                  child: Icon(
                                    status == 'returned' ? Icons.check_circle_rounded : Icons.inventory_2_rounded,
                                    color: color, size: 22,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white)),
                                      const SizedBox(height: 3),
                                      Text('Dipinjam: $borrow', style: TextStyle(fontSize: 11, color: Colors.white.withValues(alpha: 0.45))),
                                      Text('Kembali: $ret',     style: TextStyle(fontSize: 11, color: Colors.white.withValues(alpha: 0.45))),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: color.withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: color.withValues(alpha: 0.35)),
                                  ),
                                  child: Text(text, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: color)),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}

// ── Dark input field ──────────────────────────────────────────────────────────

class _DarkField extends StatelessWidget {
  const _DarkField({required this.label, required this.ctrl, required this.icon, this.type = TextInputType.text});
  final String label;
  final TextEditingController ctrl;
  final IconData icon;
  final TextInputType type;

  static const _blue = Color(0xFF4A6CF7);

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white.withValues(alpha: 0.55))),
          const SizedBox(height: 6),
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.07),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
            ),
            child: TextField(
              controller: ctrl,
              keyboardType: type,
              style: const TextStyle(fontSize: 13, color: Colors.white),
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                border: InputBorder.none,
                prefixIcon: Icon(icon, size: 16, color: Colors.white.withValues(alpha: 0.4)),
                prefixIconConstraints: const BoxConstraints(minWidth: 40),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: _blue, width: 1.5),
                ),
              ),
            ),
          ),
        ],
      );
}

class _DarkPasswordField extends StatelessWidget {
  const _DarkPasswordField({required this.label, required this.ctrl, required this.show, required this.onToggle});
  final String label;
  final TextEditingController ctrl;
  final bool show;
  final VoidCallback onToggle;

  static const _blue = Color(0xFF4A6CF7);

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white.withValues(alpha: 0.55))),
          const SizedBox(height: 6),
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.07),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
            ),
            child: TextField(
              controller: ctrl,
              obscureText: !show,
              style: const TextStyle(fontSize: 13, color: Colors.white),
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                border: InputBorder.none,
                prefixIcon: Icon(Icons.lock_outline_rounded, size: 16, color: Colors.white.withValues(alpha: 0.4)),
                prefixIconConstraints: const BoxConstraints(minWidth: 40),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: _blue, width: 1.5),
                ),
                suffixIcon: GestureDetector(
                  onTap: onToggle,
                  child: Icon(
                    show ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                    size: 18, color: Colors.white.withValues(alpha: 0.4),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
}
