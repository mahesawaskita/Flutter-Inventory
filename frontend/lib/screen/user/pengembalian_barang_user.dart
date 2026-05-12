import 'package:flutter/material.dart';
import 'package:frontend/service/api_service.dart';
import 'package:frontend/service/auth_service.dart';

import 'user_ui.dart';

class PengembalianBarangUserScreen extends StatefulWidget {
  const PengembalianBarangUserScreen({super.key});

  @override
  State<PengembalianBarangUserScreen> createState() => _PengembalianBarangUserScreenState();
}

class _PengembalianBarangUserScreenState extends State<PengembalianBarangUserScreen> {
  List<Map<String, dynamic>> _myLoans = [];
  bool _isLoading = true;
  int _activeTab = 0; // 0=dipinjam, 1=terlambat, 2=riwayat
  bool _isReturning = false;

  @override
  void initState() {
    super.initState();
    _loadLoans();
  }

  Future<void> _loadLoans() async {
    setState(() => _isLoading = true);
    try {
      final token = await AuthService.getToken();
      if (token != null) {
        final loans = await ApiService.getMyLoans(token);
        if (mounted) {
          setState(() => _myLoans = loans.map((e) => Map<String, dynamic>.from(e)).toList());
        }
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  bool _isLate(Map<String, dynamic> loan) {
    if (loan['status'] != 'active') return false;
    try {
      return DateTime.parse(loan['due_date'].toString()).isBefore(DateTime.now());
    } catch (_) {
      return false;
    }
  }

  List<Map<String, dynamic>> get _currentList {
    switch (_activeTab) {
      case 1:
        return _myLoans.where((l) => l['status'] == 'active' && _isLate(l)).toList();
      case 2:
        return _myLoans.where((l) => l['status'] == 'returned').toList();
      default:
        return _myLoans.where((l) => l['status'] == 'active').toList();
    }
  }

  Future<void> _returnItem(Map<String, dynamic> loan) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Kembalikan Barang'),
        content: Text('Yakin ingin mengembalikan "${loan['item_name']}"?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Batal')),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(backgroundColor: UserUi.blue),
            child: const Text('Kembalikan', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
    if (confirm != true) return;

    setState(() => _isReturning = true);
    final token = await AuthService.getToken();
    if (token == null) { if (mounted) setState(() => _isReturning = false); return; }

    final loanId = (loan['id'] as num).toInt();
    final result = await ApiService.returnLoan(token, loanId);

    if (!mounted) return;
    setState(() => _isReturning = false);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(result['message']?.toString() ?? ''),
      backgroundColor: result['success'] == true ? Colors.green : Colors.red,
    ));

    if (result['success'] == true) _loadLoans();
  }

  String _fmtDisplay(String? s) {
    if (s == null) return '-';
    try {
      final d = DateTime.parse(s);
      const m = ['Jan','Feb','Mar','Apr','Mei','Jun','Jul','Agu','Sep','Okt','Nov','Des'];
      return '${d.day} ${m[d.month - 1]} ${d.year}';
    } catch (_) {
      return s;
    }
  }

  String _daysLeft(Map<String, dynamic> loan) {
    try {
      final due = DateTime.parse(loan['due_date'].toString());
      final diff = due.difference(DateTime.now()).inDays;
      if (diff < 0) return 'Terlambat ${-diff} hari';
      if (diff == 0) return 'Jatuh tempo hari ini';
      return '$diff hari lagi';
    } catch (_) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return UserPageScaffold(
      child: UserFramedPage(
        title: 'Pengembalian Barang',
        topIcon: const Icon(Icons.sync_alt_rounded, size: 50, color: Color(0xFF3D3D3D)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Tabs ──
            Row(
              children: [
                Expanded(child: _Segment(text: 'Dipinjam', active: _activeTab == 0, onTap: () => setState(() => _activeTab = 0))),
                const SizedBox(width: 6),
                Expanded(child: _Segment(text: 'Terlambat', active: _activeTab == 1, onTap: () => setState(() => _activeTab = 1))),
                const SizedBox(width: 6),
                Expanded(child: _Segment(text: 'Riwayat', active: _activeTab == 2, onTap: () => setState(() => _activeTab = 2))),
              ],
            ),
            const SizedBox(height: 12),

            // ── Content ──
            if (_isLoading)
              const Center(child: Padding(
                padding: EdgeInsets.all(24),
                child: CircularProgressIndicator(color: UserUi.blue),
              ))
            else if (_currentList.isEmpty)
              Padding(
                padding: const EdgeInsets.all(24),
                child: Center(
                  child: Text(
                    _activeTab == 0
                        ? 'Tidak ada barang yang sedang dipinjam'
                        : _activeTab == 1
                            ? 'Tidak ada peminjaman yang terlambat'
                            : 'Belum ada riwayat pengembalian',
                    style: const TextStyle(color: UserUi.textMuted, fontSize: 13),
                  ),
                ),
              )
            else
              ..._currentList.map((loan) {
                final name = loan['item_name']?.toString() ?? '-';
                final dueDate = _fmtDisplay(loan['due_date']?.toString());
                final returnDate = _fmtDisplay(loan['return_date']?.toString());
                final late = _isLate(loan);
                final daysLeft = _daysLeft(loan);
                final isReturned = loan['status'] == 'returned';

                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: UserSectionCard(
                    child: Row(
                      children: [
                        UserProductThumb(
                          icon: Icons.inventory_2_rounded,
                          background: late ? const Color(0xFFFFE0D7) : const Color(0xFFE7E8F4),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(name, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
                              const SizedBox(height: 2),
                              if (isReturned)
                                Text('Dikembalikan: $returnDate', style: const TextStyle(fontSize: 11, color: UserUi.textMuted))
                              else ...[
                                Text('Jatuh tempo: $dueDate', style: const TextStyle(fontSize: 11)),
                                const SizedBox(height: 2),
                                Text(
                                  daysLeft,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: late ? Colors.red : UserUi.textMuted,
                                    fontWeight: late ? FontWeight.w700 : FontWeight.normal,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        if (isReturned)
                          const UserPill(
                            text: 'Selesai',
                            background: Color(0xFFD8DEFF),
                            foreground: Color(0xFF4D7BEE),
                          )
                        else
                          GestureDetector(
                            onTap: _isReturning ? null : () => _returnItem(loan),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: _isReturning ? Colors.grey : UserUi.blue,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                'Kembalikan',
                                style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              }),

            if (!_isLoading && _currentList.isNotEmpty)
              UserSectionCard(
                color: Colors.white,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Menampilkan ${_currentList.length} barang',
                    style: const TextStyle(fontSize: 12, color: UserUi.textMuted),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Segment extends StatelessWidget {
  const _Segment({required this.text, required this.active, required this.onTap});
  final String text;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 34,
        decoration: BoxDecoration(
          color: active ? UserUi.blue : const Color(0xFFF6EEF6),
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: active ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
