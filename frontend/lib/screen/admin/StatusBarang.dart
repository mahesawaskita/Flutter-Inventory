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
  List<Map<String, dynamic>> _allLoans = [];
  bool _isLoading = true;
  int _activeTab = 0; // 0: Sedang Dipinjam, 1: History

  // ── Computed ──────────────────────────────
  String get _searchQ => _searchCtrl.text.trim().toLowerCase();

  List<Map<String, dynamic>> get _borrowedLoans =>
      _allLoans.where((l) => l['status'] == 'borrowed').toList();

  List<Map<String, dynamic>> get _currentList {
    if (_activeTab == 0) {
      var list = _borrowedLoans;
      if (_searchQ.isNotEmpty) {
        list = list.where((l) =>
            (l['item_name'] ?? '').toString().toLowerCase().contains(_searchQ) ||
            (l['username'] ?? '').toString().toLowerCase().contains(_searchQ)).toList();
      }
      return list;
    } else {
      var list = _allLoans.where((l) => l['status'] == 'returned').toList();
      if (_searchQ.isNotEmpty) {
        list = list.where((l) =>
            (l['item_name'] ?? '').toString().toLowerCase().contains(_searchQ)).toList();
      }
      return list;
    }
  }

  int get _statDipinjam => _borrowedLoans.length;
  int get _statTersedia =>
      _allItems.where((i) => (i['status'] ?? '') == 'available').length;
  int get _statRusak =>
      _allItems.where((i) => (i['condition'] ?? '') == 'damaged').length;
  int get _statDikembalikan => _allLoans.where((l) => l['status'] == 'returned').length;
  int get _statTerlambat {
    final now = DateTime.now();
    return _borrowedLoans.where((l) {
      try {
        return DateTime.parse(l['due_date'].toString()).isBefore(now);
      } catch (_) {
        return false;
      }
    }).length;
  }

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
        final loans = await ApiService.getAllLoans(token);
        if (mounted) {
          setState(() {
            _allItems = items.map((e) => Map<String, dynamic>.from(e)).toList();
            _allLoans = loans.map((e) => Map<String, dynamic>.from(e)).toList();
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

  String _fmtDate(String? s) {
    if (s == null) return '-';
    try {
      final d = DateTime.parse(s);
      const m = ['Jan','Feb','Mar','Apr','Mei','Jun','Jul','Agu','Sep','Okt','Nov','Des'];
      return '${d.day} ${m[d.month - 1]} ${d.year}';
    } catch (_) {
      return s;
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
                              value: '$_statDikembalikan',
                              sub: '$_statTersedia tersedia',
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
                              value: '$_statTerlambat',
                              sub: '$_statTerlambat telat',
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
                              onPressed: (_activeTab == 0 && _currentList.isNotEmpty)
                                  ? () {
                                      final loan = _currentList.first;
                                      final itemId = loan['item_id']?.toString();
                                      Map<String, dynamic>? item;
                                      if (itemId != null) {
                                        try {
                                          item = _allItems.firstWhere(
                                              (i) => i['id']?.toString() == itemId);
                                        } catch (_) {}
                                      }
                                      if (item != null) _navigateToDetail(item);
                                    }
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
                                            : 'Belum ada riwayat pengembalian',
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
  Widget _dataRow(Map<String, dynamic> row) {
    // Both tabs use borrowing records
    final isHistoryTab = _activeTab == 1;

    final name = row['item_name']?.toString() ?? '-';
    final borrower = row['username']?.toString() ?? '-';
    final tanggal = _fmtDate(row['borrow_date']?.toString());

    String statusText;
    Color statusBg;
    Color statusFg;

    if (isHistoryTab) {
      statusText = 'Kembali';
      statusBg = const Color(0xFF57D3C9);
      statusFg = Colors.white;
    } else {
      bool late = false;
      try {
        final due = row['due_date']?.toString();
        if (due != null) late = DateTime.parse(due).isBefore(DateTime.now());
      } catch (_) {}
      if (late) {
        statusText = 'Terlambat';
        statusBg = const Color(0xFFFE6F51);
        statusFg = Colors.white;
      } else {
        statusText = 'Dipinjam';
        statusBg = const Color(0xFF57D3C9);
        statusFg = Colors.white;
      }
    }

    // Find item for detail navigation
    Map<String, dynamic>? itemForNav;
    if (_activeTab == 0) {
      final itemId = row['item_id']?.toString();
      if (itemId != null) {
        try {
          itemForNav = _allItems.firstWhere(
              (i) => i['id']?.toString() == itemId);
        } catch (_) {}
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Nama Barang — clickable (hanya tab 0)
          Expanded(
            flex: 3,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: itemForNav != null ? () => _navigateToDetail(itemForNav!) : null,
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
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: itemForNav != null ? _blue : Colors.black87,
                              decoration: itemForNav != null ? TextDecoration.underline : null),
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
              child: Text(
                borrower,
                style: TextStyle(
                  fontSize: 11,
                  color: borrower == '-' ? Colors.grey.shade400 : Colors.black87,
                  fontWeight: borrower == '-' ? FontWeight.normal : FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),

          // Tanggal Dipinjam
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                tanggal,
                style: TextStyle(fontSize: 10, color: tanggal == '-' ? Colors.grey.shade400 : Colors.black87),
              ),
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
                child: Text(statusText,
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
