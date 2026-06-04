import 'package:flutter/material.dart';
import 'package:frontend/screen/user/peminjaman_barang_user.dart';
import 'package:frontend/service/api_service.dart';
import 'package:frontend/service/auth_service.dart';

class DaftarBarangUserScreen extends StatefulWidget {
  const DaftarBarangUserScreen({super.key});

  @override
  State<DaftarBarangUserScreen> createState() => _DaftarBarangUserScreenState();
}

class _DaftarBarangUserScreenState extends State<DaftarBarangUserScreen> {
  List<Map<String, dynamic>> _allItems = [];
  List<Map<String, dynamic>> _categories = [];
  bool _isLoading = true;
  String _search = '';
  int _activeCat = 0;

  static const _bg = Color(0xFF0D1117);
  static const _purple = Color(0xFF8A20F7);
  static const _blue = Color(0xFF4A6CF7);
  static const _green = Color(0xFF10B981);
  static const _orange = Color(0xFFF97316);
  static const _red = Color(0xFFEF4444);

  List<Map<String, dynamic>> get _filtered {
    var list = List<Map<String, dynamic>>.from(_allItems);
    if (_activeCat > 0 && _activeCat <= _categories.length) {
      final catId = _categories[_activeCat - 1]['id'];
      list = list.where((i) => i['category_id']?.toString() == catId.toString()).toList();
    }
    if (_search.isNotEmpty) {
      list = list.where((i) => (i['name'] ?? '').toString().toLowerCase().contains(_search)).toList();
    }
    return list;
  }

  int get _statTersedia => _allItems.where((i) => (i['stock'] as int? ?? 0) > 5).length;
  int get _statHampirHabis => _allItems.where((i) {
        final s = i['stock'] as int? ?? 0;
        return s > 0 && s <= 5;
      }).length;
  int get _statHabis => _allItems.where((i) => (i['stock'] as int? ?? 0) == 0).length;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      final token = await AuthService.getToken();
      if (token != null) {
        final items = await ApiService.getItems(token);
        final cats = await ApiService.getCategories(token);
        if (mounted) {
          setState(() {
            _allItems = items.map((e) => Map<String, dynamic>.from(e)).toList();
            _categories = cats.map((e) => Map<String, dynamic>.from(e)).toList();
          });
        }
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  String _statusLabel(Map<String, dynamic> item) {
    switch (item['status']?.toString() ?? 'available') {
      case 'available': return 'Tersedia';
      case 'borrowed': return 'Dipinjam';
      case 'reserved': return 'Direservasi';
      case 'inactive': return 'Tidak Aktif';
      default: return item['status']?.toString() ?? '-';
    }
  }

  Color _statusColor(Map<String, dynamic> item) {
    switch (item['status']?.toString() ?? 'available') {
      case 'available': return _green;
      case 'borrowed': return _orange;
      case 'reserved': return _blue;
      case 'inactive': return Colors.grey;
      default: return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cats = ['Semua', ..._categories.map((c) => c['name'].toString())];

    return Scaffold(
      backgroundColor: _bg,
      body: RefreshIndicator(
        onRefresh: _loadData,
        color: _purple,
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

                      // ── Header ────────────────────────────────────────────
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.maybePop(context),
                            child: Container(
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.08),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
                              ),
                              child: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 20),
                            ),
                          ),
                          const Spacer(),
                          const Text(
                            'Daftar Barang',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          const Spacer(),
                          const SizedBox(width: 38),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // ── Stats ─────────────────────────────────────────────
                      IntrinsicHeight(
                       child: Row(
                        children: [
                          Expanded(child: _StatCard(
                            label: 'Tersedia',
                            value: _isLoading ? null : _statTersedia,
                            icon: Icons.inventory_2_rounded,
                            color: _green,
                          )),
                          const SizedBox(width: 12),
                          Expanded(child: _StatCard(
                            label: 'Hampir\nHabis',
                            value: _isLoading ? null : _statHampirHabis,
                            icon: Icons.bolt_rounded,
                            color: _orange,
                            highlight: !_isLoading && _statHampirHabis > 0,
                          )),
                          const SizedBox(width: 12),
                          Expanded(child: _StatCard(
                            label: 'Stok\nHabis',
                            value: _isLoading ? null : _statHabis,
                            icon: Icons.warning_amber_rounded,
                            color: _red,
                            highlight: !_isLoading && _statHabis > 0,
                          )),
                        ],
                      ),
                      ),

                      const SizedBox(height: 20),

                      // ── Category filter chips ──────────────────────────────
                      SizedBox(
                        height: 36,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: cats.length,
                          separatorBuilder: (_, __) => const SizedBox(width: 8),
                          itemBuilder: (_, i) {
                            final active = i == _activeCat;
                            return GestureDetector(
                              onTap: () => setState(() => _activeCat = i),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                decoration: BoxDecoration(
                                  color: active ? _blue : Colors.white.withValues(alpha: 0.08),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: active ? _blue : Colors.white.withValues(alpha: 0.15),
                                  ),
                                  boxShadow: active
                                      ? [BoxShadow(color: _blue.withValues(alpha: 0.4), blurRadius: 8, offset: const Offset(0, 2))]
                                      : null,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  cats[i],
                                  style: TextStyle(
                                    color: active ? Colors.white : Colors.white60,
                                    fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 16),

                      // ── Search ────────────────────────────────────────────
                      Container(
                        height: 46,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.search_rounded, size: 20, color: Colors.white.withValues(alpha: 0.45)),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                style: const TextStyle(fontSize: 13, color: Colors.white),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  isDense: true,
                                  hintText: 'Cari nama barang...',
                                  hintStyle: TextStyle(fontSize: 13, color: Colors.white.withValues(alpha: 0.35)),
                                ),
                                onChanged: (v) => setState(() => _search = v.trim().toLowerCase()),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // ── Section label ─────────────────────────────────────
                      Row(
                        children: [
                          const Text(
                            'Semua Barang',
                            style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          if (!_isLoading)
                            Text(
                              '${_filtered.length} barang',
                              style: TextStyle(color: Colors.white.withValues(alpha: 0.45), fontSize: 12),
                            ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // ── Items list ────────────────────────────────────────
                      if (_isLoading)
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(32),
                            child: CircularProgressIndicator(color: _purple),
                          ),
                        )
                      else if (_filtered.isEmpty)
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 32),
                            child: Column(
                              children: [
                                Icon(Icons.inventory_2_outlined, size: 52, color: Colors.white.withValues(alpha: 0.25)),
                                const SizedBox(height: 12),
                                Text(
                                  _search.isNotEmpty
                                      ? 'Tidak ada hasil untuk "$_search"'
                                      : 'Belum ada barang',
                                  style: TextStyle(color: Colors.white.withValues(alpha: 0.45), fontSize: 13),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        )
                      else
                        ..._filtered.map((item) {
                          final name = item['name']?.toString() ?? '-';
                          final cat = item['category_name']?.toString() ?? '-';
                          final stock = item['stock'] as int? ?? 0;
                          final statusLabel = _statusLabel(item);
                          final condColor = _statusColor(item);
                          final canBorrow = (item['status']?.toString() ?? '') == 'available' && stock > 0;

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: _ItemCard(
                              name: name,
                              category: cat,
                              stock: stock,
                              statusLabel: statusLabel,
                              statusColor: condColor,
                              canBorrow: canBorrow,
                              onBorrow: () => Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) =>
                                    PeminjamanBarangUserScreen(selectedItem: item)),
                              ),
                            ),
                          );
                        }),

                      const SizedBox(height: 16),

                      // ── Pinjam Barang button ──────────────────────────────
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const PeminjamanBarangUserScreen()),
                        ),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: _purple,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [BoxShadow(color: _purple.withValues(alpha: 0.4), blurRadius: 14, offset: const Offset(0, 5))],
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                right: -10,
                                top: -10,
                                child: Icon(Icons.swap_horiz_rounded, size: 90, color: Colors.white.withValues(alpha: 0.1)),
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
                                    child: const Icon(Icons.swap_horiz_rounded, color: Colors.white, size: 26),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Pinjam Barang',
                                          style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          'Ajukan peminjaman barang baru',
                                          style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 11),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Buka',
                                        style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 11, fontWeight: FontWeight.w600),
                                      ),
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

// ── Stat card ─────────────────────────────────────────────────────────────────

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
      padding: const EdgeInsets.fromLTRB(12, 14, 8, 14),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: color.withValues(alpha: 0.35), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -4,
            bottom: -8,
            child: Icon(icon, size: 52, color: Colors.white.withValues(alpha: 0.18)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              value == null
                  ? const SizedBox(
                      width: 20, height: 20,
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '$value',
                          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white, height: 1),
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
                style: TextStyle(fontSize: 9, color: Colors.white.withValues(alpha: 0.8), height: 1.3),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Item card ─────────────────────────────────────────────────────────────────

class _ItemCard extends StatelessWidget {
  const _ItemCard({
    required this.name,
    required this.category,
    required this.stock,
    required this.statusLabel,
    required this.statusColor,
    required this.canBorrow,
    required this.onBorrow,
  });

  final String name;
  final String category;
  final int stock;
  final String statusLabel;
  final Color statusColor;
  final bool canBorrow;
  final VoidCallback onBorrow;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.inventory_2_rounded, color: statusColor, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
                ),
                const SizedBox(height: 2),
                Text(
                  category,
                  style: TextStyle(fontSize: 11, color: Colors.white.withValues(alpha: 0.5)),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.layers_rounded, size: 12, color: Colors.white.withValues(alpha: 0.4)),
                    const SizedBox(width: 4),
                    Text(
                      'Stok: $stock',
                      style: TextStyle(fontSize: 11, color: Colors.white.withValues(alpha: 0.5)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: statusColor.withValues(alpha: 0.4)),
                ),
                child: Text(
                  statusLabel,
                  style: TextStyle(color: statusColor, fontSize: 10, fontWeight: FontWeight.w700),
                ),
              ),
              if (canBorrow) ...[
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: onBorrow,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4A6CF7),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [BoxShadow(color: const Color(0xFF4A6CF7).withValues(alpha: 0.4), blurRadius: 8, offset: const Offset(0, 3))],
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Pinjam', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700)),
                        SizedBox(width: 4),
                        Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 11),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
