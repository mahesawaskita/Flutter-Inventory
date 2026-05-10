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

  // Quick-add form state
  final _quickNameController = TextEditingController();
  final _quickDescController = TextEditingController();
  int _quickStock = 10;
  Map<String, dynamic>? _quickCategory;

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
    _quickNameController.dispose();
    _quickDescController.dispose();
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
            // Set default quick category jika belum dipilih
            if (_quickCategory == null && _categories.isNotEmpty) {
              _quickCategory = _categories.first;
            }
          });
        }
      }
    } catch (_) {}
    finally {
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

  void _showCategoryPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text('Pilih Kategori',
                  style: TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold)),
            ),
            ..._categories.map((cat) => ListTile(
                  title: Text(cat['name'].toString()),
                  trailing: _quickCategory?['id'] == cat['id']
                      ? const Icon(Icons.check, color: Color(0xFF3998FC))
                      : null,
                  onTap: () {
                    setState(() => _quickCategory = cat);
                    Navigator.pop(context);
                  },
                )),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  // ROOT BUILD
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
                    _buildTabBar(),
                    if (_activeTab == 0) _buildAddFormContent(),
                    _buildHistorySection(),
                    _buildLanjutButton(),
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
            // Top row: back + settings
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back,
                        color: Colors.white, size: 22),
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
                      child: const Icon(Icons.settings,
                          color: Color(0xFF888888), size: 20),
                    ),
                  ),
                ],
              ),
            ),
            // Cart icon + title
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
                        child: const Icon(Icons.shopping_cart,
                            color: Colors.white, size: 30),
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
                          child: const Icon(Icons.add,
                              color: Colors.black, size: 12),
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
          // Icon box
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
                // Title + side value (small, inline)
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
                // Main large value
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
  // TAB BAR
  // ─────────────────────────────────────────────

  Widget _buildTabBar() {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 4),
      child: Row(
        children: [
          _tab(0, 'Tambah Barang'),
          _tab(1, 'History Penambahan'),
        ],
      ),
    );
  }

  Widget _tab(int idx, String label) {
    final active = _activeTab == idx;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _activeTab = idx),
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 13),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: active
                    ? const Color(0xFF3998FC)
                    : Colors.transparent,
                width: 2.5,
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
              color: active
                  ? const Color(0xFF3998FC)
                  : const Color(0xFF888888),
            ),
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  // ADD FORM CONTENT (Tab 0)
  // ─────────────────────────────────────────────

  Widget _buildAddFormContent() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      child: Column(
        children: [
          // ── Search row ──
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: const Color(0xFFDDDDDD)),
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (_) => setState(() {}),
                    style: const TextStyle(fontSize: 13),
                    decoration: const InputDecoration(
                      hintText: 'Cari barang, kategori...',
                      hintStyle:
                          TextStyle(fontSize: 12, color: Colors.grey),
                      prefixIcon: Icon(Icons.search,
                          size: 18, color: Colors.grey),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 11),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const DetailPenambahanBarangAdmin(),
                  ),
                ),
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3998FC),
                    borderRadius: BorderRadius.circular(22),
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

          const SizedBox(height: 10),

          // ── Quick-add card ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFEEEEEE)),
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
                      onTap: () =>
                          ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                                Text('Fitur upload foto segera hadir')),
                      ),
                      child: Container(
                        width: 86,
                        height: 80,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3F3F3),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: const Color(0xFFDDDDDD), width: 1),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.camera_alt_outlined,
                                size: 28, color: Color(0xFF999999)),
                            SizedBox(height: 4),
                            Text(
                              'Tambahkan\nFoto Barang',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 9,
                                  color: Color(0xFF999999),
                                  height: 1.4),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),

                    // Right column
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Nama Barang field
                          SizedBox(
                            height: 34,
                            child: TextField(
                              controller: _quickNameController,
                              style: const TextStyle(fontSize: 13),
                              decoration: InputDecoration(
                                hintText: 'Nama Barang',
                                hintStyle: const TextStyle(
                                    fontSize: 13, color: Color(0xFFBBBBBB)),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 8),
                                isDense: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  borderSide: const BorderSide(
                                      color: Color(0xFFDDDDDD)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  borderSide: const BorderSide(
                                      color: Color(0xFFDDDDDD)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  borderSide: const BorderSide(
                                      color: Color(0xFF3998FC), width: 1.5),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 8),

                          // Category chip + counter row
                          Row(
                            children: [
                              // Chip — tap untuk ganti kategori
                              GestureDetector(
                                onTap: _showCategoryPicker,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
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
                                        _quickCategory?['name']?.toString() ??
                                            (_categories.isNotEmpty
                                                ? _categories.first['name']
                                                    .toString()
                                                : 'Elektronik'),
                                        style: const TextStyle(
                                            fontSize: 11,
                                            color: Color(0xFF3998FC),
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(width: 3),
                                      // X = reset stok ke 0
                                      GestureDetector(
                                        onTap: () => setState(
                                            () => _quickStock = 0),
                                        child: const Icon(Icons.close,
                                            size: 11, color: Colors.red),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              // Stok count (dinamis)
                              Text('$_quickStock',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF222222))),
                              const SizedBox(width: 5),
                              // + button — tambah stok
                              GestureDetector(
                                onTap: () =>
                                    setState(() => _quickStock++),
                                child: Container(
                                  width: 22,
                                  height: 22,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF3998FC),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: const Icon(Icons.add,
                                      color: Colors.white, size: 14),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 5),

                          Text(
                            'Stok Perkiraan: $_totalItems',
                            style: const TextStyle(
                                fontSize: 10,
                                color: Color(0xFF999999),
                                fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // Description field
                TextField(
                  controller: _quickDescController,
                  maxLines: 2,
                  style: const TextStyle(fontSize: 12),
                  decoration: InputDecoration(
                    hintText:
                        'Contoh: Laptop merek Asus ROG Core i9 dengan RAM 8',
                    hintStyle: const TextStyle(
                        fontSize: 11, color: Color(0xFFBBBBBB)),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 8),
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide:
                          const BorderSide(color: Color(0xFFDDDDDD)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide:
                          const BorderSide(color: Color(0xFFDDDDDD)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(
                          color: Color(0xFF3998FC), width: 1.5),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

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
                      padding:
                          const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('Tambah Barang',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),
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
        final dA = DateTime.tryParse(
                a['created_at']?.toString() ?? '') ??
            DateTime(2000);
        final dB = DateTime.tryParse(
                b['created_at']?.toString() ?? '') ??
            DateTime(2000);
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
                // ── Table header ──
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 8),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF5F5F5),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(10)),
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
                          flex: 3,
                          child: Text('Ditambahkan\nOleh',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold))),
                      Expanded(
                          flex: 3,
                          child: Text('Ditambahkan\nTanggal',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold))),
                      SizedBox(
                        width: 30,
                        child: Text('Jum',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),

                // ── Rows ──
                if (_isLoading)
                  const Padding(
                    padding: EdgeInsets.all(32),
                    child: Center(
                        child: CircularProgressIndicator(
                            color: Color(0xFF3998FC))),
                  )
                else if (filtered.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(28),
                    child: Center(
                        child: Text('Belum ada data barang',
                            style: TextStyle(color: Colors.grey))),
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
        border: Border(
            bottom: BorderSide(color: Color(0xFFF2F2F2), width: 1)),
      ),
      padding:
          const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      child: Row(
        children: [
          // Nama Barang + icon
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
                  child: const Icon(Icons.devices,
                      size: 13, color: Colors.grey),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(name,
                      style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ),
          // Kategori
          Expanded(
            flex: 2,
            child: Text(catName,
                style: const TextStyle(
                    fontSize: 10, color: Color(0xFF555555)),
                overflow: TextOverflow.ellipsis),
          ),
          // Ditambahkan Oleh
          Expanded(
            flex: 3,
            child: Text(_adminUsername,
                style: const TextStyle(
                    fontSize: 10, color: Color(0xFF555555)),
                overflow: TextOverflow.ellipsis),
          ),
          // Tanggal
          Expanded(
            flex: 3,
            child: Text(date,
                style: const TextStyle(
                    fontSize: 10, color: Color(0xFF555555))),
          ),
          // Jumlah
          SizedBox(
            width: 30,
            child: Text(stock,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 11, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  // LANJUT BUTTON
  // ─────────────────────────────────────────────

  Widget _buildLanjutButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 14, 12, 0),
      child: SizedBox(
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
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
          child: const Text('Lanjut',
              style:
                  TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
