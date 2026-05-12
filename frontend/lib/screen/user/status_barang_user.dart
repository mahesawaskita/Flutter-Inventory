import 'package:flutter/material.dart';
import 'package:frontend/service/api_service.dart';
import 'package:frontend/service/auth_service.dart';

import 'user_ui.dart';

class StatusBarangUserScreen extends StatefulWidget {
  const StatusBarangUserScreen({super.key});

  @override
  State<StatusBarangUserScreen> createState() => _StatusBarangUserScreenState();
}

class _StatusBarangUserScreenState extends State<StatusBarangUserScreen> {
  List<Map<String, dynamic>> _myLoans = [];
  bool _isLoading = true;
  int _activeTab = 0; // 0=semua, 1=dipinjam
  String _search = '';

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

  int get _statActive => _myLoans.where((l) => l['status'] == 'active' && !_isLate(l)).length;
  int get _statReturned => _myLoans.where((l) => l['status'] == 'returned').length;
  int get _statLate => _myLoans.where((l) => _isLate(l)).length;

  List<Map<String, dynamic>> get _filtered {
    var list = _activeTab == 1
        ? _myLoans.where((l) => l['status'] == 'active').toList()
        : _myLoans;
    if (_search.isNotEmpty) {
      list = list.where((l) =>
          (l['item_name'] ?? '').toString().toLowerCase().contains(_search)).toList();
    }
    return list;
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

  @override
  Widget build(BuildContext context) {
    return UserPageScaffold(
      child: UserFramedPage(
        title: 'Status Barang',
        topIcon: const Icon(Icons.receipt_long_rounded, size: 46, color: Color(0xFF90B7E1)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Stats ──
            Row(
              children: [
                Expanded(child: _SummaryCard(
                  title: 'Sedang\nDipinjam',
                  value: '$_statActive',
                  subtitle: 'Barang',
                  color: const Color(0xFFDCE5FA),
                  icon: Icons.content_paste_rounded,
                )),
                const SizedBox(width: 8),
                Expanded(child: _SummaryCard(
                  title: 'Telah\nDikembalikan',
                  value: '$_statReturned',
                  subtitle: 'Barang',
                  color: const Color(0xFFE0F5E3),
                  icon: Icons.inventory_2_rounded,
                )),
                const SizedBox(width: 8),
                Expanded(child: _SummaryCard(
                  title: 'Terlambat',
                  value: '$_statLate',
                  subtitle: 'Barang',
                  color: const Color(0xFFFFE4D9),
                  icon: Icons.warning_amber_rounded,
                )),
              ],
            ),
            const SizedBox(height: 12),

            // ── Tabs ──
            Row(
              children: [
                Expanded(child: _SmallTab(text: 'Semua', active: _activeTab == 0, onTap: () => setState(() => _activeTab = 0))),
                const SizedBox(width: 8),
                Expanded(child: _SmallTab(text: 'Dipinjam', active: _activeTab == 1, onTap: () => setState(() => _activeTab = 1))),
              ],
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

            // ── Loans list ──
            if (_isLoading)
              const Center(child: Padding(
                padding: EdgeInsets.all(24),
                child: CircularProgressIndicator(color: UserUi.blue),
              ))
            else if (_filtered.isEmpty)
              const Padding(
                padding: EdgeInsets.all(24),
                child: Center(child: Text('Tidak ada data', style: TextStyle(color: UserUi.textMuted))),
              )
            else
              ..._filtered.map((loan) {
                final name = loan['item_name']?.toString() ?? '-';
                final dueDate = _fmtDisplay(loan['due_date']?.toString());
                final returnDate = _fmtDisplay(loan['return_date']?.toString());
                final late = _isLate(loan);
                final isReturned = loan['status'] == 'returned';

                String statusText;
                Color statusBg;
                Color statusFg;
                if (isReturned) {
                  statusText = 'Dikembalikan';
                  statusBg = const Color(0xFFD8DEFF);
                  statusFg = const Color(0xFF4D7BEE);
                } else if (late) {
                  statusText = 'Terlambat';
                  statusBg = const Color(0xFFFFC2C0);
                  statusFg = const Color(0xFFE05656);
                } else {
                  statusText = 'Dipinjam';
                  statusBg = const Color(0xFFF3D88B);
                  statusFg = Colors.black87;
                }

                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: UserSectionCard(
                    child: Row(
                      children: [
                        UserProductThumb(
                          icon: Icons.inventory_2_rounded,
                          background: late ? const Color(0xFFFFE0D7) : const Color(0xFFE4E8FF),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
                              const SizedBox(height: 4),
                              if (isReturned)
                                Text('Dikembalikan: $returnDate', style: const TextStyle(fontSize: 11, color: UserUi.textMuted))
                              else
                                Text('Jatuh tempo: $dueDate', style: const TextStyle(fontSize: 11, color: UserUi.textMuted)),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        UserPill(text: statusText, background: statusBg, foreground: statusFg),
                      ],
                    ),
                  ),
                );
              }),

            if (!_isLoading && _myLoans.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 8),
                child: Text(
                  'Menampilkan ${_filtered.length} dari ${_myLoans.length} peminjaman',
                  style: const TextStyle(fontSize: 12, color: UserUi.textMuted),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.title, required this.value, required this.subtitle, required this.color, required this.icon});
  final String title, value, subtitle;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 92,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: UserUi.frameBorder),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            children: [
              Icon(icon, size: 22, color: UserUi.textMuted),
              const SizedBox(width: 6),
              Expanded(child: Text(title, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700))),
            ],
          ),
          const Spacer(),
          Text(value, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900)),
          Text(subtitle, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

class _SmallTab extends StatelessWidget {
  const _SmallTab({required this.text, required this.active, required this.onTap});
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
          color: active ? UserUi.blue : const Color(0xFFF8F0F7),
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: active ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
