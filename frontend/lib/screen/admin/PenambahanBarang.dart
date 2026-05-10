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
  int _activeTab = 0;
  final _searchController = TextEditingController();
  final _nameController = TextEditingController();
  final _descController = TextEditingController();

  List<Map<String, dynamic>> _items = [];
  List<Map<String, dynamic>> _categories = [];
  bool _isLoading = true;

  // Stats computed from items list
  int get _totalItems => _items.length;
  int get _newToday => _items.where((item) {
        final raw = item['created_at']?.toString() ?? '';
        final dt = DateTime.tryParse(raw);
        if (dt == null) return false;
        final now = DateTime.now();
        return dt.year == now.year && dt.month == now.month && dt.day == now.day;
      }).length;
  int get _pendingRestock =>
      _items.where((item) => (item['stock'] as int? ?? 0) < 5).length;
  int get _damaged => _items.where((item) {
        final c = (item['condition'] ?? '').toString().toLowerCase();
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
    _nameController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      final token = await AuthService.getToken();
      if (token != null) {
        final items = await ApiService.getItems(token);
        final cats = await ApiService.getCategories(token);
        setState(() {
          _items = items.map((e) => Map<String, dynamic>.from(e)).toList();
          _categories = cats.map((e) => Map<String, dynamic>.from(e)).toList();
        });
      }
    } catch (_) {
      // tampilkan data kosong, user bisa refresh
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  String _categoryName(dynamic catId) {
    if (catId == null) return '-';
    final match = _categories.firstWhere(
      (c) => c['id'].toString() == catId.toString(),
      orElse: () => {'name': '-'},
    );
    return match['name']?.toString() ?? '-';
  }

  String _formatDate(String? raw) {
    if (raw == null) return '-';
    final dt = DateTime.tryParse(raw);
    if (dt == null) return '-';
    const m = [
      'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
      'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'
    ];
    return '${dt.day} ${m[dt.month - 1]} ${dt.year}';
  }

  // ─────────────────────────────────────────────
  // BUILD
  // ─────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _loadData,
                color: const Color(0xFF3998FC),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      _buildStats(),
                      _buildTabBar(),
                      _activeTab == 0 ? _buildAddTab() : _buildHistoryTab(),
                      const SizedBox(height: 24),
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

  // ─────────────────────────────────────────────
  // HEADER
  // ─────────────────────────────────────────────

  Widget _buildHeader() {
    return Container(
      color: const Color(0xFF1A1A1A),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).maybePop(),
            child: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 12),
          Stack(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.shopping_cart,
                    color: Colors.white, size: 22),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: const BoxDecoration(
                    color: Color(0xFF00FFD0),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.add, color: Colors.black, size: 10),
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              'Penambahan Barang',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const Icon(Icons.settings, color: Color(0xFF888888), size: 24),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  // STATS
  // ─────────────────────────────────────────────

  Widget _buildStats() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 4),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _statCard(
                  icon: Icons.shopping_cart_outlined,
                  iconColor: const Color(0xFF3998FC),
                  bgColor: const Color(0xFFE3F0FF),
                  title: 'Total Barang\nTersedia',
                  value: _totalItems.toString(),
                  subtitle: '+5% sejak minggu lalu',
                  subtitleColor: Colors.green,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _statCard(
                  icon: Icons.inventory_2_outlined,
                  iconColor: Colors.orange,
                  bgColor: const Color(0xFFFFF3E0),
                  title: 'Barang Baru\nHari Ini',
                  value: _newToday.toString(),
                  subtitle: 'Terakhir Ditambah 5 jam lalu',
                  subtitleColor: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _statCard(
                  icon: Icons.autorenew,
                  iconColor: Colors.amber,
                  bgColor: const Color(0xFFFFFDE7),
                  title: 'Pending Restok',
                  value: _pendingRestock.toString(),
                  subtitle: '',
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _statCard(
                  icon: Icons.warning_amber_rounded,
                  iconColor: Colors.red,
                  bgColor: const Color(0xFFFDE8E8),
                  title: 'Barang Rusak/\nPerlu Perbaikan',
                  value: _damaged.toString(),
                  subtitle: '',
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
    required Color iconColor,
    required Color bgColor,
    required String title,
    required String value,
    required String subtitle,
    Color subtitleColor = Colors.grey,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 6,
              offset: const Offset(0, 2))
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration:
                BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 10, color: Colors.grey, height: 1.3)),
                Text(value,
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1A1A))),
                if (subtitle.isNotEmpty)
                  Text(subtitle,
                      style: TextStyle(fontSize: 9, color: subtitleColor),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  // TAB BAR
  // ─────────────────────────────────────────────

  Widget _buildTabBar() {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          _tab(0, 'Tambah Barang'),
          _tab(1, 'History Penambahan'),
        ],
      ),
    );
  }

  Widget _tab(int index, String label) {
    final active = _activeTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _activeTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color:
                    active ? const Color(0xFF3998FC) : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontWeight:
                  active ? FontWeight.bold : FontWeight.normal,
              color:
                  active ? const Color(0xFF3998FC) : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  // TAB 0 — TAMBAH BARANG
  // ─────────────────────────────────────────────

  Widget _buildAddTab() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          // Search row
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 38,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFDDDDDD)),
                  ),
                  child: TextField(
                    controller: _searchController,
                    style: const TextStyle(fontSize: 13),
                    decoration: const InputDecoration(
                      hintText: 'Cari barang, kategori...',
                      hintStyle:
                          TextStyle(fontSize: 12, color: Colors.grey),
                      prefixIcon: Icon(Icons.search, size: 18, color: Colors.grey),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  // navigate to detail search (placeholder)
                },
                child: Container(
                  height: 38,
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3998FC),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text('Detail',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Form card
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE8E8E8)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 4,
                    offset: const Offset(0, 1))
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Photo area
                    GestureDetector(
                      onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Fitur upload foto segera hadir')),
                      ),
                      child: Container(
                        width: 88,
                        height: 80,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: const Color(0xFFDDDDDD), width: 1.5),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.camera_alt_outlined,
                                size: 26, color: Colors.grey),
                            SizedBox(height: 4),
                            Text(
                              'Tambahkan\nFoto Barang',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 9,
                                  color: Colors.grey,
                                  height: 1.4),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Right side fields
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Nama Barang field
                          Container(
                            height: 36,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color(0xFFDDDDDD)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextField(
                              controller: _nameController,
                              style: const TextStyle(fontSize: 13),
                              decoration: const InputDecoration(
                                hintText: 'Nama Barang',
                                hintStyle: TextStyle(
                                    fontSize: 13, color: Colors.grey),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 9),
                                isDense: true,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Category chip + stock counter
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE3F0FF),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: const Color(0xFF3998FC)
                                          .withOpacity(0.4)),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      _categories.isNotEmpty
                                          ? _categories[0]['name']
                                          : 'Elektronik',
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF3998FC),
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(width: 4),
                                    const Icon(Icons.close,
                                        size: 12, color: Colors.red),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text('10',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(width: 4),
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF3998FC),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: const Icon(Icons.add,
                                    color: Colors.white, size: 16),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Stok Perkiraan: $_totalItems',
                            style: const TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                                fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Description field
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFDDDDDD)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: _descController,
                    maxLines: 2,
                    style: const TextStyle(fontSize: 12),
                    decoration: const InputDecoration(
                      hintText:
                          'Contoh: Laptop merek Asus ROG Core i9 dengan RAM 8',
                      hintStyle:
                          TextStyle(fontSize: 11, color: Colors.grey),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10),
                    ),
                  ),
                ),
                const SizedBox(height: 14),

                // Tambah Barang button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const DetailPenambahanBarangAdmin(),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3998FC),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(vertical: 13),
                    ),
                    child: const Text('Tambah Barang',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  // TAB 1 — HISTORY PENAMBAHAN
  // ─────────────────────────────────────────────

  Widget _buildHistoryTab() {
    final query = _searchController.text.toLowerCase();
    final filtered = _items.where((item) {
      if (query.isEmpty) return true;
      final name = (item['name'] ?? '').toString().toLowerCase();
      final cat = _categoryName(item['category_id']).toLowerCase();
      return name.contains(query) || cat.contains(query);
    }).toList()
      ..sort((a, b) {
        final dA =
            DateTime.tryParse(a['created_at']?.toString() ?? '') ?? DateTime(2000);
        final dB =
            DateTime.tryParse(b['created_at']?.toString() ?? '') ?? DateTime(2000);
        return dB.compareTo(dA);
      });

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Riwayat Penambahan Stok',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A1A)),
          ),
          const SizedBox(height: 10),
          if (_isLoading)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(40),
                child:
                    CircularProgressIndicator(color: Color(0xFF3998FC)),
              ),
            )
          else if (filtered.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Text(
                  _items.isEmpty
                      ? 'Belum ada data barang'
                      : 'Tidak ada hasil untuk "$query"',
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            )
          else
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE8E8E8)),
              ),
              child: Column(
                children: [
                  // Table header
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 8),
                    decoration: const BoxDecoration(
                      color: Color(0xFFF5F5F5),
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(12)),
                    ),
                    child: const Row(
                      children: [
                        Expanded(
                            flex: 3,
                            child: Text('Nama Barang',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold))),
                        Expanded(
                            flex: 2,
                            child: Text('Kategori',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold))),
                        Expanded(
                            flex: 2,
                            child: Text('Ditambahkan\nTanggal',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold))),
                        SizedBox(
                          width: 32,
                          child: Text('Jum',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),

                  // Rows
                  ...filtered.take(15).map(_buildHistoryRow),
                ],
              ),
            ),
          const SizedBox(height: 16),

          // Lanjut button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const DetailPenambahanBarangAdmin(),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3998FC),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(vertical: 13),
              ),
              child: const Text('Lanjut',
                  style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryRow(Map<String, dynamic> item) {
    final catName = _categoryName(item['category_id']);
    final dateStr = _formatDate(item['created_at']?.toString());
    final stock = item['stock']?.toString() ?? '0';
    final name = item['name']?.toString() ?? '-';

    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: const BoxDecoration(
        border: Border(
            bottom: BorderSide(color: Color(0xFFF0F0F0), width: 1)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                const Icon(Icons.inventory_2_outlined,
                    size: 13, color: Color(0xFF3998FC)),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(name,
                      style: const TextStyle(
                          fontSize: 11, fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(catName,
                style:
                    const TextStyle(fontSize: 11, color: Colors.grey),
                overflow: TextOverflow.ellipsis),
          ),
          Expanded(
            flex: 2,
            child: Text(dateStr,
                style:
                    const TextStyle(fontSize: 10, color: Colors.grey)),
          ),
          SizedBox(
            width: 32,
            child: Text(stock,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 12, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
