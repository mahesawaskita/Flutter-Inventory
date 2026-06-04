import 'package:flutter/material.dart';
import 'package:frontend/service/api_service.dart';
import 'package:frontend/service/auth_service.dart';

import 'detail_peminjaman_barang_user.dart';

class PeminjamanBarangUserScreen extends StatefulWidget {
  final Map<String, dynamic>? selectedItem;

  const PeminjamanBarangUserScreen({super.key, this.selectedItem});

  @override
  State<PeminjamanBarangUserScreen> createState() => _PeminjamanBarangUserScreenState();
}

class _PeminjamanBarangUserScreenState extends State<PeminjamanBarangUserScreen> {
  List<Map<String, dynamic>> _availableItems = [];
  Map<String, dynamic>? _selectedItem;
  final _purposeCtrl = TextEditingController();
  DateTime? _borrowDate;
  DateTime? _dueDate;

  List<Map<String, dynamic>> _myLoans = [];
  int _historyTab = 2;

  bool _isLoadingItems = true;
  bool _isLoadingHistory = true;
  String _username = '';

  static const _bg     = Color(0xFF0D1117);
  static const _purple = Color(0xFF8A20F7);
  static const _blue   = Color(0xFF4A6CF7);
  static const _green  = Color(0xFF10B981);
  static const _orange = Color(0xFFF97316);
  static const _red    = Color(0xFFEF4444);

  @override
  void initState() {
    super.initState();
    _loadData();
    if (widget.selectedItem != null) _selectedItem = widget.selectedItem;
  }

  @override
  void dispose() {
    _purposeCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    final token    = await AuthService.getToken();
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
              final s     = i['status']?.toString();
              final stock = int.tryParse(i['stock']?.toString() ?? '0') ?? 0;
              return s != 'inactive' && s != 'borrowed' && stock > 0;
            })
            .toList();
        _isLoadingItems = false;

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
        _myLoans           = loans.map((e) => Map<String, dynamic>.from(e)).toList();
        _isLoadingHistory  = false;
      });
    }
  }

  Future<void> _pickDate(bool isBorrow) async {
    final initial = isBorrow
        ? (_borrowDate ?? DateTime.now())
        : (_dueDate ?? (_borrowDate ?? DateTime.now()).add(const Duration(days: 1)));
    final first = isBorrow
        ? DateTime.now()
        : (_borrowDate ?? DateTime.now()).add(const Duration(days: 1));
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: first,
      lastDate: DateTime.now().add(const Duration(days: 90)),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: const ColorScheme.light(primary: _blue),
        ),
        child: child!,
      ),
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
    if (_selectedItem == null) { _showMsg('Pilih barang yang ingin dipinjam', isError: true); return; }
    if (_borrowDate == null)   { _showMsg('Pilih tanggal peminjaman', isError: true); return; }
    if (_dueDate == null)      { _showMsg('Pilih tanggal pengembalian', isError: true); return; }

    _goToDetail({
      'item_id'      : _selectedItem!['id'],
      'item_name'    : _selectedItem!['name'],
      'category_name': _selectedItem!['category_name'] ?? '-',
      'borrow_date'  : _fmtApi(_borrowDate!),
      'due_date'     : _fmtApi(_dueDate!),
      'stock'        : _selectedItem!['stock'],
      'purpose'      : _purposeCtrl.text.trim(),
    }, isReturnMode: false);
  }

  void _goToDetail(Map<String, dynamic>? loan, {bool isReturnMode = false}) {
    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailPeminjamanBarangUserScreen(loan: loan, isReturnMode: isReturnMode),
      ),
    ).then((refreshed) {
      if (refreshed == true) {
        setState(() { _selectedItem = null; _purposeCtrl.clear(); _borrowDate = null; _dueDate = null; });
        _loadData();
      }
    });
  }

  void _showMsg(String msg, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: isError ? _red : _green,
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
    try { return DateTime.parse(loan['due_date'].toString()).isBefore(DateTime.now()); }
    catch (_) { return false; }
  }

  List<Map<String, dynamic>> get _historyFiltered {
    switch (_historyTab) {
      case 0:  return _myLoans.where((l) => l['status'] == 'pending').toList();
      case 1:  return _myLoans.where((l) => l['status'] == 'borrowed').toList();
      default: return _myLoans.where((l) => l['status'] == 'returned').toList();
    }
  }

  void _showItemPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF161B27),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => _ItemPickerSheet(
        items: _availableItems,
        selectedItem: _selectedItem,
        onSelected: (item) { setState(() => _selectedItem = item); Navigator.pop(context); },
      ),
    );
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final duration = (_borrowDate != null && _dueDate != null)
        ? _dueDate!.difference(_borrowDate!).inDays
        : null;

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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [

                      // ── Header ──────────────────────────────────────────
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.maybePop(context),
                            child: Container(
                              width: 38, height: 38,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.08),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
                              ),
                              child: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 20),
                            ),
                          ),
                          const Spacer(),
                          const Text('Peminjaman Barang',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                          const Spacer(),
                          const SizedBox(width: 38),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // ── Form Card ────────────────────────────────────────
                      _SectionTitle('Detail Peminjaman'),
                      const SizedBox(height: 10),

                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.06),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
                        ),
                        child: Column(
                          children: [
                            // Nama Peminjam
                            _FormRow(
                              icon: Icons.person_rounded,
                              iconColor: _blue,
                              label: 'Nama Peminjam',
                              child: Text(
                                _username.isEmpty ? '...' : _username,
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
                              ),
                            ),

                            _Divider(),

                            // Pilih Barang
                            _isLoadingItems
                                ? const Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Center(child: CircularProgressIndicator(color: _blue, strokeWidth: 2)),
                                  )
                                : GestureDetector(
                                    onTap: _showItemPicker,
                                    child: _FormRow(
                                      icon: Icons.inventory_2_rounded,
                                      iconColor: _purple,
                                      label: 'Barang yang Dipinjam',
                                      trailing: Icon(Icons.chevron_right_rounded, size: 18,
                                          color: Colors.white.withValues(alpha: 0.35)),
                                      child: Text(
                                        _selectedItem != null
                                            ? _selectedItem!['name'].toString()
                                            : 'Pilih barang...',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: _selectedItem != null
                                              ? Colors.white
                                              : Colors.white.withValues(alpha: 0.35),
                                        ),
                                      ),
                                    ),
                                  ),

                            _Divider(),

                            // Tanggal
                            Padding(
                              padding: const EdgeInsets.all(14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 32, height: 32,
                                        decoration: BoxDecoration(
                                          color: _orange.withValues(alpha: 0.15),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: const Icon(Icons.date_range_rounded, color: _orange, size: 16),
                                      ),
                                      const SizedBox(width: 10),
                                      Text('Tanggal Peminjaman',
                                          style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.55))),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      Expanded(child: GestureDetector(
                                        onTap: () => _pickDate(true),
                                        child: _DatePickerField(
                                          label: 'Mulai',
                                          value: _borrowDate != null ? _fmtDisplay(_fmtApi(_borrowDate!)) : null,
                                          color: _blue,
                                        ),
                                      )),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: Icon(Icons.arrow_forward_rounded, size: 16,
                                            color: Colors.white.withValues(alpha: 0.25)),
                                      ),
                                      Expanded(child: GestureDetector(
                                        onTap: () => _pickDate(false),
                                        child: _DatePickerField(
                                          label: 'Selesai',
                                          value: _dueDate != null ? _fmtDisplay(_fmtApi(_dueDate!)) : null,
                                          color: _orange,
                                        ),
                                      )),
                                    ],
                                  ),
                                  if (duration != null) ...[
                                    const SizedBox(height: 10),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                                      decoration: BoxDecoration(
                                        color: _blue.withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: _blue.withValues(alpha: 0.25)),
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.info_outline_rounded, size: 13, color: _blue),
                                          const SizedBox(width: 7),
                                          Text('Durasi: $duration hari',
                                              style: const TextStyle(fontSize: 12, color: _blue, fontWeight: FontWeight.w600)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),

                            _Divider(),

                            // Keperluan
                            Padding(
                              padding: const EdgeInsets.fromLTRB(14, 12, 14, 4),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 32, height: 32,
                                    decoration: BoxDecoration(
                                      color: _green.withValues(alpha: 0.15),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(Icons.edit_note_rounded, color: _green, size: 16),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: TextField(
                                      controller: _purposeCtrl,
                                      style: const TextStyle(fontSize: 13, color: Colors.white),
                                      maxLines: 2,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        isDense: true,
                                        hintText: 'Keperluan peminjaman...',
                                        hintStyle: TextStyle(fontSize: 13, color: Colors.white.withValues(alpha: 0.3)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),

                      const SizedBox(height: 14),

                      // ── Peraturan ────────────────────────────────────────
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: _orange.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: _orange.withValues(alpha: 0.3)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 32, height: 32,
                              decoration: BoxDecoration(
                                color: _orange.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(Icons.warning_amber_rounded, color: _orange, size: 16),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Peraturan Peminjaman',
                                      style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white, fontSize: 13)),
                                  const SizedBox(height: 6),
                                  Text(
                                    '1. Barang hanya boleh dipinjam untuk keperluan resmi.\n'
                                    '2. Batas waktu peminjaman maksimal 7 hari.\n'
                                    '3. Keterlambatan pengembalian akan dikenakan sanksi.',
                                    style: TextStyle(fontSize: 12, height: 1.5, color: Colors.white.withValues(alpha: 0.65)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // ── Submit button ────────────────────────────────────
                      GestureDetector(
                        onTap: _submitAndNavigate,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: _green,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [BoxShadow(color: _green.withValues(alpha: 0.4), blurRadius: 14, offset: const Offset(0, 5))],
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                right: -10, top: -10,
                                child: Icon(Icons.local_shipping_rounded, size: 90,
                                    color: Colors.white.withValues(alpha: 0.1)),
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 46, height: 46,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.2),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Icon(Icons.send_rounded, color: Colors.white, size: 24),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text('Ajukan Peminjaman',
                                            style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                                        const SizedBox(height: 2),
                                        Text('Menunggu persetujuan admin',
                                            style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 11)),
                                      ],
                                    ),
                                  ),
                                  Icon(Icons.arrow_forward_rounded,
                                      color: Colors.white.withValues(alpha: 0.85), size: 18),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 28),

                      // ── Riwayat ──────────────────────────────────────────
                      Row(
                        children: [
                          const Text('Riwayat Peminjaman Saya',
                              style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                          const Spacer(),
                          if (!_isLoadingHistory)
                            Text('${_historyFiltered.length} data',
                                style: TextStyle(color: Colors.white.withValues(alpha: 0.45), fontSize: 12)),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // History tabs
                      Row(
                        children: [
                          Expanded(child: _HistoryTabBtn(
                            text: 'Menunggu',
                            active: _historyTab == 0,
                            color: _orange,
                            badge: _myLoans.where((l) => l['status'] == 'pending').length,
                            onTap: () => setState(() => _historyTab = 0),
                          )),
                          const SizedBox(width: 8),
                          Expanded(child: _HistoryTabBtn(
                            text: 'Dipinjam',
                            active: _historyTab == 1,
                            color: _blue,
                            badge: _myLoans.where((l) => l['status'] == 'borrowed').length,
                            onTap: () => setState(() => _historyTab = 1),
                          )),
                          const SizedBox(width: 8),
                          Expanded(child: _HistoryTabBtn(
                            text: 'Riwayat',
                            active: _historyTab == 2,
                            color: _green,
                            badge: 0,
                            onTap: () => setState(() => _historyTab = 2),
                          )),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // History list
                      if (_isLoadingHistory)
                        const Center(child: Padding(
                          padding: EdgeInsets.all(24),
                          child: CircularProgressIndicator(color: _purple, strokeWidth: 2),
                        ))
                      else if (_historyFiltered.isEmpty)
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 28),
                            child: Column(
                              children: [
                                Icon(Icons.receipt_long_outlined, size: 44,
                                    color: Colors.white.withValues(alpha: 0.2)),
                                const SizedBox(height: 10),
                                Text('Tidak ada data',
                                    style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 13)),
                              ],
                            ),
                          ),
                        )
                      else
                        ..._historyFiltered.map((loan) {
                          final itemName  = loan['item_name']?.toString()  ?? '-';
                          final borrowDate = _fmtDisplay(loan['borrow_date']?.toString());
                          final dueDate    = _fmtDisplay(loan['due_date']?.toString());
                          final status     = loan['status']?.toString() ?? '-';
                          final late       = _isLate(loan);

                          final Color statusColor = status == 'returned'
                              ? _green
                              : status == 'borrowed'
                                  ? (late ? _red : _blue)
                                  : _orange;
                          final String statusText = status == 'returned'
                              ? 'Dikembalikan'
                              : status == 'borrowed'
                                  ? (late ? 'Terlambat' : 'Dipinjam')
                                  : 'Menunggu';

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: GestureDetector(
                              onTap: () => _goToDetail(loan, isReturnMode: true),
                              child: Container(
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: late
                                      ? _red.withValues(alpha: 0.07)
                                      : Colors.white.withValues(alpha: 0.06),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: late
                                        ? _red.withValues(alpha: 0.3)
                                        : Colors.white.withValues(alpha: 0.11),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 44, height: 44,
                                      decoration: BoxDecoration(
                                        color: statusColor.withValues(alpha: 0.15),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Icon(Icons.inventory_2_rounded, color: statusColor, size: 22),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(itemName,
                                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white)),
                                          const SizedBox(height: 3),
                                          Text('$borrowDate → $dueDate',
                                              style: TextStyle(fontSize: 11, color: Colors.white.withValues(alpha: 0.45))),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: statusColor.withValues(alpha: 0.15),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(color: statusColor.withValues(alpha: 0.4)),
                                      ),
                                      child: Text(statusText,
                                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: statusColor)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),

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

// ── Shared helpers ────────────────────────────────────────────────────────────

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
      );
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Divider(height: 1, color: Colors.white.withValues(alpha: 0.08));
}

class _FormRow extends StatelessWidget {
  const _FormRow({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.child,
    this.trailing,
  });
  final IconData icon;
  final Color iconColor;
  final String label;
  final Widget child;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 32, height: 32,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor, size: 16),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(fontSize: 10, color: Colors.white.withValues(alpha: 0.5), fontWeight: FontWeight.w600)),
                const SizedBox(height: 3),
                child,
              ],
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

class _DatePickerField extends StatelessWidget {
  const _DatePickerField({required this.label, required this.value, required this.color});
  final String label;
  final String? value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: value != null ? color.withValues(alpha: 0.1) : Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: value != null ? color.withValues(alpha: 0.35) : Colors.white.withValues(alpha: 0.12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 9, color: Colors.white.withValues(alpha: 0.45), fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.calendar_today_rounded, size: 12, color: value != null ? color : Colors.white.withValues(alpha: 0.3)),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  value ?? 'Pilih tanggal',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: value != null ? FontWeight.w700 : FontWeight.normal,
                    color: value != null ? Colors.white : Colors.white.withValues(alpha: 0.3),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HistoryTabBtn extends StatelessWidget {
  const _HistoryTabBtn({
    required this.text,
    required this.active,
    required this.color,
    required this.badge,
    required this.onTap,
  });
  final String text;
  final bool active;
  final Color color;
  final int badge;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 38,
        decoration: BoxDecoration(
          color: active ? color : Colors.white.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: active ? color : Colors.white.withValues(alpha: 0.12)),
          boxShadow: active ? [BoxShadow(color: color.withValues(alpha: 0.35), blurRadius: 8, offset: const Offset(0, 2))] : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: active ? Colors.white : Colors.white54,
              ),
            ),
            if (badge > 0 && !active) ...[
              const SizedBox(width: 5),
              Container(
                width: 16, height: 16,
                decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
                alignment: Alignment.center,
                child: Text('$badge', style: const TextStyle(fontSize: 9, color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ── Item Picker Bottom Sheet ──────────────────────────────────────────────────

class _ItemPickerSheet extends StatefulWidget {
  const _ItemPickerSheet({required this.items, required this.onSelected, this.selectedItem});
  final List<Map<String, dynamic>> items;
  final Map<String, dynamic>? selectedItem;
  final ValueChanged<Map<String, dynamic>> onSelected;

  @override
  State<_ItemPickerSheet> createState() => _ItemPickerSheetState();
}

class _ItemPickerSheetState extends State<_ItemPickerSheet> {
  final _searchCtrl = TextEditingController();
  String _query = '';
  String? _activeCategory;

  static const _blue = Color(0xFF4A6CF7);

  @override
  void dispose() { _searchCtrl.dispose(); super.dispose(); }

  List<String> get _categories {
    final cats = widget.items
        .map((i) => i['category_name']?.toString() ?? '')
        .where((c) => c.isNotEmpty)
        .toSet()
        .toList()
      ..sort();
    return cats;
  }

  List<Map<String, dynamic>> get _filtered => widget.items.where((item) {
        final name = item['name']?.toString().toLowerCase() ?? '';
        final cat  = item['category_name']?.toString() ?? '';
        return (_query.isEmpty || name.contains(_query.toLowerCase())) &&
               (_activeCategory == null || cat == _activeCategory);
      }).toList();

  @override
  Widget build(BuildContext context) {
    final filtered   = _filtered;
    final categories = _categories;

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      expand: false,
      builder: (_, scrollController) => Column(
        children: [
          // Drag handle
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 4),
            width: 40, height: 4,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: Row(
              children: [
                const Text('Pilih Barang',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.white)),
                const Spacer(),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 30, height: 30,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.close_rounded, color: Colors.white60, size: 16),
                  ),
                ),
              ],
            ),
          ),

          // Search
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              height: 44,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
              ),
              child: Row(
                children: [
                  Icon(Icons.search_rounded, size: 18, color: Colors.white.withValues(alpha: 0.4)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _searchCtrl,
                      onChanged: (v) => setState(() => _query = v),
                      style: const TextStyle(fontSize: 13, color: Colors.white),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        hintText: 'Cari nama barang...',
                        hintStyle: TextStyle(fontSize: 13, color: Colors.white.withValues(alpha: 0.3)),
                      ),
                    ),
                  ),
                  if (_query.isNotEmpty)
                    GestureDetector(
                      onTap: () { _searchCtrl.clear(); setState(() => _query = ''); },
                      child: Icon(Icons.close_rounded, size: 16, color: Colors.white.withValues(alpha: 0.4)),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Category chips
          if (categories.isNotEmpty)
            SizedBox(
              height: 34,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _CatChip(label: 'Semua', active: _activeCategory == null, onTap: () => setState(() => _activeCategory = null)),
                  ...categories.map((cat) => _CatChip(
                        label: cat,
                        active: _activeCategory == cat,
                        onTap: () => setState(() => _activeCategory = cat),
                      )),
                ],
              ),
            ),
          const SizedBox(height: 8),

          Divider(height: 1, color: Colors.white.withValues(alpha: 0.08)),

          // Item list
          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.search_off_rounded, size: 44, color: Colors.white.withValues(alpha: 0.2)),
                        const SizedBox(height: 10),
                        Text(
                          _query.isEmpty ? 'Tidak ada barang tersedia' : 'Barang "$_query" tidak ditemukan',
                          style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 13),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    controller: scrollController,
                    padding: const EdgeInsets.only(top: 4),
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) =>
                        Divider(height: 1, indent: 62, color: Colors.white.withValues(alpha: 0.06)),
                    itemBuilder: (_, i) {
                      final item = filtered[i];
                      final isSelected = widget.selectedItem != null &&
                          widget.selectedItem!['id']?.toString() == item['id']?.toString();
                      return ListTile(
                        leading: Container(
                          width: 40, height: 40,
                          decoration: BoxDecoration(
                            color: isSelected ? _blue.withValues(alpha: 0.2) : Colors.white.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(10),
                            border: isSelected ? Border.all(color: _blue.withValues(alpha: 0.4)) : null,
                          ),
                          child: Icon(Icons.inventory_2_rounded, size: 20,
                              color: isSelected ? _blue : Colors.white.withValues(alpha: 0.5)),
                        ),
                        title: Text(
                          item['name']?.toString() ?? '-',
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
                        ),
                        subtitle: Text(
                          '${item['category_name'] ?? '-'} · Stok: ${item['stock']}',
                          style: TextStyle(fontSize: 11, color: Colors.white.withValues(alpha: 0.45)),
                        ),
                        trailing: isSelected
                            ? const Icon(Icons.check_circle_rounded, color: _blue)
                            : Icon(Icons.chevron_right_rounded, color: Colors.white.withValues(alpha: 0.3)),
                        onTap: () => widget.onSelected(item),
                      );
                    },
                  ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

class _CatChip extends StatelessWidget {
  const _CatChip({required this.label, required this.active, required this.onTap});
  final String label;
  final bool active;
  final VoidCallback onTap;

  static const _blue = Color(0xFF4A6CF7);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: active ? _blue : Colors.white.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: active ? _blue : Colors.white.withValues(alpha: 0.15)),
          boxShadow: active ? [BoxShadow(color: _blue.withValues(alpha: 0.35), blurRadius: 6)] : null,
        ),
        child: Text(label, style: TextStyle(
          fontSize: 12, fontWeight: FontWeight.w700,
          color: active ? Colors.white : Colors.white60,
        )),
      ),
    );
  }
}
