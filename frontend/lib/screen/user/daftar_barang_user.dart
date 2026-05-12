import 'package:flutter/material.dart';
import 'package:frontend/screen/user/peminjaman_barang_user.dart';
import 'package:frontend/service/api_service.dart';
import 'package:frontend/service/auth_service.dart';

import 'user_ui.dart';

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
  int _activeCat = 0; // 0 = Semua

  // ── Computed ──────────────────────────────────────────────
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

  Color _conditionColor(String condition) {
    switch (condition.toLowerCase()) {
      case 'tersedia':
        return const Color(0xFF74D294);
      case 'dipinjam':
        return const Color(0xFFF0D48A);
      case 'rusak':
      case 'perlu perbaikan':
        return const Color(0xFFFA7B6F);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cats = ['Semua', ..._categories.map((c) => c['name'].toString())];

    return UserPageScaffold(
      child: UserFramedPage(
        title: 'Daftar Barang',
        topIcon: const Icon(Icons.favorite_rounded, size: 48, color: Color(0xFF22B9D2)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Stats ──
            Row(
              children: [
                Expanded(child: _StatCard(
                  color: const Color(0xFFDDE5F8),
                  icon: Icons.inventory_2_rounded,
                  value: '$_statTersedia',
                  label: 'Tersedia',
                )),
                const SizedBox(width: 8),
                Expanded(child: _StatCard(
                  color: const Color(0xFFFDF0C5),
                  icon: Icons.bolt_rounded,
                  value: '$_statHampirHabis',
                  label: 'Hampir Habis',
                )),
                const SizedBox(width: 8),
                Expanded(child: _StatCard(
                  color: const Color(0xFFFFE0D7),
                  icon: Icons.warning_amber_rounded,
                  value: '$_statHabis',
                  label: 'Habis',
                )),
              ],
            ),
            const SizedBox(height: 12),

            // ── Category filter chips ──
            SizedBox(
              height: 36,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: cats.length,
                separatorBuilder: (_, __) => const SizedBox(width: 6),
                itemBuilder: (_, i) {
                  final active = i == _activeCat;
                  return GestureDetector(
                    onTap: () => setState(() => _activeCat = i),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: active ? UserUi.blue : const Color(0xFFF7F0F6),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        cats[i],
                        style: TextStyle(
                          color: active ? Colors.white : UserUi.textLight,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),

            // ── Search ──
            Container(
              height: 34,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFF6ECF7),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  Container(
                    width: 18, height: 18,
                    decoration: const BoxDecoration(color: Color(0xFF9DE8F2), shape: BoxShape.circle),
                    child: const Icon(Icons.search, size: 13, color: Colors.black54),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      style: const TextStyle(fontSize: 12),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        hintText: 'Cari nama barang...',
                        hintStyle: TextStyle(fontSize: 12, color: UserUi.textLight),
                      ),
                      onChanged: (v) => setState(() => _search = v.trim().toLowerCase()),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // ── Items list ──
            if (_isLoading)
              const Center(child: Padding(
                padding: EdgeInsets.all(24),
                child: CircularProgressIndicator(color: UserUi.blue),
              ))
            else if (_filtered.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    _search.isNotEmpty ? 'Tidak ada hasil untuk "$_search"' : 'Belum ada barang',
                    style: const TextStyle(color: UserUi.textMuted, fontSize: 13),
                  ),
                ),
              )
            else
              ..._filtered.map((item) {
                final name = item['name']?.toString() ?? '-';
                final cat = item['category_name']?.toString() ?? '-';
                final stock = item['stock'] as int? ?? 0;
                final condition = item['condition']?.toString() ?? 'Tersedia';
                final condColor = _conditionColor(condition);
                final canBorrow = condition == 'Tersedia' && stock > 0;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: UserSectionCard(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                      children: [
                        const UserProductThumb(icon: Icons.inventory_2_rounded),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
                              Text(cat, style: const TextStyle(fontSize: 12, color: UserUi.textMuted)),
                              const SizedBox(height: 4),
                              Text('Stok: $stock', style: const TextStyle(fontSize: 11, color: UserUi.textMuted)),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            UserPill(
                              text: condition,
                              background: condColor.withOpacity(0.2),
                              foreground: condColor,
                            ),
                            if (canBorrow) ...[
                              const SizedBox(height: 6),
                              GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) =>
                                      PeminjamanBarangUserScreen(selectedItem: item)),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: UserUi.blue,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Text(
                                    'Pinjam',
                                    style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),

            const SizedBox(height: 8),

            // ── Pinjam Barang button ──
            UserSectionCard(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: UserPrimaryButton(
                  text: 'Pinjam Barang',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const PeminjamanBarangUserScreen()),
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

class _StatCard extends StatelessWidget {
  const _StatCard({required this.color, required this.icon, required this.value, required this.label});
  final Color color;
  final IconData icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 92,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: UserUi.frameBorder),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 28),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
          Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
