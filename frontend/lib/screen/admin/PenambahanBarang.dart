import 'package:flutter/material.dart';
import 'package:frontend/screen/admin/TambahBarang.dart';
import 'package:frontend/service/api_service.dart';
import 'package:frontend/service/auth_service.dart';

class PenambahanBarangAdmin extends StatefulWidget {
  const PenambahanBarangAdmin({super.key});

  @override
  State<PenambahanBarangAdmin> createState() => _PenambahanBarangAdminState();
}

class _PenambahanBarangAdminState extends State<PenambahanBarangAdmin> {
  final _searchController = TextEditingController();

  List<Map<String, dynamic>> _items = [];
  List<Map<String, dynamic>> _categories = [];
  bool _isLoading = true;
  String _adminUsername = 'Admin';

  int get _totalItems => _items.length;
  int get _newToday => _items.where((item) {
        final dt = DateTime.tryParse(item['created_at']?.toString() ?? '');
        if (dt == null) return false;
        final now = DateTime.now();
        return dt.year == now.year &&
            dt.month == now.month &&
            dt.day == now.day;
      }).length;
  int get _pendingRestock =>
      _items.where((i) => (i['stock'] as int? ?? 0) < 5).length;
  int get _damaged => _items.where((i) {
        final c = (i['condition'] ?? '').toString().toLowerCase();
        return c == 'rusak' || c == 'perlu perbaikan';
      }).length;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      final token = await AuthService.getToken();
      final uname = await AuthService.getUsername();
      if (token != null) {
        final items = await ApiService.getItems(token);
        final cats = await ApiService.getCategories(token);
        if (mounted) {
          setState(() {
            _items =
                items.map((e) => Map<String, dynamic>.from(e)).toList();
            _categories =
                cats.map((e) => Map<String, dynamic>.from(e)).toList();
            _adminUsername = uname ?? 'Admin';
          });
        }
      }
    } catch (_) {
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  String _categoryName(dynamic catId) {
    if (catId == null) return '-';
    final m = _categories.firstWhere(
      (c) => c['id'].toString() == catId.toString(),
      orElse: () => {'name': '-'},
    );
    return m['name']?.toString() ?? '-';
  }

  String _formatDate(String? raw) {
    if (raw == null) return '-';
    final dt = DateTime.tryParse(raw);
    if (dt == null) return '-';
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
      'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'
    ];
    return '${dt.day} ${months[dt.month - 1]} ${dt.year}';
  }

  void _goToTambahBarang() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => const DetailPenambahanBarangAdmin()),
    ).then((_) => _loadData());
  }

  // ─────────────────────────────────────────────
  // BUILD
  // ─────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F8),
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _loadData,
              color: const Color(0xFF3998FC),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildStatsGrid(),
                    _buildSearchBar(),
                    _buildItemList(),
                    const SizedBox(height: 90), // room for FAB
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTambahBarang,
        backgroundColor: const Color(0xFF3998FC),
        foregroundColor: Colors.white,
        elevation: 3,
        icon: const Icon(Icons.add_rounded),
        label: const Text('Tambah Barang',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  // ─────────────────────────────────────────────
  // HEADER
  // ─────────────────────────────────────────────

  Widget _buildHeader() {
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
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).maybePop(),
                    child: const Row(
                      children: [
                        Icon(Icons.arrow_back_ios_new_rounded,
                            color: Colors.white70, size: 18),
                        SizedBox(width: 4),
                        Text('Kembali',
                            style: TextStyle(
                                color: Colors.white70, fontSize: 13)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: .1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: Colors.white.withValues(alpha: .2)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.person_rounded,
                            color: Colors.white60, size: 14),
                        const SizedBox(width: 5),
                        Text(_adminUsername,
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Row(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: const Color(0xFF3998FC).withValues(alpha: .25),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.add_shopping_cart_rounded,
                        color: Color(0xFF6BBFFF), size: 26),
                  ),
                  const SizedBox(width: 14),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Penambahan Barang',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Kelola inventaris barang',
                        style: TextStyle(
                            color: Colors.white54, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  // STATS GRID
  // ─────────────────────────────────────────────

  Widget _buildStatsGrid() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _statCard(
                  icon: Icons.inventory_2_rounded,
                  gradient: const [Color(0xFF3998FC), Color(0xFF1E78D6)],
                  label: 'Total Barang',
                  value: _totalItems.toString(),
                  sub: 'Tersedia di inventaris',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _statCard(
                  icon: Icons.today_rounded,
                  gradient: const [Color(0xFF00C853), Color(0xFF00962F)],
                  label: 'Ditambah Hari Ini',
                  value: _newToday.toString(),
                  sub: 'Barang baru',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _statCard(
                  icon: Icons.warning_amber_rounded,
                  gradient: const [Color(0xFFFF9800), Color(0xFFE65100)],
                  label: 'Stok Rendah',
                  value: _pendingRestock.toString(),
                  sub: 'Perlu restok (< 5)',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _statCard(
                  icon: Icons.build_rounded,
                  gradient: const [Color(0xFFE53935), Color(0xFFB71C1C)],
                  label: 'Perlu Perbaikan',
                  value: _damaged.toString(),
                  sub: 'Rusak / perbaikan',
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
    required String sub,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: gradient.first.withValues(alpha: .35),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        height: 1)),
                const SizedBox(height: 2),
                Text(label,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600)),
                Text(sub,
                    style: TextStyle(
                        color: Colors.white.withValues(alpha: .7),
                        fontSize: 9),
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  // SEARCH BAR
  // ─────────────────────────────────────────────

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: .06),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (_) => setState(() {}),
                style: const TextStyle(fontSize: 13),
                decoration: InputDecoration(
                  hintText: 'Cari nama atau kategori barang...',
                  hintStyle: const TextStyle(
                      color: Color(0xFFAAAAAA), fontSize: 13),
                  prefixIcon: const Icon(Icons.search_rounded,
                      color: Color(0xFF3998FC), size: 20),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? GestureDetector(
                          onTap: () {
                            _searchController.clear();
                            setState(() {});
                          },
                          child: const Icon(Icons.close_rounded,
                              color: Colors.grey, size: 18),
                        )
                      : null,
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 13),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  // ITEM LIST
  // ─────────────────────────────────────────────

  Widget _buildItemList() {
    final query = _searchController.text.toLowerCase();
    final filtered = _items.where((item) {
      if (query.isEmpty) return true;
      final name = (item['name'] ?? '').toString().toLowerCase();
      final cat = _categoryName(item['category_id']).toLowerCase();
      return name.contains(query) || cat.contains(query);
    }).toList()
      ..sort((a, b) {
        final dA =
            DateTime.tryParse(a['created_at']?.toString() ?? '') ??
                DateTime(2000);
        final dB =
            DateTime.tryParse(b['created_at']?.toString() ?? '') ??
                DateTime(2000);
        return dB.compareTo(dA);
      });

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Riwayat Penambahan Stok',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A1A)),
              ),
              Text(
                '${filtered.length} barang',
                style: const TextStyle(
                    fontSize: 12, color: Color(0xFF888888)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (_isLoading)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(40),
                child: CircularProgressIndicator(
                    color: Color(0xFF3998FC)),
              ),
            )
          else if (filtered.isEmpty)
            Container(
              padding: const EdgeInsets.all(36),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Center(
                child: Column(
                  children: [
                    Icon(Icons.inventory_2_outlined,
                        size: 44, color: Color(0xFFCCCCCC)),
                    SizedBox(height: 10),
                    Text('Belum ada data barang',
                        style: TextStyle(
                            color: Color(0xFFAAAAAA), fontSize: 13)),
                  ],
                ),
              ),
            )
          else
            ...filtered.take(50).map(_buildItemCard),
        ],
      ),
    );
  }

  Widget _buildItemCard(Map<String, dynamic> item) {
    final catName = _categoryName(item['category_id']);
    final date = _formatDate(item['created_at']?.toString());
    final stock = item['stock'] as int? ?? 0;
    final name = item['name']?.toString() ?? '-';
    final condition = (item['condition'] ?? 'Tersedia').toString();

    final condColor = _conditionColor(condition);
    final avatarColor = _nameColor(name);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: avatarColor.withValues(alpha: .15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                name.isNotEmpty ? name[0].toUpperCase() : '?',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: avatarColor),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1A1A)),
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 3),
                Row(
                  children: [
                    const Icon(Icons.category_rounded,
                        size: 11, color: Color(0xFFAAAAAA)),
                    const SizedBox(width: 3),
                    Text(catName,
                        style: const TextStyle(
                            fontSize: 11, color: Color(0xFF888888))),
                    const SizedBox(width: 10),
                    const Icon(Icons.calendar_today_rounded,
                        size: 11, color: Color(0xFFAAAAAA)),
                    const SizedBox(width: 3),
                    Text(date,
                        style: const TextStyle(
                            fontSize: 11, color: Color(0xFF888888))),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // Right side: stock + condition badge
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: condColor.withValues(alpha: .12),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: condColor.withValues(alpha: .3)),
                ),
                child: Text(condition,
                    style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        color: condColor)),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  const Icon(Icons.layers_rounded,
                      size: 11, color: Color(0xFFAAAAAA)),
                  const SizedBox(width: 3),
                  Text('$stock pcs',
                      style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF555555))),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _conditionColor(String condition) {
    switch (condition.toLowerCase()) {
      case 'tersedia':
        return const Color(0xFF2DB55D);
      case 'dipinjam':
        return const Color(0xFF3998FC);
      case 'rusak':
        return const Color(0xFFE53935);
      case 'perlu perbaikan':
        return const Color(0xFFFF9800);
      default:
        return const Color(0xFF888888);
    }
  }

  Color _nameColor(String name) {
    const colors = [
      Color(0xFF3998FC),
      Color(0xFF9C27B0),
      Color(0xFFE91E63),
      Color(0xFF009688),
      Color(0xFFFF5722),
      Color(0xFF795548),
      Color(0xFF607D8B),
    ];
    if (name.isEmpty) return colors[0];
    return colors[name.codeUnitAt(0) % colors.length];
  }
}
