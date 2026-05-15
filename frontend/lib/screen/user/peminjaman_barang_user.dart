import 'package:flutter/material.dart';
import 'package:frontend/service/api_service.dart';
import 'package:frontend/service/auth_service.dart';

import 'detail_peminjaman_barang_user.dart';
import 'user_ui.dart';

class PeminjamanBarangUserScreen extends StatefulWidget {
  final Map<String, dynamic>? selectedItem;

  const PeminjamanBarangUserScreen({super.key, this.selectedItem});

  @override
  State<PeminjamanBarangUserScreen> createState() => _PeminjamanBarangUserScreenState();
}

class _PeminjamanBarangUserScreenState extends State<PeminjamanBarangUserScreen> {
  // Form state
  List<Map<String, dynamic>> _availableItems = [];
  Map<String, dynamic>? _selectedItem;
  final _purposeCtrl = TextEditingController();
  DateTime? _borrowDate;
  DateTime? _dueDate;

  // History
  List<Map<String, dynamic>> _myLoans = [];
  int _historyTab = 2; // 0=pending, 1=active, 2=history

  bool _isLoadingItems = true;
  bool _isLoadingHistory = true;
  String _username = '';

  @override
  void initState() {
    super.initState();
    _loadData();
    if (widget.selectedItem != null) {
      _selectedItem = widget.selectedItem;
    }
  }

  @override
  void dispose() {
    _purposeCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    final token = await AuthService.getToken();
    final username = await AuthService.getUsername();
    if (!mounted) return;
    setState(() => _username = username ?? '');

    if (token == null) return;

    final items = await ApiService.getItems(token);
    if (mounted) {
      setState(() {
        _availableItems = items
            .map((e) => Map<String, dynamic>.from(e))
            .where((i) {
              final s = i['status']?.toString();
              final stock = int.tryParse(i['stock']?.toString() ?? '0') ?? 0;
              return s != 'inactive' && s != 'borrowed' && stock > 0;
            })
            .toList();
        _isLoadingItems = false;

        // Keep pre-selected item if still available
        if (_selectedItem != null) {
          final match = _availableItems.firstWhere(
            (i) => i['id']?.toString() == _selectedItem!['id']?.toString(),
            orElse: () => <String, dynamic>{},
          );
          _selectedItem = match.isNotEmpty ? match : null;
        }
      });
    }

    final loans = await ApiService.getMyLoans(token);
    if (mounted) {
      setState(() {
        _myLoans = loans.map((e) => Map<String, dynamic>.from(e)).toList();
        _isLoadingHistory = false;
      });
    }
  }

  Future<void> _pickDate(bool isBorrow) async {
    final initial = isBorrow ? (_borrowDate ?? DateTime.now()) : (_dueDate ?? (_borrowDate ?? DateTime.now()).add(const Duration(days: 1)));
    final first = isBorrow ? DateTime.now() : (_borrowDate ?? DateTime.now()).add(const Duration(days: 1));
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: first,
      lastDate: DateTime.now().add(const Duration(days: 90)),
    );
    if (picked != null && mounted) {
      setState(() {
        if (isBorrow) {
          _borrowDate = picked;
          if (_dueDate != null && _dueDate!.isBefore(picked)) _dueDate = null;
        } else {
          _dueDate = picked;
        }
      });
    }
  }

  Future<void> _submitAndNavigate() async {
    if (_selectedItem == null) {
      _showMsg('Pilih barang yang ingin dipinjam', isError: true);
      return;
    }
    if (_borrowDate == null) {
      _showMsg('Pilih tanggal peminjaman', isError: true);
      return;
    }
    if (_dueDate == null) {
      _showMsg('Pilih tanggal pengembalian', isError: true);
      return;
    }

    // Navigate ke detail dulu — konfirmasi & API call dilakukan di sana
    _goToDetail({
      'item_id': _selectedItem!['id'],
      'item_name': _selectedItem!['name'],
      'category_name': _selectedItem!['category_name'] ?? '-',
      'borrow_date': _fmtApi(_borrowDate!),
      'due_date': _fmtApi(_dueDate!),
      'stock': _selectedItem!['stock'],
      'purpose': _purposeCtrl.text.trim(),
    }, isReturnMode: false);
  }

  void _goToDetail(Map<String, dynamic>? loan, {bool isReturnMode = false}) {
    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailPeminjamanBarangUserScreen(
          loan: loan,
          isReturnMode: isReturnMode,
        ),
      ),
    ).then((refreshed) {
      if (refreshed == true) {
        setState(() {
          _selectedItem = null;
          _purposeCtrl.clear();
          _borrowDate = null;
          _dueDate = null;
        });
        _loadData();
      }
    });
  }

  void _showMsg(String msg, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: isError ? Colors.red : Colors.green,
    ));
  }

  String _fmtApi(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  String _fmtDisplay(String? s) {
    if (s == null) return '-';
    try {
      final d = DateTime.parse(s);
      const m = ['Jan','Feb','Mar','Apr','Mei','Jun','Jul','Agu','Sep','Okt','Nov','Des'];
      return '${d.day} ${m[d.month - 1]} ${d.year}';
    } catch (_) { return s; }
  }

  bool _isLate(Map<String, dynamic> loan) {
    if (loan['status'] != 'borrowed') return false;
    try {
      return DateTime.parse(loan['due_date'].toString()).isBefore(DateTime.now());
    } catch (_) { return false; }
  }

  List<Map<String, dynamic>> get _historyFiltered {
    switch (_historyTab) {
      case 0: return _myLoans.where((l) => l['status'] == 'pending').toList();
      case 1: return _myLoans.where((l) => l['status'] == 'borrowed').toList();
      default: return _myLoans.where((l) => l['status'] == 'returned').toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return UserPageScaffold(
      child: UserFramedPage(
        title: 'Peminjaman Barang',
        topIcon: const Icon(Icons.local_shipping_rounded, size: 50, color: Color(0xFFEA6482)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Form Card ──
            UserSectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nama peminjam
                  _fieldRow(
                    icon: Icons.person_pin_circle_rounded,
                    title: 'Nama Peminjam',
                    value: _username.isEmpty ? '...' : _username,
                  ),
                  const SizedBox(height: 8),

                  // Pilih barang
                  _isLoadingItems
                      ? const Center(child: Padding(
                          padding: EdgeInsets.all(8),
                          child: CircularProgressIndicator(color: UserUi.blue, strokeWidth: 2),
                        ))
                      : GestureDetector(
                          onTap: _showItemPicker,
                          child: _fieldRow(
                            icon: Icons.inventory_2_rounded,
                            title: 'Barang yang Dipinjam',
                            value: _selectedItem != null
                                ? _selectedItem!['name'].toString()
                                : 'Pilih barang...',
                            muted: _selectedItem == null,
                            trailing: const Icon(Icons.chevron_right_rounded, size: 18),
                          ),
                        ),
                  const SizedBox(height: 8),

                  // Waktu peminjaman
                  GestureDetector(
                    onTap: () => _pickDate(true),
                    child: UserSectionCard(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_month_rounded, color: Color(0xFF748BCB), size: 20),
                          const SizedBox(width: 8),
                          const Text('Mulai', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                          const Spacer(),
                          Text(
                            _borrowDate != null ? _fmtDisplay(_fmtApi(_borrowDate!)) : 'Pilih tanggal',
                            style: TextStyle(fontSize: 13, color: _borrowDate != null ? Colors.black87 : UserUi.textMuted),
                          ),
                          const SizedBox(width: 4),
                          const Icon(Icons.arrow_forward_ios_rounded, size: 12, color: UserUi.textMuted),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () => _pickDate(false),
                            child: Text(
                              _dueDate != null ? _fmtDisplay(_fmtApi(_dueDate!)) : 'Pilih kembali',
                              style: TextStyle(fontSize: 13, color: _dueDate != null ? Colors.black87 : UserUi.textMuted),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Keperluan
                  UserSectionCard(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    child: Row(
                      children: [
                        const Icon(Icons.edit_note_rounded, color: Color(0xFF7A9AD8), size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: _purposeCtrl,
                            style: const TextStyle(fontSize: 13),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                              hintText: 'Keperluan peminjaman...',
                              hintStyle: TextStyle(fontSize: 13, color: UserUi.textMuted),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // ── Peraturan ──
            UserSectionCard(
              color: const Color(0xFFF7F0F6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Icon(Icons.warning_amber_rounded, color: Color(0xFFFFB100)),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Peraturan Peminjaman', style: TextStyle(fontWeight: FontWeight.w800)),
                        SizedBox(height: 6),
                        Text(
                          '1. Barang hanya boleh dipinjam untuk keperluan resmi.\n'
                          '2. Batas waktu peminjaman maksimal 7 hari.\n'
                          '3. Keterlambatan pengembalian akan dikenakan sanksi.',
                          style: TextStyle(fontSize: 12, height: 1.45),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

                    // ── Submit ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 62),
              child: UserPrimaryButton(
                text: 'Ajukan Peminjaman',
                icon: Icons.send_rounded,
                onTap: _submitAndNavigate,
              ),
            ),
            const SizedBox(height: 16),

            // ── History ──
            UserSectionCard(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Riwayat Peminjaman Saya',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(child: _HistoryTab(text: 'Menunggu', active: _historyTab == 0, onTap: () => setState(() => _historyTab = 0))),
                      const SizedBox(width: 6),
                      Expanded(child: _HistoryTab(text: 'Dipinjam', active: _historyTab == 1, onTap: () => setState(() => _historyTab = 1))),
                      const SizedBox(width: 6),
                      Expanded(child: _HistoryTab(text: 'Riwayat', active: _historyTab == 2, onTap: () => setState(() => _historyTab = 2))),
                    ],
                  ),
                  const SizedBox(height: 10),
                  if (_isLoadingHistory)
                    const Center(child: Padding(
                      padding: EdgeInsets.all(16),
                      child: CircularProgressIndicator(color: UserUi.blue, strokeWidth: 2),
                    ))
                  else if (_historyFiltered.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(12),
                      child: Text('Tidak ada data', style: TextStyle(color: UserUi.textMuted, fontSize: 13)),
                    )
                  else
                    ..._historyFiltered.map((loan) {
                      final itemName = loan['item_name']?.toString() ?? '-';
                      final borrowDate = _fmtDisplay(loan['borrow_date']?.toString());
                      final dueDate = _fmtDisplay(loan['due_date']?.toString());
                      final status = loan['status']?.toString() ?? '-';
                      final late = _isLate(loan);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: GestureDetector(
                          onTap: () => _goToDetail(loan, isReturnMode: true),
                          child: Row(
                          children: [
                            const UserProductThumb(
                              icon: Icons.inventory_2_rounded,
                              background: Color(0xFFE5E5EA),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(itemName, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
                                  Text('$borrowDate → $dueDate', style: const TextStyle(fontSize: 11, color: UserUi.textMuted)),
                                ],
                              ),
                            ),
                            UserPill(
                              text: status == 'returned'
                                  ? 'Dikembalikan'
                                  : status == 'borrowed'
                                      ? (late ? 'Terlambat' : 'Dipinjam')
                                      : 'Menunggu',
                              background: status == 'returned'
                                  ? const Color(0xFFD8DEFF)
                                  : status == 'borrowed'
                                      ? (late ? const Color(0xFFFFE0D7) : const Color(0xFFDCF5E3))
                                      : const Color(0xFFFFF3CD),
                              foreground: status == 'returned'
                                  ? const Color(0xFF4D7BEE)
                                  : status == 'borrowed'
                                      ? (late ? Colors.red : Colors.green)
                                      : Colors.orange,
                            ),
                          ],
                        ),
                        ),
                      );
                    }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _fieldRow({
    required IconData icon,
    required String title,
    required String value,
    bool muted = false,
    Widget? trailing,
  }) {
    return UserSectionCard(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF7A9AD8), size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                Text(value, style: TextStyle(fontSize: 12, color: muted ? UserUi.textMuted : Colors.black87)),
              ],
            ),
          ),
          if (trailing != null) trailing,
        ],
      ),
    );
  }

  void _showItemPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _ItemPickerSheet(
        items: _availableItems,
        selectedItem: _selectedItem,
        onSelected: (item) {
          setState(() => _selectedItem = item);
          Navigator.pop(context);
        },
      ),
    );
  }
}

class _HistoryTab extends StatelessWidget {
  const _HistoryTab({required this.text, required this.active, required this.onTap});
  final String text;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 30,
        decoration: BoxDecoration(
          color: active ? UserUi.blue : const Color(0xFFECE5EC),
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 11,
            color: active ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

// ── Item Picker Bottom Sheet ──────────────────────────────────────────────────

class _ItemPickerSheet extends StatefulWidget {
  const _ItemPickerSheet({
    required this.items,
    required this.onSelected,
    this.selectedItem,
  });

  final List<Map<String, dynamic>> items;
  final Map<String, dynamic>? selectedItem;
  final ValueChanged<Map<String, dynamic>> onSelected;

  @override
  State<_ItemPickerSheet> createState() => _ItemPickerSheetState();
}

class _ItemPickerSheetState extends State<_ItemPickerSheet> {
  final _searchCtrl = TextEditingController();
  String _query = '';
  String? _activeCategory; // null = semua

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  List<String> get _categories {
    final cats = widget.items
        .map((i) => i['category_name']?.toString() ?? '')
        .where((c) => c.isNotEmpty)
        .toSet()
        .toList()
      ..sort();
    return cats;
  }

  List<Map<String, dynamic>> get _filtered {
    return widget.items.where((item) {
      final name = item['name']?.toString().toLowerCase() ?? '';
      final cat = item['category_name']?.toString() ?? '';
      final matchSearch = _query.isEmpty || name.contains(_query.toLowerCase());
      final matchCat = _activeCategory == null || cat == _activeCategory;
      return matchSearch && matchCat;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filtered;
    final categories = _categories;

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      expand: false,
      builder: (_, scrollController) => Column(
        children: [
          // ── Drag handle ──
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 6),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFFCCCCCC),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // ── Header ──
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 4, 16, 10),
            child: Text(
              'Pilih Barang',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
            ),
          ),

          // ── Search ──
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _searchCtrl,
              onChanged: (v) => setState(() => _query = v),
              style: const TextStyle(fontSize: 13),
              decoration: InputDecoration(
                hintText: 'Cari nama barang...',
                hintStyle:
                    const TextStyle(fontSize: 13, color: UserUi.textMuted),
                prefixIcon: const Icon(Icons.search_rounded,
                    size: 20, color: UserUi.textMuted),
                suffixIcon: _query.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.close_rounded,
                            size: 18, color: UserUi.textMuted),
                        onPressed: () {
                          _searchCtrl.clear();
                          setState(() => _query = '');
                        },
                      )
                    : null,
                filled: true,
                fillColor: const Color(0xFFF5F0F6),
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),

          // ── Category chips ──
          if (categories.isNotEmpty)
            SizedBox(
              height: 34,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _CategoryChip(
                    label: 'Semua',
                    active: _activeCategory == null,
                    onTap: () => setState(() => _activeCategory = null),
                  ),
                  ...categories.map((cat) => _CategoryChip(
                        label: cat,
                        active: _activeCategory == cat,
                        onTap: () => setState(() => _activeCategory = cat),
                      )),
                ],
              ),
            ),
          const SizedBox(height: 8),

          // ── Divider ──
          const Divider(height: 1, color: UserUi.softBorder),

          // ── Item list ──
          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.search_off_rounded,
                            size: 40, color: Colors.grey[300]),
                        const SizedBox(height: 8),
                        Text(
                          _query.isEmpty
                              ? 'Tidak ada barang tersedia'
                              : 'Barang "$_query" tidak ditemukan',
                          style: const TextStyle(
                              color: UserUi.textMuted, fontSize: 13),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    controller: scrollController,
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) =>
                        const Divider(height: 1, indent: 56, color: UserUi.softBorder),
                    itemBuilder: (_, i) {
                      final item = filtered[i];
                      final isSelected = widget.selectedItem != null &&
                          widget.selectedItem!['id']?.toString() ==
                              item['id']?.toString();
                      return ListTile(
                        leading: Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: UserUi.productThumbBackground,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.inventory_2_rounded,
                              size: 20, color: UserUi.productThumbIconColor),
                        ),
                        title: Text(
                          item['name']?.toString() ?? '-',
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700),
                        ),
                        subtitle: Text(
                          '${item['category_name'] ?? '-'} · Stok: ${item['stock']}',
                          style: const TextStyle(
                              fontSize: 11, color: UserUi.textMuted),
                        ),
                        trailing: isSelected
                            ? const Icon(Icons.check_circle_rounded,
                                color: UserUi.blue)
                            : const Icon(Icons.chevron_right_rounded,
                                color: UserUi.textMuted),
                        onTap: () => widget.onSelected(item),
                      );
                    },
                  ),
          ),

          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.label,
    required this.active,
    required this.onTap,
  });
  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: active ? UserUi.blue : const Color(0xFFF0EAF2),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: active ? UserUi.blue : UserUi.softBorder,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: active ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }
}
