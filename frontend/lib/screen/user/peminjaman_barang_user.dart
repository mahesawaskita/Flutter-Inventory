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
  bool _isSubmitting = false;
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
    if (_selectedItem != null && _borrowDate != null && _dueDate != null) {
      await _submit();
    } else {
      _goToDetail(null);
    }
  }

  void _goToDetail(Map<String, dynamic>? loan) {
    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DetailPeminjamanBarangUserScreen(loan: loan)),
    ).then((refreshed) {
      if (refreshed == true) _loadData();
    });
  }

  Future<void> _submit() async {
    setState(() => _isSubmitting = true);
    final token = await AuthService.getToken();
    if (token == null) {
      if (mounted) setState(() => _isSubmitting = false);
      return;
    }

    final selectedItem = _selectedItem!;
    final borrowDate = _fmtApi(_borrowDate!);
    final dueDate = _fmtApi(_dueDate!);

    final result = await ApiService.createLoan(token, {
      'item_id': selectedItem['id'],
      'purpose': _purposeCtrl.text.trim(),
      'borrow_date': borrowDate,
      'due_date': dueDate,
    });

    if (!mounted) return;
    setState(() => _isSubmitting = false);

    if (result['success'] == true) {
      _showMsg('Peminjaman berhasil diajukan!');
      setState(() {
        _selectedItem = null;
        _purposeCtrl.clear();
        _borrowDate = null;
        _dueDate = null;
      });
      _loadData();
      _goToDetail({
        'id': result['id'],
        'item_name': selectedItem['name'],
        'category_name': selectedItem['category_name'] ?? '-',
        'borrow_date': borrowDate,
        'due_date': dueDate,
        'status': 'borrowed',
      });
    } else {
      _showMsg(result['message']?.toString() ?? 'Gagal', isError: true);
      _goToDetail(null);
    }
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
                text: _isSubmitting ? 'Mengajukan...' : 'Ajukan Peminjaman',
                icon: _isSubmitting ? null : Icons.send_rounded,
                onTap: _isSubmitting ? null : _submitAndNavigate,
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
                          onTap: () => _goToDetail(loan),
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
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (_) {
        if (_availableItems.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(24),
            child: Text('Tidak ada barang yang tersedia', style: TextStyle(color: UserUi.textMuted)),
          );
        }
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Text('Pilih Barang', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              ),
              ..._availableItems.map((item) => ListTile(
                    leading: const Icon(Icons.inventory_2_rounded, color: UserUi.blue),
                    title: Text(item['name']?.toString() ?? '-'),
                    subtitle: Text('Stok: ${item['stock']} · ${item['category_name'] ?? '-'}',
                        style: const TextStyle(fontSize: 12)),
                    trailing: _selectedItem != null && _selectedItem!['id']?.toString() == item['id']?.toString()
                        ? const Icon(Icons.check_circle, color: UserUi.blue)
                        : null,
                    onTap: () {
                      setState(() => _selectedItem = item);
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
