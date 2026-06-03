import 'package:flutter/material.dart';
import 'package:frontend/service/api_service.dart';
import 'package:frontend/service/auth_service.dart';
import 'detail_pengembalian_user.dart';

class PengembalianBarangUserScreen extends StatefulWidget {
  const PengembalianBarangUserScreen({super.key});

  @override
  State<PengembalianBarangUserScreen> createState() => _PengembalianBarangUserScreenState();
}

class _PengembalianBarangUserScreenState extends State<PengembalianBarangUserScreen> {
  List<Map<String, dynamic>> _myLoans = [];
  bool _isLoading = true;
  int _activeTab = 0; // 0=dipinjam, 1=terlambat, 2=riwayat

  static const _bg = Color(0xFF0D1117);
  static const _card = Color(0xFF161B22);
  static const _cardBorder = Color(0xFF30363D);

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
    if (loan['status'] != 'borrowed') return false;
    try {
      return DateTime.parse(loan['due_date'].toString()).isBefore(DateTime.now());
    } catch (_) {
      return false;
    }
  }

  List<Map<String, dynamic>> get _currentList {
    switch (_activeTab) {
      case 1:
        return _myLoans.where((l) => l['status'] == 'borrowed' && _isLate(l)).toList();
      case 2:
        return _myLoans.where((l) => l['status'] == 'returned').toList();
      default:
        return _myLoans.where((l) => l['status'] == 'borrowed' || l['status'] == 'pending').toList();
    }
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
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Pengembalian Barang',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded, color: Colors.white70),
            onPressed: _loadLoans,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadLoans,
        color: const Color(0xFF4A6CF7),
        backgroundColor: const Color(0xFF1A2035),
        child: Column(
          children: [
            // ── Tabs ──────────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Row(
                children: [
                  _Tab(text: 'Dipinjam', active: _activeTab == 0, onTap: () => setState(() => _activeTab = 0)),
                  const SizedBox(width: 8),
                  _Tab(text: 'Terlambat', active: _activeTab == 1, color: const Color(0xFFEF4444), onTap: () => setState(() => _activeTab = 1)),
                  const SizedBox(width: 8),
                  _Tab(text: 'Riwayat', active: _activeTab == 2, color: const Color(0xFF10B981), onTap: () => setState(() => _activeTab = 2)),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // ── Content ───────────────────────────────────────────────────
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator(color: Color(0xFF4A6CF7)))
                  : _currentList.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                _activeTab == 2 ? Icons.history_rounded : Icons.inbox_rounded,
                                size: 56,
                                color: Colors.white24,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                _activeTab == 0
                                    ? 'Tidak ada barang yang sedang dipinjam'
                                    : _activeTab == 1
                                        ? 'Tidak ada peminjaman yang terlambat'
                                        : 'Belum ada riwayat pengembalian',
                                style: const TextStyle(color: Colors.white38, fontSize: 13),
                              ),
                            ],
                          ),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: _currentList.length + 1,
                          separatorBuilder: (_, __) => const SizedBox(height: 10),
                          itemBuilder: (context, index) {
                            if (index == _currentList.length) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  'Menampilkan ${_currentList.length} barang',
                                  style: const TextStyle(fontSize: 12, color: Colors.white38),
                                ),
                              );
                            }
                            final loan = _currentList[index];
                            final name = loan['item_name']?.toString() ?? '-';
                            final dueDate = _fmtDisplay(loan['due_date']?.toString());
                            final returnDate = _fmtDisplay(loan['return_date']?.toString());
                            final late = _isLate(loan);
                            final daysLeft = _daysLeft(loan);
                            final status = loan['status']?.toString() ?? '';
                            final isReturned = status == 'returned';
                            final isPending = status == 'pending';

                            final Color accent = isPending
                                ? const Color(0xFFF97316)
                                : isReturned
                                    ? const Color(0xFF10B981)
                                    : late
                                        ? const Color(0xFFEF4444)
                                        : const Color(0xFF4A6CF7);

                            return Container(
                              decoration: BoxDecoration(
                                color: _card,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(color: _cardBorder),
                                boxShadow: [
                                  BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 6, offset: const Offset(0, 2)),
                                ],
                              ),
                              child: IntrinsicHeight(
                                child: Row(
                                  children: [
                                    // Left color bar
                                    Container(
                                      width: 4,
                                      decoration: BoxDecoration(
                                        color: accent,
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(14),
                                          bottomLeft: Radius.circular(14),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    // Icon
                                    Container(
                                      width: 42,
                                      height: 42,
                                      decoration: BoxDecoration(
                                        color: accent.withValues(alpha: 0.15),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Icon(Icons.inventory_2_rounded, color: accent, size: 22),
                                    ),
                                    const SizedBox(width: 12),
                                    // Info
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 12),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(name,
                                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14)),
                                            const SizedBox(height: 3),
                                            if (isReturned)
                                              Text('Dikembalikan: $returnDate',
                                                  style: const TextStyle(fontSize: 11, color: Colors.white54))
                                            else if (isPending)
                                              const Text('Menunggu persetujuan admin',
                                                  style: TextStyle(fontSize: 11, color: Color(0xFFF97316), fontWeight: FontWeight.w600))
                                            else ...[
                                              Text('Jatuh tempo: $dueDate',
                                                  style: const TextStyle(fontSize: 11, color: Colors.white60)),
                                              const SizedBox(height: 2),
                                              Text(daysLeft,
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    color: late ? const Color(0xFFEF4444) : Colors.white38,
                                                    fontWeight: late ? FontWeight.w700 : FontWeight.normal,
                                                  )),
                                            ],
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    // Action
                                    Padding(
                                      padding: const EdgeInsets.only(right: 12),
                                      child: isReturned
                                          ? _StatusChip(text: 'Selesai', color: const Color(0xFF10B981))
                                          : isPending
                                              ? _StatusChip(text: 'Menunggu', color: const Color(0xFFF97316))
                                              : GestureDetector(
                                                  onTap: () async {
                                                    final returned = await Navigator.push<bool>(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (_) => DetailPengembalianBarangUserScreen(loan: loan),
                                                      ),
                                                    );
                                                    if (returned == true) _loadLoans();
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                                                    decoration: BoxDecoration(
                                                      color: const Color(0xFF4A6CF7),
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                    child: const Text('Kembalikan',
                                                        style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700)),
                                                  ),
                                                ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Helper widgets ─────────────────────────────────────────────────────────

class _Tab extends StatelessWidget {
  const _Tab({required this.text, required this.active, required this.onTap, this.color = const Color(0xFF4A6CF7)});
  final String text;
  final bool active;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 36,
          decoration: BoxDecoration(
            color: active ? color : const Color(0xFF161B22),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: active ? color : const Color(0xFF30363D)),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: active ? Colors.white : Colors.white54),
          ),
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.text, required this.color});
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(text, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w700)),
    );
  }
}
