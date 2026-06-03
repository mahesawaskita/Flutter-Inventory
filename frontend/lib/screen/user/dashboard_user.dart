import 'package:flutter/material.dart';
import 'package:frontend/screen/user/daftar_barang_user.dart';
import 'package:frontend/screen/user/peminjaman_barang_user.dart';
import 'package:frontend/screen/user/pengembalian_barang_user.dart';
import 'package:frontend/screen/user/profile_user.dart';
import 'package:frontend/screen/user/qr_scanner_user.dart';
import 'package:frontend/screen/user/status_barang_user.dart';
import 'package:frontend/service/api_service.dart';
import 'package:frontend/service/auth_service.dart';

class DashboardUserScreen extends StatefulWidget {
  const DashboardUserScreen({super.key});

  @override
  State<DashboardUserScreen> createState() => _DashboardUserScreenState();
}

class _DashboardUserScreenState extends State<DashboardUserScreen> {
  String _username = '';
  String _email = '';
  int _totalItems = 0;
  int _myBorrowed = 0;
  int _myPending = 0;
  int _myOverdue = 0;
  bool _isLoading = true;

  static const _bg = Color(0xFF0D1117);

  @override
  void initState() {
    super.initState();
    _loadAll();
  }

  Future<void> _loadAll() async {
    if (mounted) setState(() => _isLoading = true);
    try {
      final token = await AuthService.getToken();
      final username = await AuthService.getUsername();
      if (mounted) setState(() => _username = username ?? '');
      if (token == null) return;

      final profile = await ApiService.getUserProfile(token);
      if (mounted && profile != null) {
        setState(() {
          _username = profile['username']?.toString() ?? _username;
          _email = profile['email']?.toString() ?? '';
        });
      }

      final results = await Future.wait([
        ApiService.getItems(token),
        ApiService.getMyLoans(token),
      ]);
      final items = results[0];
      final myLoans = results[1];

      if (mounted) {
        setState(() {
          _totalItems = items.length;
          _myBorrowed = myLoans.where((l) => l['status'] == 'borrowed').length;
          _myPending = myLoans.where((l) => l['status'] == 'pending').length;
          _myOverdue = myLoans.where((l) {
            if (l['status'] != 'borrowed') return false;
            try {
              return DateTime.parse(l['due_date'].toString()).isBefore(DateTime.now());
            } catch (_) {
              return false;
            }
          }).length;
          _isLoading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  String get _greeting {
    final h = DateTime.now().hour;
    if (h >= 5 && h < 11) return 'Selamat Pagi, ☀️';
    if (h >= 11 && h < 15) return 'Selamat Siang, 🌤️';
    if (h >= 15 && h < 18) return 'Selamat Sore, 🌅';
    return 'Selamat Malam, 🌙';
  }

  String get _todayDate {
    final now = DateTime.now();
    const days = ['Senin','Selasa','Rabu','Kamis','Jumat','Sabtu','Minggu'];
    const months = ['Januari','Februari','Maret','April','Mei','Juni','Juli','Agustus','September','Oktober','November','Desember'];
    return '${days[now.weekday - 1]}, ${now.day} ${months[now.month - 1]} ${now.year}';
  }

  void _go(Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen))
        .then((_) { if (mounted) _loadAll(); });
  }

  @override
  Widget build(BuildContext context) {
    final displayName = _email.isNotEmpty ? _email : (_username.isNotEmpty ? _username : '...');

    return Scaffold(
      backgroundColor: _bg,
      body: RefreshIndicator(
        onRefresh: _loadAll,
        color: const Color(0xFF8A20F7),
        backgroundColor: const Color(0xFF1A2035),
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // ── Top bar ────────────────────────────────────────
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.calendar_today_rounded, size: 12, color: Colors.white54),
                                const SizedBox(width: 5),
                                Text(_todayDate, style: const TextStyle(fontSize: 11, color: Colors.white60)),
                              ],
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () => _go(const ProfileUserScreen()),
                            child: Container(
                              width: 38,
                              height: 38,
                              decoration: const BoxDecoration(
                                color: Color(0xFF8A20F7),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.person_rounded, color: Colors.white, size: 22),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // ── Greeting ──────────────────────────────────────
                      Text(_greeting, style: const TextStyle(fontSize: 14, color: Colors.white60)),
                      const SizedBox(height: 4),
                      Text(
                        displayName,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                        decoration: BoxDecoration(
                          color: const Color(0xFF8A20F7),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.circle, color: Colors.white, size: 7),
                            SizedBox(width: 6),
                            Text('User', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),

                      const SizedBox(height: 28),

                      // ── Ringkasan ──────────────────────────────────────
                      const Text('Ringkasan', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),
                      GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        childAspectRatio: 1.65,
                        children: [
                          _StatCard(
                            label: 'Total Barang',
                            value: _isLoading ? null : _totalItems,
                            icon: Icons.inventory_2_rounded,
                            color: const Color(0xFF4A6CF7),
                          ),
                          _StatCard(
                            label: 'Menunggu\nPersetujuan',
                            value: _isLoading ? null : _myPending,
                            icon: Icons.pending_actions_rounded,
                            color: const Color(0xFFF97316),
                            highlight: _myPending > 0,
                          ),
                          _StatCard(
                            label: 'Sedang Dipinjam',
                            value: _isLoading ? null : _myBorrowed,
                            icon: Icons.swap_horiz_rounded,
                            color: const Color(0xFF10B981),
                          ),
                          _StatCard(
                            label: 'Terlambat',
                            value: _isLoading ? null : _myOverdue,
                            icon: Icons.warning_amber_rounded,
                            color: const Color(0xFFEF4444),
                            highlight: _myOverdue > 0,
                          ),
                        ],
                      ),

                      const SizedBox(height: 28),

                      // ── Menu Utama ─────────────────────────────────────
                      const Text('Menu Utama', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),

                      // Row 1: Kembalian + Daftar
                      GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        childAspectRatio: 1.05,
                        children: [
                          _MenuCard(
                            title: 'Kembalian\nBarang',
                            description: 'Kembalikan barang yang sedang dipinjam',
                            icon: Icons.sync_alt_rounded,
                            color: const Color(0xFF4A6CF7),
                            badge: _myBorrowed,
                            onTap: () => _go(const PengembalianBarangUserScreen()),
                          ),
                          _MenuCard(
                            title: 'Daftar\nBarang',
                            description: 'Lihat semua barang yang tersedia',
                            icon: Icons.list_alt_rounded,
                            color: const Color(0xFF0891B2),
                            onTap: () => _go(const DaftarBarangUserScreen()),
                          ),
                          _MenuCard(
                            title: 'Status\nBarang',
                            description: 'Pantau kondisi & status barang',
                            icon: Icons.bar_chart_rounded,
                            color: const Color(0xFF7C3AED),
                            onTap: () => _go(const StatusBarangUserScreen()),
                          ),
                          _MenuCard(
                            title: 'Barcode\nScanner',
                            description: 'Scan QR untuk pinjam atau lihat barang',
                            icon: Icons.qr_code_scanner_rounded,
                            color: const Color(0xFF10B981),
                            onTap: () => _go(const QRScannerUserScreen()),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // Full-width card: Peminjaman Barang
                      _MenuCardWide(
                        title: 'Peminjaman Barang',
                        description: 'Lihat & kelola semua peminjaman barang kamu',
                        icon: Icons.receipt_long_rounded,
                        color: const Color(0xFFDB2777),
                        badge: _myPending,
                        onTap: () => _go(const PeminjamanBarangUserScreen()),
                      ),

                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Stat card ──────────────────────────────────────────────────────────────

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    this.highlight = false,
  });

  final String label;
  final int? value;
  final IconData icon;
  final Color color;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: color.withValues(alpha: 0.35), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      padding: const EdgeInsets.fromLTRB(14, 14, 10, 14),
      child: Stack(
        children: [
          Positioned(
            right: -4,
            bottom: -8,
            child: Icon(icon, size: 56, color: Colors.white.withValues(alpha: 0.18)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              value == null
                  ? const SizedBox(
                      width: 24, height: 24,
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '$value',
                          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white, height: 1),
                        ),
                        if (highlight && value! > 0) ...[
                          const SizedBox(width: 4),
                          Container(
                            width: 8, height: 8,
                            decoration: const BoxDecoration(color: Colors.yellow, shape: BoxShape.circle),
                          ),
                        ],
                      ],
                    ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(fontSize: 10, color: Colors.white.withValues(alpha: 0.8), height: 1.3),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Menu card (square) ─────────────────────────────────────────────────────

class _MenuCard extends StatelessWidget {
  const _MenuCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.onTap,
    this.badge = 0,
  });

  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final int badge;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: color.withValues(alpha: 0.4), blurRadius: 12, offset: const Offset(0, 5))],
            ),
            padding: const EdgeInsets.all(14),
            child: Stack(
              children: [
                Positioned(
                  right: -10,
                  top: -10,
                  child: Icon(icon, size: 70, color: Colors.white.withValues(alpha: 0.12)),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 38,
                      height: 38,
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
                        Text(title,
                            style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold, height: 1.25)),
                        const SizedBox(height: 3),
                        Text(description,
                            style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 9, height: 1.3),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis),
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
        ),
        if (badge > 0)
          Positioned(
            top: -6,
            right: -6,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.yellow[700],
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 4, offset: const Offset(0, 2))],
              ),
              child: Text(
                badge > 99 ? '99+' : '$badge',
                style: const TextStyle(color: Colors.black, fontSize: 11, fontWeight: FontWeight.bold),
              ),
            ),
          ),
      ],
    );
  }
}

// ── Menu card (full width) ─────────────────────────────────────────────────

class _MenuCardWide extends StatelessWidget {
  const _MenuCardWide({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.onTap,
    this.badge = 0,
  });

  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final int badge;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: color.withValues(alpha: 0.4), blurRadius: 12, offset: const Offset(0, 5))],
            ),
            padding: const EdgeInsets.all(16),
            child: Stack(
              children: [
                Positioned(
                  right: -10,
                  top: -10,
                  child: Icon(icon, size: 90, color: Colors.white.withValues(alpha: 0.1)),
                ),
                Row(
                  children: [
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(icon, color: Colors.white, size: 26),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title,
                              style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 3),
                          Text(description,
                              style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 11),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text('Buka', style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 11, fontWeight: FontWeight.w600)),
                        const SizedBox(width: 3),
                        Icon(Icons.arrow_forward_rounded, color: Colors.white.withValues(alpha: 0.85), size: 14),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (badge > 0)
          Positioned(
            top: -6,
            right: -6,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.yellow[700],
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 4, offset: const Offset(0, 2))],
              ),
              child: Text(
                badge > 99 ? '99+' : '$badge',
                style: const TextStyle(color: Colors.black, fontSize: 11, fontWeight: FontWeight.bold),
              ),
            ),
          ),
      ],
    );
  }
}
