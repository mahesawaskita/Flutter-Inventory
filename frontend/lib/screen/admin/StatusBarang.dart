import 'package:flutter/material.dart';
import 'package:frontend/constants/app_assets.dart';
import 'package:frontend/screen/admin/DetailBarang.dart';
import 'package:frontend/service/api_service.dart';
import 'package:frontend/service/auth_service.dart';

class StatusBarangAdmin extends StatefulWidget {
  const StatusBarangAdmin({super.key});

  @override
  State<StatusBarangAdmin> createState() => _StatusBarangAdminState();
}

class _StatusBarangAdminState extends State<StatusBarangAdmin> {
  static const _blue = Color(0xFF3998FC);
  static const _dark = Color(0xFF1A1A1A);

  final _searchCtrl = TextEditingController();
  List<Map<String, dynamic>> _allItems = [];
  bool _isLoading = true;
  int _activeTab = 0; // 0: Sedang Dipinjam, 1: History

  // ── Computed ──────────────────────────────
  String get _searchQ => _searchCtrl.text.trim().toLowerCase();

  List<Map<String, dynamic>> get _dipinjam => _allItems
      .where((i) => (i['condition'] ?? '').toString().toLowerCase() == 'dipinjam')
      .toList();

  List<Map<String, dynamic>> get _rusak => _allItems.where((i) {
        final c = (i['condition'] ?? '').toString().toLowerCase();
        return c == 'rusak' || c == 'perlu perbaikan';
      }).toList();

  List<Map<String, dynamic>> get _currentList {
    var list = _activeTab == 0 ? _dipinjam : _allItems;
    if (_searchQ.isNotEmpty) {
      list = list
          .where((i) => (i['name'] ?? '').toString().toLowerCase().contains(_searchQ))
          .toList();
    }
    return list;
  }

  int get _statDipinjam => _dipinjam.length;
  int get _statTersedia =>
      _allItems.where((i) => (i['condition'] ?? '') == 'Tersedia').length;
  int get _statRusak => _rusak.length;

  // ── Lifecycle ─────────────────────────────
  @override
  void initState() {
    super.initState();
    _searchCtrl.addListener(() => setState(() {}));
    _loadData();
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      final token = await AuthService.getToken();
      if (token != null) {
        final items = await ApiService.getItems(token);
        if (mounted) {
          setState(() {
            _allItems = items.map((e) => Map<String, dynamic>.from(e)).toList();
          });
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal memuat data: $e'), backgroundColor: Colors.red));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _navigateToDetail(Map<String, dynamic> item) {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => DetailBarangAdmin(item: item)));
  }

  // ── BUILD ──────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _dark,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Dark header ──
            SizedBox(
              height: 60,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.of(context).maybePop(),
                    ),
                  ),
                  Container(
                    width: 66, height: 66,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.grey.shade400),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.15),
                            blurRadius: 6, offset: const Offset(0, 2))
                      ],
                    ),
                    child: Image.asset(AppAssets.stJudul, fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.assessment_outlined, color: Colors.blue)),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Material(
                        color: Colors.grey.shade700,
                        shape: const CircleBorder(),
                        clipBehavior: Clip.antiAlias,
                        child: InkWell(
                          onTap: () {},
                          child: const Padding(padding: EdgeInsets.all(9),
                              child: Icon(Icons.settings_outlined, size: 20, color: Colors.white)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── White panel ──
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFFFFBFB),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
                ),
                clipBehavior: Clip.antiAlias,
                child: RefreshIndicator(
                  onRefresh: _loadData,
                  color: _blue,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Title
                      const Padding(
                        padding: EdgeInsets.fromLTRB(16, 14, 16, 0),
                        child: Text('Status Barang',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Colors.black87)),
                      ),
                      const SizedBox(height: 12),

                      // ── Stats 2×2 ──
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          children: [
                            Expanded(child: _statCard(
                              bg: const Color(0xFFFBE5B3),
                              iconPath: AppAssets.stBarangPinjam,
                              label: 'Total Barang\nDisewakan',
                              value: '$_statDipinjam Dipinjam',
                              sub: '+5 Barang baru',
                              subColor: Colors.green.shade700,
                            )),
                            const SizedBox(width: 8),
                            Expanded(child: _statCard(
                              bg: const Color(0xFFE1EEF9),
                              iconPath: AppAssets.stTotalKembali,
                              label: 'Total Barang\nDikembalikan',
                              value: '$_statTersedia',
                              sub: 'Hari ini $_statTersedia',
                              subColor: Colors.blue.shade700,
                            )),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          children: [
                            Expanded(child: _statCard(
                              bg: const Color(0xFFDCEBF9),
                              iconPath: AppAssets.stTelat,
                              label: 'Terlambat\nDikembalikan',
                              value: '0',
                              sub: '0 telat',
                              subColor: Colors.red,
                            )),
                            const SizedBox(width: 8),
                            Expanded(child: _statCard(
                              bg: const Color(0xFFF1ECF0),
                              iconPath: AppAssets.stTotalRusak,
                              label: 'Total Barang\nRusak',
                              value: '$_statRusak',
                              sub: 'Perlu Perbaikan',
                              subColor: Colors.orange.shade700,
                            )),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),

                      // ── Tab bar ──
                      _buildTabs(),
                      const SizedBox(height: 8),

                      // ── Search + Detail button ──
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 36,
                                child: TextField(
                                  controller: _searchCtrl,
                                  style: const TextStyle(fontSize: 13),
                                  decoration: InputDecoration(
                                    hintText: 'Cari barang, peminjam...',
                                    hintStyle: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                                    prefixIcon: Icon(Icons.search, size: 18, color: Colors.grey.shade500),
                                    suffixIcon: _searchQ.isNotEmpty
                                        ? IconButton(
                                            icon: const Icon(Icons.clear, size: 16),
                                            onPressed: () => _searchCtrl.clear())
                                        : null,
                                    isDense: true,
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(18),
                                      borderSide: BorderSide(color: Colors.grey.shade400),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(18),
                                      borderSide: BorderSide(color: Colors.grey.shade400),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(18),
                                      borderSide: const BorderSide(color: _blue, width: 1.5),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            OutlinedButton(
                              onPressed: _currentList.isNotEmpty
                                  ? () => _navigateToDetail(_currentList.first)
                                  : null,
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                side: BorderSide(color: Colors.grey.shade400),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18)),
                              ),
                              child: const Text('Detail',
                                  style: TextStyle(fontSize: 13, color: Colors.black87,
                                      fontWeight: FontWeight.w700)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),

                      // ── Table header ──
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          children: [
                            Expanded(flex: 3, child: _thCell('Nama Barang')),
                            Expanded(flex: 3, child: _thCell('Peminjam')),
                            Expanded(flex: 3, child: _thCell('Tgl Dipinjam')),
                            Expanded(flex: 2, child: _thCell('Status')),
                          ],
                        ),
                      ),
                      const SizedBox(height: 2),

                      // ── Items list ──
                      Expanded(
                        child: _isLoading
                            ? const Center(child: CircularProgressIndicator(color: _blue))
                            : _currentList.isEmpty
                                ? Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(24),
                                      child: Text(
                                        _activeTab == 0
                                            ? 'Tidak ada barang yang sedang dipinjam'
                                            : 'Belum ada data',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                                    ),
                                  )
                                : ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: _currentList.length,
                                    itemBuilder: (_, i) => _dataRow(_currentList[i]),
                                  ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ── Logo footer ──
            Container(
              color: _dark,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Center(
                child: SizedBox(
                  height: 44, width: 44,
                  child: Image.asset(AppAssets.splash, fit: BoxFit.contain),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── TABS ──────────────────────────────────
  Widget _buildTabs() {
    final tabs = ['Sedang Dipinjam', 'History Penggunaan'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          ...List.generate(tabs.length, (i) {
            final active = i == _activeTab;
            return GestureDetector(
              onTap: () => setState(() => _activeTab = i),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16, bottom: 6),
                    child: Text(tabs[i],
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: active ? FontWeight.w700 : FontWeight.w400,
                            color: active ? _blue : Colors.black54)),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 3,
                    width: active ? 90 : 0,
                    decoration: BoxDecoration(
                        color: _blue, borderRadius: BorderRadius.circular(15)),
                  ),
                ],
              ),
            );
          }),
          const Spacer(),
          GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                const Icon(Icons.filter_list, color: _blue, size: 18),
                const SizedBox(width: 3),
                const Text('Filter',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.black87)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── DATA ROW ──────────────────────────────
  Widget _dataRow(Map<String, dynamic> item) {
    final name = item['name']?.toString() ?? '-';
    final condition = item['condition']?.toString() ?? '-';

    Color statusBg;
    Color statusFg;
    switch (condition.toLowerCase()) {
      case 'dipinjam':
        statusBg = const Color(0xFF57D3C9);
        statusFg = Colors.white;
        break;
      case 'rusak':
      case 'perlu perbaikan':
        statusBg = const Color(0xFFFE6F51);
        statusFg = Colors.white;
        break;
      case 'tersedia':
        statusBg = const Color(0xFF4CAF50);
        statusFg = Colors.white;
        break;
      default:
        statusBg = Colors.grey.shade300;
        statusFg = Colors.black87;
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Nama Barang — clickable
          Expanded(
            flex: 3,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => _navigateToDetail(item),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
                child: Row(
                  children: [
                    Container(
                      width: 34, height: 34,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(6)),
                      child: const Icon(Icons.inventory_2_outlined, size: 18, color: Colors.grey),
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(name,
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: _blue,
                              decoration: TextDecoration.underline),
                          overflow: TextOverflow.ellipsis),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Peminjam
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text('-',
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
            ),
          ),

          // Tanggal Dipinjam
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text('-',
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
            ),
          ),

          // Status
          Expanded(
            flex: 2,
            child: Center(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                decoration: BoxDecoration(
                    color: statusBg, borderRadius: BorderRadius.circular(4)),
                child: Text(condition,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w700,
                        color: statusFg)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── HELPERS ───────────────────────────────
  Widget _statCard({
    required Color bg,
    required String iconPath,
    required String label,
    required String value,
    required String sub,
    required Color subColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFB0A0A0), width: 1.5),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 3)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              SizedBox(
                width: 34, height: 34,
                child: Image.asset(iconPath, fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.assessment_outlined, color: Colors.blue, size: 24)),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(label,
                    style: const TextStyle(
                        fontSize: 9, fontWeight: FontWeight.w600, height: 1.3)),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(value,
              style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w800, color: Colors.black87)),
          const SizedBox(height: 2),
          Text(sub,
              style: TextStyle(
                  fontSize: 9, color: subColor, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _thCell(String text) => Center(
        child: Text(text,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade800)),
      );
}
