import 'package:flutter/material.dart';
import 'package:frontend/screen/admin/DaftarBarang.dart';
import 'package:frontend/screen/admin/PenambahanBarang.dart';
import 'package:frontend/screen/admin/PersetujuanPeminjaman.dart';
import 'package:frontend/screen/admin/Profil.dart';
import 'package:frontend/screen/admin/StatusBarang.dart';
import 'package:frontend/service/api_service.dart';
import 'package:frontend/service/auth_service.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  String _username = '';
  int _pendingCount = 0;
  int _totalItems = 0;
  int _activeLoans = 0;
  int _lowStock = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      final username = await AuthService.getUsername();
      if (mounted) setState(() => _username = username ?? '');

      final token = await AuthService.getToken();
      if (token == null) return;

      final results = await Future.wait([
        ApiService.getItems(token),
        ApiService.getAllLoans(token),
      ]);

      final items = results[0];
      final loans = results[1];

      if (mounted) {
        setState(() {
          _totalItems = items.length;
          _pendingCount =
              loans.where((l) => l['status'] == 'pending').length;
          _activeLoans =
              loans.where((l) => l['status'] == 'borrowed').length;
          _lowStock = items
              .where((i) => (i['stock'] as int? ?? 0) < 5)
              .length;
          _isLoading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  String _greeting() {
    final h = DateTime.now().hour;
    if (h < 11) return 'Selamat Pagi';
    if (h < 15) return 'Selamat Siang';
    if (h < 18) return 'Selamat Sore';
    return 'Selamat Malam';
  }

  String _todayDate() {
    const months = [
      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];
    const days = [
      'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'
    ];
    final now = DateTime.now();
    return '${days[now.weekday - 1]}, ${now.day} ${months[now.month - 1]} ${now.year}';
  }

  // ─────────────────────────────────────────────
  // BUILD
  // ─────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F8),
      body: RefreshIndicator(
        onRefresh: _loadData,
        color: const Color(0xFF3998FC),
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(child: _buildHeader()),
            SliverToBoxAdapter(child: _buildStats()),
            SliverToBoxAdapter(child: _buildMenuSection()),
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  // HEADER
  // ─────────────────────────────────────────────

  Widget _buildHeader() {
    final displayName = _username.isEmpty ? '...' : _username;
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top row: date + profile button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: .08),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: Colors.white.withValues(alpha: .15)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today_rounded,
                            color: Colors.white54, size: 12),
                        const SizedBox(width: 5),
                        Text(_todayDate(),
                            style: const TextStyle(
                                color: Colors.white60, fontSize: 11)),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ProfilPage()),
                    ),
                    child: Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF3998FC), Color(0xFF1E78D6)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Colors.white.withValues(alpha: .3),
                            width: 2),
                      ),
                      child: const Icon(Icons.person_rounded,
                          color: Colors.white, size: 20),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Greeting
              Text(
                '${_greeting()}, 👋',
                style: const TextStyle(
                    color: Colors.white60, fontSize: 14),
              ),
              const SizedBox(height: 4),
              Text(
                displayName,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: .3),
              ),
              const SizedBox(height: 8),

              // Admin badge
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF3998FC).withValues(alpha: .25),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: const Color(0xFF3998FC).withValues(alpha: .5)),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.shield_rounded,
                        color: Color(0xFF6BBFFF), size: 13),
                    SizedBox(width: 5),
                    Text('Administrator',
                        style: TextStyle(
                            color: Color(0xFF6BBFFF),
                            fontSize: 11,
                            fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  // STATS
  // ─────────────────────────────────────────────

  Widget _buildStats() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 2, bottom: 12),
            child: Text(
              'Ringkasan',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A)),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _statCard(
                  icon: Icons.inventory_2_rounded,
                  gradient: const [Color(0xFF3998FC), Color(0xFF1E78D6)],
                  label: 'Total Barang',
                  value: _isLoading ? '-' : '$_totalItems',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _statCard(
                  icon: Icons.pending_actions_rounded,
                  gradient: const [Color(0xFFFF9800), Color(0xFFE65100)],
                  label: 'Menunggu Persetujuan',
                  value: _isLoading ? '-' : '$_pendingCount',
                  showDot: _pendingCount > 0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _statCard(
                  icon: Icons.swap_horiz_rounded,
                  gradient: const [Color(0xFF00C853), Color(0xFF00962F)],
                  label: 'Sedang Dipinjam',
                  value: _isLoading ? '-' : '$_activeLoans',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _statCard(
                  icon: Icons.warning_amber_rounded,
                  gradient: const [Color(0xFFE53935), Color(0xFFB71C1C)],
                  label: 'Stok Rendah',
                  value: _isLoading ? '-' : '$_lowStock',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statCard({
    required IconData icon,
    required List<Color> gradient,
    required String label,
    required String value,
    bool showDot = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: gradient.first.withValues(alpha: .35),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(value,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            height: 1)),
                    if (showDot) ...[
                      const SizedBox(width: 4),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                            color: Colors.yellow,
                            shape: BoxShape.circle),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 3),
                Text(label,
                    style: TextStyle(
                        color: Colors.white.withValues(alpha: .8),
                        fontSize: 10,
                        fontWeight: FontWeight.w500),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  // MENU SECTION
  // ─────────────────────────────────────────────

  Widget _buildMenuSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 2, bottom: 14),
            child: Text(
              'Menu Utama',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A)),
            ),
          ),
          // Row 1
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: _menuCard(
                    title: 'Penambahan\nBarang',
                    subtitle: 'Tambah & kelola stok barang inventaris',
                    icon: Icons.add_shopping_cart_rounded,
                    gradient: const [Color(0xFF3998FC), Color(0xFF1565C0)],
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const PenambahanBarangAdmin()),
                    ).then((_) => _loadData()),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: _menuCard(
                    title: 'Daftar\nBarang',
                    subtitle: 'Lihat & edit semua barang',
                    icon: Icons.list_alt_rounded,
                    gradient: const [Color(0xFF00BFA5), Color(0xFF00796B)],
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const DaftarBarangPage()),
                    ).then((_) => _loadData()),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          // Row 2
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: _menuCard(
                    title: 'Status\nBarang',
                    subtitle: 'Pantau kondisi & status barang',
                    icon: Icons.bar_chart_rounded,
                    gradient: const [Color(0xFF7C4DFF), Color(0xFF4527A0)],
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const StatusBarangAdmin()),
                    ).then((_) => _loadData()),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: _menuCardWithBadge(
                    title: 'Persetujuan\nPeminjaman',
                    subtitle: 'Setujui atau tolak pengajuan',
                    icon: Icons.assignment_turned_in_rounded,
                    gradient: const [Color(0xFFF4511E), Color(0xFFBF360C)],
                    badge: _pendingCount,
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                const PersetujuanPeminjamanAdmin()),
                      );
                      _loadData();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required List<Color> gradient,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // No fixed height — determined by content; IntrinsicHeight makes row-mates match
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: gradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: gradient.first.withValues(alpha: .4),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Watermark
            Positioned(
              right: -8,
              top: -8,
              child: Icon(icon,
                  size: 72,
                  color: Colors.white.withValues(alpha: .12)),
            ),
            // Content: icon top, text group bottom
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Top icon
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: .2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: Colors.white, size: 22),
                ),
                // Bottom text group
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          height: 1.3),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: TextStyle(
                          color: Colors.white.withValues(alpha: .7),
                          fontSize: 9,
                          height: 1.3),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Text('Buka',
                            style: TextStyle(
                                color: Colors.white.withValues(alpha: .8),
                                fontSize: 10,
                                fontWeight: FontWeight.w600)),
                        const SizedBox(width: 3),
                        Icon(Icons.arrow_forward_rounded,
                            color: Colors.white.withValues(alpha: .8),
                            size: 12),
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

  Widget _menuCardWithBadge({
    required String title,
    required String subtitle,
    required IconData icon,
    required List<Color> gradient,
    required int badge,
    required VoidCallback onTap,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        _menuCard(
          title: title,
          subtitle: subtitle,
          icon: icon,
          gradient: gradient,
          onTap: onTap,
        ),
        if (badge > 0)
          Positioned(
            top: -6,
            right: -6,
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 7, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.yellow[700],
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: .2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                badge > 99 ? '99+' : '$badge',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 11,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
      ],
    );
  }
}
