import 'package:flutter/material.dart';
import 'package:frontend/service/api_service.dart';
import 'package:frontend/service/auth_service.dart';
import 'package:frontend/sistem_login/login_page.dart';

import 'user_ui.dart';

class ProfileUserScreen extends StatefulWidget {
  const ProfileUserScreen({super.key});

  @override
  State<ProfileUserScreen> createState() => _ProfileUserScreenState();
}

class _ProfileUserScreenState extends State<ProfileUserScreen> {
  // Semua field dimuat dari SharedPreferences dulu, lalu di-sync dari API
  String _username = '';
  String _email = '';
  String _phone = '';
  String _jabatan = '';
  String _since = '';

  @override
  void initState() {
    super.initState();
    _loadFromCache(); // tampilkan data dari cache lokal segera
    _loadProfile();   // sync dari API di background
  }

  Future<void> _loadFromCache() async {
    final username  = await AuthService.getUsername();
    final email     = await AuthService.getEmail();
    final phone     = await AuthService.getPhone();
    final jabatan   = await AuthService.getJabatan();
    final since     = await AuthService.getSince();
    if (mounted) {
      setState(() {
        _username = username ?? '';
        _email    = email    ?? '';
        _phone    = phone    ?? '';
        _jabatan  = jabatan  ?? '';
        _since    = since    ?? '';
      });
    }
  }

  Future<void> _loadProfile() async {
    final token = await AuthService.getToken();
    if (token == null) return;
    final profile = await ApiService.getUserProfile(token);
    if (!mounted || profile == null) return;

    // Ambil tahun dari created_at
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

    // Simpan ke cache lokal
    await AuthService.saveProfileCache(
      username: username,
      email: email,
      phone: phone,
      jabatan: jabatan,
      since: since,
    );

    if (mounted) {
      setState(() {
        _username = username;
        _email    = email;
        _phone    = phone;
        _jabatan  = jabatan;
        _since    = since;
      });
    }
  }

  // ── Logout ──────────────────────────────────────────────────────────────

  Future<void> _handleLogout() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Konfirmasi Logout',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
        content: const Text('Apakah kamu yakin ingin keluar?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Logout',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
    if (confirm != true) return;
    await AuthService.logout();
    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
        (_) => false,
      );
    }
  }

  // ── Edit Profil / Data Pribadi ────────────────────────────────────────

  Future<void> _openEditProfil() async {
    final usernameCtrl = TextEditingController(text: _username);
    final emailCtrl    = TextEditingController(text: _email);
    final phoneCtrl    = TextEditingController(text: _phone);
    final jabatanCtrl  = TextEditingController(text: _jabatan);

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => _EditProfilSheet(
        usernameCtrl: usernameCtrl,
        emailCtrl: emailCtrl,
        phoneCtrl: phoneCtrl,
        jabatanCtrl: jabatanCtrl,
        onSave: () async {
          final token = await AuthService.getToken();
          if (token == null) return;
          final result = await ApiService.updateUserProfile(token, {
            'username': usernameCtrl.text.trim(),
            'email': emailCtrl.text.trim(),
            'phone': phoneCtrl.text.trim(),
            'jabatan': jabatanCtrl.text.trim(),
          });
          if (!ctx.mounted) return;
          Navigator.pop(ctx);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(result['message']?.toString() ?? ''),
            backgroundColor:
                result['success'] == true ? Colors.green : Colors.red,
          ));
          if (result['success'] == true) await _loadProfile();
        },
      ),
    );

    usernameCtrl.dispose();
    emailCtrl.dispose();
    phoneCtrl.dispose();
    jabatanCtrl.dispose();
  }

  // ── Data Password ────────────────────────────────────────────────────

  Future<void> _openChangePassword() async {
    final oldCtrl = TextEditingController();
    final newCtrl = TextEditingController();
    final confirmCtrl = TextEditingController();

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => _ChangePasswordSheet(
        oldCtrl: oldCtrl,
        newCtrl: newCtrl,
        confirmCtrl: confirmCtrl,
        onSave: () async {
          if (newCtrl.text != confirmCtrl.text) {
            ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
              content: Text('Konfirmasi password tidak cocok'),
              backgroundColor: Colors.red,
            ));
            return;
          }
          final token = await AuthService.getToken();
          if (token == null) return;
          final result = await ApiService.changePassword(
              token, oldCtrl.text, newCtrl.text);
          if (!ctx.mounted) return;
          Navigator.pop(ctx);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(result['message']?.toString() ?? ''),
            backgroundColor:
                result['success'] == true ? Colors.green : Colors.red,
          ));
        },
      ),
    );

    oldCtrl.dispose();
    newCtrl.dispose();
    confirmCtrl.dispose();
  }

  // ── Riwayat Aktivitas ────────────────────────────────────────────────

  Future<void> _openRiwayat() async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => const _RiwayatSheet(),
    );
  }

  // ── Build ─────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final username = _username.isEmpty ? '...' : _username;
    final email    = _email.isEmpty    ? '-'   : _email;
    final phone    = _phone.isEmpty    ? '-'   : _phone;
    final jabatan  = _jabatan.isEmpty  ? '-'   : _jabatan;
    final since    = _since.isEmpty    ? '-'   : _since;

    final menus = <_MenuItem>[
      _MenuItem(
        icon: Icons.badge_rounded,
        title: 'Data\nPribadi',
        onTap: _openEditProfil,
      ),
      _MenuItem(
        icon: Icons.lock_rounded,
        title: 'Data\nPassword',
        onTap: _openChangePassword,
      ),
      _MenuItem(
        icon: Icons.history_toggle_off_rounded,
        title: 'Riwayat\nAktivitas',
        onTap: _openRiwayat,
      ),
      _MenuItem(
        icon: Icons.logout_rounded,
        title: 'Logout',
        isRed: true,
        onTap: _handleLogout,
      ),
    ];

    return UserPageScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 8),

          // ── Header card ─────────────────────────────────────────────
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: UserUi.card,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Container(
                  width: 62,
                  height: 62,
                  decoration: const BoxDecoration(
                    color: Color(0xFFDFE2EC),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.person,
                      size: 42, color: Color(0xFF5C678A)),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        username,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(height: 4),
                      const Row(
                        children: [
                          Icon(Icons.circle,
                              size: 9, color: Color(0xFF17E700)),
                          SizedBox(width: 8),
                          Text('User',
                              style: TextStyle(fontSize: 13)),
                        ],
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: _openEditProfil,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDAD5DE),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text('Edit Profil',
                        style: TextStyle(fontStyle: FontStyle.italic)),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // ── Info card ────────────────────────────────────────────────
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: UserUi.card,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('Menu Profil',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w900)),
                const SizedBox(height: 16),
                _ProfileLine(label: 'Email', value: email),
                const SizedBox(height: 12),
                _ProfileLine(label: 'No. Telepon', value: phone),
                const SizedBox(height: 12),
                _ProfileLine(label: 'Jabatan', value: jabatan),
                const SizedBox(height: 12),
                _ProfileLine(label: 'Bergabung Sejak', value: since),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // ── Menu grid ────────────────────────────────────────────────
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: menus.map((menu) {
              final w =
                  (MediaQuery.of(context).size.width - 40) / 2;
              return GestureDetector(
                onTap: menu.onTap,
                child: Container(
                  width: w,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: UserUi.card,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 54,
                        height: 42,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: .6),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          menu.icon,
                          size: 28,
                          color: menu.isRed
                              ? Colors.red
                              : const Color(0xFF6099E9),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          menu.title,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            color: menu.isRed ? Colors.red : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

// ── Helper class untuk menu item ──────────────────────────────────────────────

class _MenuItem {
  const _MenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.isRed = false,
  });
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isRed;
}

// ── Edit Profil Bottom Sheet ──────────────────────────────────────────────────

class _EditProfilSheet extends StatefulWidget {
  const _EditProfilSheet({
    required this.usernameCtrl,
    required this.emailCtrl,
    required this.phoneCtrl,
    required this.jabatanCtrl,
    required this.onSave,
  });
  final TextEditingController usernameCtrl;
  final TextEditingController emailCtrl;
  final TextEditingController phoneCtrl;
  final TextEditingController jabatanCtrl;
  final Future<void> Function() onSave;

  @override
  State<_EditProfilSheet> createState() => _EditProfilSheetState();
}

class _EditProfilSheetState extends State<_EditProfilSheet> {
  bool _isSaving = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Edit Data Pribadi',
              style:
                  TextStyle(fontSize: 17, fontWeight: FontWeight.w900)),
          const SizedBox(height: 16),
          _Field(label: 'Username', ctrl: widget.usernameCtrl),
          const SizedBox(height: 10),
          _Field(
              label: 'Email',
              ctrl: widget.emailCtrl,
              type: TextInputType.emailAddress),
          const SizedBox(height: 10),
          _Field(
              label: 'No. Telepon',
              ctrl: widget.phoneCtrl,
              type: TextInputType.phone),
          const SizedBox(height: 10),
          _Field(label: 'Jabatan', ctrl: widget.jabatanCtrl),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: UserUi.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: _isSaving
                ? null
                : () async {
                    setState(() => _isSaving = true);
                    await widget.onSave();
                    if (mounted) setState(() => _isSaving = false);
                  },
            child: Text(
              _isSaving ? 'Menyimpan...' : 'Simpan',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Change Password Bottom Sheet ──────────────────────────────────────────────

class _ChangePasswordSheet extends StatefulWidget {
  const _ChangePasswordSheet({
    required this.oldCtrl,
    required this.newCtrl,
    required this.confirmCtrl,
    required this.onSave,
  });
  final TextEditingController oldCtrl;
  final TextEditingController newCtrl;
  final TextEditingController confirmCtrl;
  final Future<void> Function() onSave;

  @override
  State<_ChangePasswordSheet> createState() =>
      _ChangePasswordSheetState();
}

class _ChangePasswordSheetState extends State<_ChangePasswordSheet> {
  bool _isSaving = false;
  bool _showOld = false;
  bool _showNew = false;
  bool _showConfirm = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Ganti Password',
              style:
                  TextStyle(fontSize: 17, fontWeight: FontWeight.w900)),
          const SizedBox(height: 16),
          _PasswordField(
            label: 'Password Lama',
            ctrl: widget.oldCtrl,
            show: _showOld,
            onToggle: () => setState(() => _showOld = !_showOld),
          ),
          const SizedBox(height: 10),
          _PasswordField(
            label: 'Password Baru',
            ctrl: widget.newCtrl,
            show: _showNew,
            onToggle: () => setState(() => _showNew = !_showNew),
          ),
          const SizedBox(height: 10),
          _PasswordField(
            label: 'Konfirmasi Password Baru',
            ctrl: widget.confirmCtrl,
            show: _showConfirm,
            onToggle: () =>
                setState(() => _showConfirm = !_showConfirm),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: UserUi.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: _isSaving
                ? null
                : () async {
                    setState(() => _isSaving = true);
                    await widget.onSave();
                    if (mounted) setState(() => _isSaving = false);
                  },
            child: Text(
              _isSaving ? 'Menyimpan...' : 'Simpan',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Riwayat Aktivitas Bottom Sheet ────────────────────────────────────────────

class _RiwayatSheet extends StatefulWidget {
  const _RiwayatSheet();

  @override
  State<_RiwayatSheet> createState() => _RiwayatSheetState();
}

class _RiwayatSheetState extends State<_RiwayatSheet> {
  List<dynamic> _loans = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final token = await AuthService.getToken();
    if (token == null) {
      if (mounted) setState(() => _isLoading = false);
      return;
    }
    final loans = await ApiService.getMyLoans(token);
    if (mounted) {
      setState(() {
        _loans = loans;
        _isLoading = false;
      });
    }
  }

  String _fmt(String? s) {
    if (s == null) return '-';
    try {
      final d = DateTime.parse(s);
      const m = [
        'Jan','Feb','Mar','Apr','Mei','Jun',
        'Jul','Agu','Sep','Okt','Nov','Des'
      ];
      return '${d.day} ${m[d.month - 1]} ${d.year}';
    } catch (_) {
      return s;
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
            margin: const EdgeInsets.only(top: 12, bottom: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Riwayat Aktivitas',
                style: TextStyle(
                    fontSize: 17, fontWeight: FontWeight.w900),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                        color: UserUi.blue))
                : _loans.isEmpty
                    ? const Center(
                        child: Text('Belum ada aktivitas',
                            style: TextStyle(
                                color: UserUi.textMuted,
                                fontSize: 13)))
                    : ListView.separated(
                        controller: scrollCtrl,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 4),
                        itemCount: _loans.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(height: 8),
                        itemBuilder: (_, i) {
                          final loan =
                              Map<String, dynamic>.from(_loans[i]);
                          final isActive =
                              loan['status'] == 'borrowed';
                          final name =
                              loan['item_name']?.toString() ?? '-';
                          final borrow =
                              _fmt(loan['borrow_date']?.toString());
                          final ret = isActive
                              ? 'Belum dikembalikan'
                              : _fmt(
                                  loan['return_date']?.toString());
                          final statusColor = isActive
                              ? const Color(0xFF5DAA56)
                              : const Color(0xFF4D7BEE);
                          final statusText = isActive
                              ? 'Dipinjam'
                              : 'Dikembalikan';

                          return Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: UserUi.card,
                              borderRadius:
                                  BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: statusColor
                                        .withValues(alpha: .15),
                                    borderRadius:
                                        BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    isActive
                                        ? Icons.inventory_2_rounded
                                        : Icons.check_circle_rounded,
                                    color: statusColor,
                                    size: 22,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(name,
                                          style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight:
                                                  FontWeight.w800)),
                                      const SizedBox(height: 2),
                                      Text(
                                        'Dipinjam: $borrow',
                                        style: const TextStyle(
                                            fontSize: 11,
                                            color: UserUi.textMuted),
                                      ),
                                      Text(
                                        'Kembali: $ret',
                                        style: const TextStyle(
                                            fontSize: 11,
                                            color: UserUi.textMuted),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4),
                                  decoration: BoxDecoration(
                                    color: statusColor
                                        .withValues(alpha: .15),
                                    borderRadius:
                                        BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    statusText,
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                        color: statusColor),
                                  ),
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

// ── Reusable widgets ──────────────────────────────────────────────────────────

class _ProfileLine extends StatelessWidget {
  const _ProfileLine({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(label,
              style: const TextStyle(
                  fontSize: 13, color: Colors.black54)),
        ),
        Expanded(
          flex: 3,
          child: Text(value,
              style: const TextStyle(
                  fontSize: 13, fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({
    required this.label,
    required this.ctrl,
    this.type = TextInputType.text,
  });
  final String label;
  final TextEditingController ctrl;
  final TextInputType type;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.black54)),
        const SizedBox(height: 4),
        TextField(
          controller: ctrl,
          keyboardType: type,
          style: const TextStyle(fontSize: 13),
          decoration: InputDecoration(
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            filled: true,
            fillColor: const Color(0xFFF6F3F8),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: UserUi.blue),
            ),
          ),
        ),
      ],
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField({
    required this.label,
    required this.ctrl,
    required this.show,
    required this.onToggle,
  });
  final String label;
  final TextEditingController ctrl;
  final bool show;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.black54)),
        const SizedBox(height: 4),
        TextField(
          controller: ctrl,
          obscureText: !show,
          style: const TextStyle(fontSize: 13),
          decoration: InputDecoration(
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            filled: true,
            fillColor: const Color(0xFFF6F3F8),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: UserUi.blue),
            ),
            suffixIcon: GestureDetector(
              onTap: onToggle,
              child: Icon(
                show ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                size: 18,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
