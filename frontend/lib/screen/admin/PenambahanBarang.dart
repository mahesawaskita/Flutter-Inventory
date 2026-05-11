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
        return dt.year == now.year && dt.month == now.month && dt.day == now.day;
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
            _items = items.map((e) => Map<String, dynamic>.from(e)).toList();
            _categories = cats.map((e) => Map<String, dynamic>.from(e)).toList();
            _adminUsername = uname ?? 'Admin';
          });
        }
      }
    } catch (_) {} finally {
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

  // ─────────────────────────────────────────────
  // BUILD
  // ─────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
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
                    const SizedBox(height: 12),
                    _buildHistorySection(),
                    _buildBottomButtons(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  // HEADER
  // ─────────────────────────────────────────────

  Widget _buildHeader() {
    return Container(
      color: const Color(0xFF1A1A1A),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white, size: 22),
                    onPressed: () => Navigator.of(context).maybePop(),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 38,
                      height: 38,
                      decoration: const BoxDecoration(
                        color: Color(0xFF333333),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.settings, color: Color(0xFF888888), size: 20),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.shopping_cart, color: Colors.white, size: 30),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          width: 18,
                          height: 18,
                          decoration: const BoxDecoration(
                            color: Color(0xFF00FFD0),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.add, color: Colors.black, size: 12),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Penambahan Barang',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
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
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(12, 14, 12, 14),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _statCard(
                  icon: Icons.shopping_cart_outlined,
                  iconBg: const Color(0xFFDDEEFF),
                  iconColor: const Color(0xFF3998FC),
                  title: 'Total Barang\nTersedia',
                  mainValue: _totalItems.toString(),
                  sideValue: _totalItems.toString(),
                  subtitle: '+5% sejak minggu lalu',
                  subtitleColor: const Color(0xFF2DB55D),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _statCard(
                  icon: Icons.inventory_2_outlined,
                  iconBg: const Color(0xFFFFEDD5),
                  iconColor: Colors.orange,
                  title: 'Barang Baru\nHari Ini',
                  mainValue: _newToday.toString(),
                  subtitle: 'Terakhir Ditambah 5 jam lalu',
                  subtitleColor: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _statCard(
                  icon: Icons.local_shipping_outlined,
                  iconBg: const Color(0xFFFFF8DC),
                  iconColor: Colors.amber,
                  title: 'Pending Restok',
                  mainValue: _pendingRestock.toString(),
                  subtitle: '',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _statCard(
                  icon: Icons.warning_amber_rounded,
                  iconBg: const Color(0xFFFFE5E5),
                  iconColor: Colors.red,
                  title: 'Barang Rusak/\nPerlu Perbaikan',
                  mainValue: _damaged.toString(),
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
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String mainValue,
    String? sideValue,
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
            color: Colors.black.withOpacity(0.07),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
                color: iconBg, borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 9,
                          color: Colors.grey,
                          height: 1.3,
                        ),
                      ),
                    ),
                    if (sideValue != null)
                      Text(
                        sideValue,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF333333),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  mainValue,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A1A),
                    height: 1.1,
                  ),
                ),
                if (subtitle.isNotEmpty)
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 9, color: subtitleColor),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  // HISTORY SECTION
  // ─────────────────────────────────────────────

  Widget _buildHistorySection() {
    final query = _searchController.text.toLowerCase();
    final filtered = _items.where((item) {
      if (query.isEmpty) return true;
      final name = (item['name'] ?? '').toString().toLowerCase();
      final cat = _categoryName(item['category_id']).toLowerCase();
      return name.contains(query) || cat.contains(query);
    }).toList()
      ..sort((a, b) {
        final dA = DateTime.tryParse(a['created_at']?.toString() ?? '') ?? DateTime(2000);
        final dB = DateTime.tryParse(b['created_at']?.toString() ?? '') ?? DateTime(2000);
        return dB.compareTo(dA);
      });

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Riwayat Penambahan Stok',
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A1A)),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFEEEEEE)),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                  ),
                  child: const Row(
                    children: [
                      Expanded(flex: 3, child: Text('Nama Barang', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
                      Expanded(flex: 2, child: Text('Kategori', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
                      Expanded(flex: 3, child: Text('Ditambahkan\nOleh', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
                      Expanded(flex: 3, child: Text('Ditambahkan\nTanggal', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
                      SizedBox(width: 30, child: Text('Jum', textAlign: TextAlign.center, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
                    ],
                  ),
                ),
                if (_isLoading)
                  const Padding(
                    padding: EdgeInsets.all(32),
                    child: Center(child: CircularProgressIndicator(color: Color(0xFF3998FC))),
                  )
                else if (filtered.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(28),
                    child: Center(child: Text('Belum ada data barang', style: TextStyle(color: Colors.grey))),
                  )
                else
                  ...filtered.take(20).map(_buildHistoryRow),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryRow(Map<String, dynamic> item) {
    final catName = _categoryName(item['category_id']);
    final date = _formatDate(item['created_at']?.toString());
    final stock = item['stock']?.toString() ?? '0';
    final name = item['name']?.toString() ?? '-';

    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFF2F2F2), width: 1)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEEEEE),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(Icons.devices, size: 13, color: Colors.grey),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(name,
                      style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ),
          Expanded(flex: 2, child: Text(catName, style: const TextStyle(fontSize: 10, color: Color(0xFF555555)), overflow: TextOverflow.ellipsis)),
          Expanded(flex: 3, child: Text(_adminUsername, style: const TextStyle(fontSize: 10, color: Color(0xFF555555)), overflow: TextOverflow.ellipsis)),
          Expanded(flex: 3, child: Text(date, style: const TextStyle(fontSize: 10, color: Color(0xFF555555)))),
          SizedBox(width: 30, child: Text(stock, textAlign: TextAlign.center, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  // BOTTOM BUTTONS
  // ─────────────────────────────────────────────

  Widget _buildBottomButtons() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 14, 12, 0),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const DetailPenambahanBarangAdmin()),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF3998FC),
                elevation: 0,
                side: const BorderSide(color: Color(0xFF3998FC)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text('Tambah Barang', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const DetailPenambahanBarangAdmin()),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3998FC),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text('Lanjut', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}
