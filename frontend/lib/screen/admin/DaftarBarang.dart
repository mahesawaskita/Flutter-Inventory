import 'package:flutter/material.dart';
import 'package:frontend/constants/app_assets.dart';
import 'package:frontend/screen/admin/EditBarang.dart';
import 'package:frontend/service/api_service.dart';
import 'package:frontend/service/auth_service.dart';

class DaftarBarangPage extends StatefulWidget {
  const DaftarBarangPage({super.key});

  @override
  State<DaftarBarangPage> createState() => _DaftarBarangPageState();
}

class _DaftarBarangPageState extends State<DaftarBarangPage> {
  // ── Constants ──────────────────────────────
  static const _darkBg    = Color(0xFF1A1A1A);
  static const _panelBg   = Color(0xFFF7F7F7);
  static const _blue      = Color(0xFF1976D2);
  static const _amberDark = Color(0xFFF9A825);
  static const _red       = Color(0xFFE53935);
  static const int _pageSize = 10;

  // ── State ──────────────────────────────────
  final _searchCtrl = TextEditingController();

  List<Map<String, dynamic>> _allItems      = [];
  List<Map<String, dynamic>> _categories    = [];
  bool _isLoading   = true;
  bool _sortAsc     = true;         // true = stok naik, false = stok turun
  String? _filterStatus;            // null = semua, 'tersedia'/'hampirHabis'/'habis'
  int _activeCatTab = 0;            // 0 = Semua, 1+ = kategori ke-N
  int _currentPage  = 1;

  // ── Computed ───────────────────────────────
  String get _searchQuery => _searchCtrl.text.trim().toLowerCase();

  List<Map<String, dynamic>> get _filtered {
    var list = List<Map<String, dynamic>>.from(_allItems);

    // Filter kategori
    if (_activeCatTab > 0 && _activeCatTab <= _categories.length) {
      final catId = _categories[_activeCatTab - 1]['id'];
      list = list
          .where((i) => i['category_id']?.toString() == catId.toString())
          .toList();
    }

    // Filter pencarian
    if (_searchQuery.isNotEmpty) {
      list = list
          .where((i) =>
              (i['name'] ?? '').toString().toLowerCase().contains(_searchQuery))
          .toList();
    }

    // Filter status
    if (_filterStatus != null) {
      list = list.where((i) {
        final s = _itemStatus(i);
        return s.name == _filterStatus;
      }).toList();
    }

    // Sortir stok
    list.sort((a, b) {
      final sa = (a['stock'] as int? ?? 0);
      final sb = (b['stock'] as int? ?? 0);
      return _sortAsc ? sa.compareTo(sb) : sb.compareTo(sa);
    });

    return list;
  }

  List<Map<String, dynamic>> get _page {
    final all = _filtered;
    final start = (_currentPage - 1) * _pageSize;
    if (start >= all.length) return [];
    final end = (start + _pageSize).clamp(0, all.length);
    return all.sublist(start, end);
  }

  int get _totalPages => (_filtered.length / _pageSize).ceil().clamp(1, 9999);

  // Stats
  int get _statTotal       => _allItems.length;
  int get _statHampirHabis =>
      _allItems.where((i) {
        final s = _itemStatus(i);
        return s == _RowStatus.hampirHabis;
      }).length;
  int get _statHabis =>
      _allItems.where((i) => _itemStatus(i) == _RowStatus.habis).length;

  // ── Helpers ────────────────────────────────
  _RowStatus _itemStatus(Map<String, dynamic> item) {
    final stock = item['stock'] as int? ?? 0;
    if (stock == 0) return _RowStatus.habis;
    if (stock <= 5) return _RowStatus.hampirHabis;
    return _RowStatus.tersedia;
  }

  String _categoryName(dynamic catId) {
    if (catId == null) return '-';
    return _categories
        .firstWhere(
          (c) => c['id'].toString() == catId.toString(),
          orElse: () => {'name': '-'},
        )['name']
        ?.toString() ?? '-';
  }

  Color _catBg(String catName) {
    if (catName == 'Aksesoris') return const Color(0xFFFFF9C4);
    final colors = [
      const Color(0xFFE3F2FD),
      const Color(0xFFE8F5E9),
      const Color(0xFFF3E5F5),
      const Color(0xFFFFECB3),
      const Color(0xFFE0F7FA),
    ];
    return colors[catName.hashCode.abs() % colors.length];
  }

  Color _catFg(String catName) {
    if (catName == 'Aksesoris') return const Color(0xFFF57F17);
    final colors = [
      _blue,
      const Color(0xFF2E7D32),
      const Color(0xFF6A1B9A),
      const Color(0xFFE65100),
      const Color(0xFF00695C),
    ];
    return colors[catName.hashCode.abs() % colors.length];
  }

  Widget _asset(String path, {double? w, double? h}) {
    return Image.asset(
      path, width: w, height: h, fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => Icon(Icons.inventory_2_outlined,
          size: (w ?? 24) * 0.7, color: Colors.grey),
    );
  }

  // ── Lifecycle ──────────────────────────────
  @override
  void initState() {
    super.initState();
    _searchCtrl.addListener(() => setState(() => _currentPage = 1));
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
        final cats  = await ApiService.getCategories(token);
        if (mounted) {
          setState(() {
            _allItems   = items.map((e) => Map<String, dynamic>.from(e)).toList();
            _categories = cats.map((e) => Map<String, dynamic>.from(e)).toList();
            _currentPage = 1;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal memuat data: $e'),
              backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _deleteItem(Map<String, dynamic> item) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus Barang'),
        content: Text(
            'Yakin ingin menghapus "${item['name']}"?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Batal')),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(backgroundColor: _red),
            child: const Text('Hapus',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    final token = await AuthService.getToken();
    if (token == null) return;

    final ok = await ApiService.deleteItem(token, item['id'] as int);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(ok ? '${item['name']} berhasil dihapus' : 'Gagal menghapus'),
        backgroundColor: ok ? Colors.green : Colors.red,
      ));
      if (ok) _loadData();
    }
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (_) {
        final options = <String?>[null, 'tersedia', 'hampirHabis', 'habis'];
        final labels  = ['Semua Status', 'Tersedia', 'Hampir Habis', 'Habis'];
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Text('Filter Status',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              ),
              ...List.generate(options.length, (i) => ListTile(
                title: Text(labels[i]),
                trailing: _filterStatus == options[i]
                    ? const Icon(Icons.check, color: _blue)
                    : null,
                onTap: () {
                  setState(() {
                    _filterStatus = options[i];
                    _currentPage = 1;
                  });
                  Navigator.pop(context);
                },
              )),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  void _showAddCategoryDialog() {
    final ctrl = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Tambah Kategori'),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
              hintText: 'Nama kategori', border: OutlineInputBorder()),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Batal')),
          ElevatedButton(
            onPressed: () async {
              final name = ctrl.text.trim();
              if (name.isEmpty) return;
              final token = await AuthService.getToken();
              if (token == null) return;
              final ok = await ApiService.createCategory(token, name);
              if (!ctx.mounted) return;
              Navigator.pop(ctx);
              if (ok) _loadData();
            },
            style: ElevatedButton.styleFrom(backgroundColor: _blue),
            child: const Text('Simpan', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // ── BUILD ──────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _darkBg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Top bar: back + judul icon ──
            SizedBox(
              height: 56,
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
                    width: 68,
                    height: 68,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.grey.shade400),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.12),
                            blurRadius: 6,
                            offset: const Offset(0, 2)),
                      ],
                    ),
                    child: _asset(AppAssets.dfJudul, w: 52, h: 52),
                  ),
                ],
              ),
            ),

            // ── Panel putih ──
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: _panelBg,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(28)),
                ),
                clipBehavior: Clip.antiAlias,
                child: RefreshIndicator(
                  onRefresh: _loadData,
                  color: _blue,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Title + settings
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 18, 12, 0),
                        child: Row(
                          children: [
                            const SizedBox(width: 40),
                            const Expanded(
                              child: Text('Daftar Barang',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black87)),
                            ),
                            Material(
                              color: Colors.grey.shade300,
                              shape: const CircleBorder(),
                              clipBehavior: Clip.antiAlias,
                              child: InkWell(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Icon(Icons.settings_outlined,
                                      size: 22, color: Colors.grey.shade700),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 14),

                      // ── Stats cards ──
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: _summaryCard(
                                  borderColor: _blue,
                                  subtitleColor: const Color(0xFF64B5F6),
                                  title: 'Total Barang',
                                  value: _statTotal.toString(),
                                  subtitle: '+55 sejak minggu lalu',
                                  asset: AppAssets.dfTotal,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: _summaryCard(
                                  borderColor: _amberDark,
                                  subtitleColor: _amberDark,
                                  title: 'Barang Hampir Habis',
                                  value: _statHampirHabis.toString(),
                                  subtitle: '3 minggu lalu',
                                  asset: AppAssets.dfHampirHabis,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: _summaryCard(
                                  borderColor: _red,
                                  subtitleColor: _red,
                                  title: 'Barang Habis',
                                  value: _statHabis.toString(),
                                  subtitle: '2 minggu lalu',
                                  asset: AppAssets.dfBarangHabis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // ── Category tabs ──
                      _buildCategoryTabs(),

                      const SizedBox(height: 10),

                      // ── Search + Filter + Sortir ──
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _searchCtrl,
                                style: const TextStyle(fontSize: 13),
                                decoration: InputDecoration(
                                  hintText: 'Cari nama barang...',
                                  hintStyle: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontSize: 13),
                                  prefixIcon: Icon(Icons.search,
                                      color: Colors.grey.shade600, size: 20),
                                  suffixIcon: _searchQuery.isNotEmpty
                                      ? IconButton(
                                          icon: const Icon(Icons.clear,
                                              size: 18),
                                          onPressed: () =>
                                              _searchCtrl.clear(),
                                        )
                                      : null,
                                  isDense: true,
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 10),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(24),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade300)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(24),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade300)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(24),
                                      borderSide:
                                          const BorderSide(color: _blue)),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            _pillAction(
                              label: _filterStatus == null
                                  ? 'Filter'
                                  : 'Filter ✓',
                              icon: Icons.filter_list_rounded,
                              active: _filterStatus != null,
                              onTap: _showFilterDialog,
                            ),
                            const SizedBox(width: 6),
                            _pillAction(
                              label: _sortAsc ? 'Sortir ↑' : 'Sortir ↓',
                              icon: Icons.sort_rounded,
                              onTap: () => setState(() {
                                _sortAsc = !_sortAsc;
                                _currentPage = 1;
                              }),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 10),

                      // ── Table header ──
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 9, horizontal: 4),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Expanded(flex: 22, child: _headerCell('Nama Barang')),
                              Expanded(flex: 14, child: _headerCell('Kategori')),
                              Expanded(
                                  flex: 10,
                                  child: _headerCell('Stok',
                                      trailing: _sortAsc ? ' ↑' : ' ↓')),
                              Expanded(flex: 16, child: _headerCell('Status')),
                              Expanded(flex: 14, child: _headerCell('Tindakan')),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 6),

                      // ── List / empty / loading ──
                      Expanded(
                        child: _isLoading
                            ? const Center(
                                child: CircularProgressIndicator(color: _blue))
                            : _page.isEmpty
                                ? Center(
                                    child: Text(
                                      _searchQuery.isNotEmpty
                                          ? 'Tidak ada hasil untuk "$_searchQuery"'
                                          : 'Belum ada barang',
                                      style: TextStyle(color: Colors.grey.shade600),
                                    ),
                                  )
                                : ListView.separated(
                                    padding: const EdgeInsets.fromLTRB(
                                        16, 0, 16, 8),
                                    itemCount: _page.length,
                                    separatorBuilder: (_, __) =>
                                        const SizedBox(height: 8),
                                    itemBuilder: (_, i) =>
                                        _dataRow(_page[i]),
                                  ),
                      ),

                      // ── Pagination ──
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Menampilkan ${_page.length} dari '
                                '${_filtered.length} barang',
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey.shade700),
                              ),
                            ),
                            _pageNavBtn(
                              icon: Icons.chevron_left,
                              onTap: _currentPage > 1
                                  ? () => setState(() => _currentPage--)
                                  : null,
                            ),
                            ...List.generate(
                              _totalPages.clamp(0, 5),
                              (i) => _pageNum('${i + 1}',
                                  active: i + 1 == _currentPage,
                                  onTap: () =>
                                      setState(() => _currentPage = i + 1)),
                            ),
                            if (_totalPages > 5) ...[
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 3),
                                child: Text('...',
                                    style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontWeight: FontWeight.w600)),
                              ),
                              _pageNum('$_totalPages',
                                  active: _currentPage == _totalPages,
                                  onTap: () => setState(
                                      () => _currentPage = _totalPages)),
                            ],
                            _pageNavBtn(
                              icon: Icons.chevron_right,
                              onTap: _currentPage < _totalPages
                                  ? () => setState(() => _currentPage++)
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ── Logo ──
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 10),
              child: Center(
                child: SizedBox(
                  height: 48,
                  width: 48,
                  child: Image.asset(AppAssets.splash, fit: BoxFit.contain),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── CATEGORY TABS ──────────────────────────
  Widget _buildCategoryTabs() {
    // tabs: Semua | cat1 | cat2 | ... | + Tambah Kategori | ...
    final tabs = ['Semua', ..._categories.map((c) => c['name'].toString())];

    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: tabs.length + 2, // +2: tambah kategori + more
        separatorBuilder: (_, __) => const SizedBox(width: 4),
        itemBuilder: (context, i) {
          // "..." more button
          if (i == tabs.length + 1) {
            return IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
              icon: Icon(Icons.more_horiz, color: Colors.grey.shade700),
              onPressed: () {},
            );
          }
          // "+ Tambah Kategori"
          if (i == tabs.length) {
            return GestureDetector(
              onTap: _showAddCategoryDialog,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('+ Tambah Kategori',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: _blue)),
                    const SizedBox(height: 6),
                    const SizedBox(height: 3),
                  ],
                ),
              ),
            );
          }
          // Normal tabs
          final active = i == _activeCatTab;
          return GestureDetector(
            onTap: () => setState(() {
              _activeCatTab = i;
              _currentPage = 1;
            }),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    tabs[i],
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight:
                            active ? FontWeight.w700 : FontWeight.w500,
                        color: active
                            ? Colors.black87
                            : Colors.grey.shade600),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    height: 3,
                    width: active ? 36 : 0,
                    decoration: BoxDecoration(
                        color: _blue,
                        borderRadius: BorderRadius.circular(2)),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ── DATA ROW ───────────────────────────────
  Widget _dataRow(Map<String, dynamic> item) {
    final name    = item['name']?.toString() ?? '-';
    final catName = _categoryName(item['category_id']);
    final stock   = item['stock'] as int? ?? 0;
    final status  = _itemStatus(item);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 1)),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Nama Barang
          Expanded(
            flex: 22,
            child: Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8)),
                  child: const Icon(Icons.inventory_2_outlined,
                      size: 20, color: Colors.grey),
                ),
                const SizedBox(width: 6),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name,
                          style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                              color: Colors.black87),
                          overflow: TextOverflow.ellipsis),
                      GestureDetector(
                        onTap: () => _showItemDetail(item),
                        child: Text('Informasi',
                            style: TextStyle(
                                fontSize: 10,
                                color: _blue,
                                decoration: TextDecoration.underline)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Kategori
          Expanded(
            flex: 14,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                    color: _catBg(catName),
                    borderRadius: BorderRadius.circular(8)),
                child: Text(catName,
                    style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        color: _catFg(catName)),
                    overflow: TextOverflow.ellipsis),
              ),
            ),
          ),

          // Stok
          Expanded(
            flex: 10,
            child: Center(
              child: Text('$stock',
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 13)),
            ),
          ),

          // Status
          Expanded(
            flex: 16,
            child: Center(child: _statusBadge(status, stock)),
          ),

          // Tindakan
          Expanded(
            flex: 14,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Edit
                Material(
                  color: _blue,
                  shape: const CircleBorder(),
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EditBarangAdmin(item: item),
                        ),
                      );
                      _loadData(); // refresh setelah edit
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(Icons.edit_outlined,
                          size: 15, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                // Delete
                Material(
                  color: _red,
                  shape: const CircleBorder(),
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () => _deleteItem(item),
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(Icons.delete_outline,
                          size: 15, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showItemDetail(Map<String, dynamic> item) {
    final catName = _categoryName(item['category_id']);
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item['name']?.toString() ?? '-',
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold)),
            const Divider(height: 20),
            _detailRow('Kategori', catName),
            _detailRow('Stok', '${item['stock'] ?? 0}'),
            _detailRow('Kondisi', item['condition']?.toString() ?? '-'),
            _detailRow('Harga',
                'Rp ${(item['price'] ?? 0).toString()}'),
            _detailRow('Deskripsi',
                item['description']?.toString().isNotEmpty == true
                    ? item['description'].toString()
                    : '-'),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 90,
              child: Text(label,
                  style: TextStyle(
                      fontSize: 13, color: Colors.grey.shade600)),
            ),
            const Text(': '),
            Expanded(
              child: Text(value,
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w500)),
            ),
          ],
        ),
      );

  // ── STATUS BADGE ───────────────────────────
  Widget _statusBadge(_RowStatus status, int stock) {
    switch (status) {
      case _RowStatus.tersedia:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
          decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFF43A047))),
          child: const Text('Tersedia',
              style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2E7D32))),
        );
      case _RowStatus.hampirHabis:
        final maxStock = 5;
        final pct = stock / maxStock;
        return SizedBox(
          width: 82,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                    color: const Color(0xFFFFF8E1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: _amberDark)),
                child: const Text('Hampir Habis',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFE65100))),
              ),
              const SizedBox(height: 3),
              ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: LinearProgressIndicator(
                  value: pct.clamp(0, 1).toDouble(),
                  minHeight: 4,
                  backgroundColor: Colors.grey.shade300,
                  color: _amberDark,
                ),
              ),
              const SizedBox(height: 2),
              Text('${(pct * 100).round()}%',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 9,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w600)),
            ],
          ),
        );
      case _RowStatus.habis:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
          decoration: BoxDecoration(
              color: const Color(0xFFFFEBEE),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _red)),
          child: const Text('Habis',
              style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFC62828))),
        );
    }
  }

  // ── HELPERS ────────────────────────────────
  Widget _headerCell(String text, {String trailing = ''}) => Center(
        child: Text('$text$trailing',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade800)),
      );

  Widget _summaryCard({
    required Color borderColor,
    required Color subtitleColor,
    required String title,
    required String value,
    required String subtitle,
    required String asset,
  }) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: 2),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 4,
              offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 28, child: _asset(asset, w: 28, h: 28)),
          const SizedBox(height: 4),
          Text(title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 10,
                  height: 1.2,
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.w500)),
          const SizedBox(height: 2),
          Text(value,
              style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87)),
          const SizedBox(height: 2),
          Text(subtitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 9,
                  color: subtitleColor,
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _pillAction({
    required String label,
    required IconData icon,
    VoidCallback? onTap,
    bool active = false,
  }) {
    return Material(
      color: active ? _blue.withOpacity(0.1) : Colors.white,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 9),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
                color: active ? _blue : Colors.grey.shade300),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon,
                  size: 16,
                  color: active ? _blue : Colors.grey.shade800),
              const SizedBox(width: 4),
              Text(label,
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: active ? _blue : Colors.black87)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _pageNavBtn({required IconData icon, VoidCallback? onTap}) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Material(
          color: onTap != null ? Colors.grey.shade200 : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(6),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(6),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Icon(icon,
                  size: 18,
                  color: onTap != null
                      ? Colors.grey.shade800
                      : Colors.grey.shade400),
            ),
          ),
        ),
      );

  Widget _pageNum(String n, {bool active = false, VoidCallback? onTap}) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Material(
          color: active ? Colors.white : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(6),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(6),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                    color: active ? _blue : Colors.transparent, width: 2),
              ),
              child: Text(n,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      color: active ? _blue : Colors.black87)),
            ),
          ),
        ),
      );
}

enum _RowStatus { tersedia, hampirHabis, habis }
