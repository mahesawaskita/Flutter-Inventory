import 'package:flutter/material.dart';
import 'package:frontend/service/api_service.dart';
import 'package:frontend/service/auth_service.dart';

import 'detail_status_barang_user.dart';

class StatusBarangUserScreen extends StatefulWidget {
  const StatusBarangUserScreen({super.key});

  @override
  State<StatusBarangUserScreen> createState() => _StatusBarangUserScreenState();
}

class _StatusBarangUserScreenState extends State<StatusBarangUserScreen> {
  List<Map<String, dynamic>> _myLoans = [];
  bool _isLoading = true;
  int _activeTab = 0;
  String _search = '';
  String? _filterStatus;
  int _page = 1;
  String _username = '';
  static const _perPage = 5;

  static const _bg = Color(0xFF0D1117);
  static const _purple = Color(0xFF8A20F7);
  static const _blue = Color(0xFF4A6CF7);
  static const _green = Color(0xFF10B981);
  static const _red = Color(0xFFEF4444);

  @override
  void initState() {
    super.initState();
    _loadLoans();
  }

  Future<void> _loadLoans() async {
    setState(() => _isLoading = true);
    try {
      final token = await AuthService.getToken();
      final username = await AuthService.getUsername();
      if (mounted) setState(() => _username = username ?? '');
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
      final due = DateTime.parse(loan['due_date'].toString());
      final now = DateTime.now();
      return DateTime(due.year, due.month, due.day)
          .isBefore(DateTime(now.year, now.month, now.day));
    } catch (_) {
      return false;
    }
  }

  bool _isDueToday(Map<String, dynamic> loan) {
    if (loan['status'] != 'borrowed') return false;
    try {
      final due = DateTime.parse(loan['due_date'].toString());
      final now = DateTime.now();
      return due.year == now.year && due.month == now.month && due.day == now.day;
    } catch (_) {
      return false;
    }
  }

  String _timeIndicator(Map<String, dynamic> loan) {
    if (loan['status'] == 'returned') return '';
    try {
      final due = DateTime.parse(loan['due_date'].toString());
      final now = DateTime.now();
      final dueDay = DateTime(due.year, due.month, due.day);
      final today = DateTime(now.year, now.month, now.day);
      final diff = dueDay.difference(today).inDays;
      if (diff < 0) return 'Terlambat ${-diff} hari';
      if (diff == 0) return 'Jatuh tempo hari ini';
      return '$diff hari lagi';
    } catch (_) {
      return '';
    }
  }

  int get _statActive => _myLoans.where((l) => l['status'] == 'borrowed').length;
  int get _statReturned => _myLoans.where((l) => l['status'] == 'returned').length;
  int get _statLate => _myLoans.where((l) => _isLate(l)).length;

  List<Map<String, dynamic>> get _filtered {
    var list = _myLoans.toList();
    if (_activeTab == 1) list = list.where((l) => l['status'] == 'borrowed').toList();
    if (_filterStatus == 'active') {
      list = list.where((l) => l['status'] == 'borrowed' && !_isLate(l)).toList();
    } else if (_filterStatus == 'late') {
      list = list.where((l) => _isLate(l)).toList();
    } else if (_filterStatus == 'returned') {
      list = list.where((l) => l['status'] == 'returned').toList();
    }
    if (_search.isNotEmpty) {
      list = list.where((l) {
        final name = (l['item_name'] ?? '').toString().toLowerCase();
        final user = (l['user_name'] ?? l['borrower_name'] ?? _username).toString().toLowerCase();
        return name.contains(_search) || user.contains(_search);
      }).toList();
    }
    return list;
  }

  List<Map<String, dynamic>> get _pagedList {
    final all = _filtered;
    final start = (_page - 1) * _perPage;
    if (start >= all.length) return [];
    final end = (start + _perPage).clamp(0, all.length);
    return all.sublist(start, end);
  }

  int get _totalPages =>
      _filtered.isEmpty ? 1 : ((_filtered.length + _perPage - 1) / _perPage).ceil();

  String _fmtDisplay(String? s) {
    if (s == null) return '-';
    try {
      final d = DateTime.parse(s);
      const months = ['Jan','Feb','Mar','Apr','Mei','Jun','Jul','Agu','Sep','Okt','Nov','Des'];
      return '${d.day} ${months[d.month - 1]} ${d.year}';
    } catch (_) {
      return s;
    }
  }

  String _borrowerName(Map<String, dynamic> loan) {
    final v = (loan['user_name'] ?? loan['borrower_name'] ?? '').toString().trim();
    return v.isNotEmpty ? v : (_username.isNotEmpty ? _username : '-');
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF161B27),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => _FilterSheet(
        current: _filterStatus,
        onSelect: (val) {
          setState(() {
            _filterStatus = val;
            _page = 1;
          });
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final paged = _pagedList;
    final total = _filtered.length;

    return Scaffold(
      backgroundColor: _bg,
      body: RefreshIndicator(
        onRefresh: _loadLoans,
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
                            'Status Barang',
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
                              label: 'Sedang\nDipinjam',
                              value: _isLoading ? null : _statActive,
                              icon: Icons.content_paste_rounded,
                              color: _blue,
                            )),
                            const SizedBox(width: 12),
                            Expanded(child: _StatCard(
                              label: 'Dikembalikan',
                              value: _isLoading ? null : _statReturned,
                              icon: Icons.inventory_2_rounded,
                              color: _green,
                            )),
                            const SizedBox(width: 12),
                            Expanded(child: _StatCard(
                              label: 'Terlambat',
                              value: _isLoading ? null : _statLate,
                              icon: Icons.warning_amber_rounded,
                              color: _red,
                              highlight: !_isLoading && _statLate > 0,
                            )),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // ── Tabs + Filter ─────────────────────────────────────
                      Row(
                        children: [
                          Expanded(child: _TabBtn(
                            text: 'Semua',
                            active: _activeTab == 0,
                            onTap: () => setState(() { _activeTab = 0; _page = 1; }),
                          )),
                          const SizedBox(width: 8),
                          Expanded(child: _TabBtn(
                            text: 'Dipinjam',
                            active: _activeTab == 1,
                            onTap: () => setState(() { _activeTab = 1; _page = 1; }),
                          )),
                          const SizedBox(width: 8),
                          _FilterBtn(
                            hasFilter: _filterStatus != null,
                            onTap: _showFilterSheet,
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),

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
                                  hintText: 'Cari barang atau peminjam...',
                                  hintStyle: TextStyle(fontSize: 13, color: Colors.white.withValues(alpha: 0.35)),
                                ),
                                onChanged: (v) => setState(() { _search = v.trim().toLowerCase(); _page = 1; }),
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
                            'Riwayat Peminjaman',
                            style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          if (!_isLoading)
                            Text(
                              '$total data',
                              style: TextStyle(color: Colors.white.withValues(alpha: 0.45), fontSize: 12),
                            ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // ── Loan list ─────────────────────────────────────────
                      if (_isLoading)
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(32),
                            child: CircularProgressIndicator(color: _purple),
                          ),
                        )
                      else if (paged.isEmpty)
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 32),
                            child: Column(
                              children: [
                                Icon(Icons.receipt_long_outlined, size: 52, color: Colors.white.withValues(alpha: 0.25)),
                                const SizedBox(height: 12),
                                Text(
                                  'Tidak ada data peminjaman',
                                  style: TextStyle(color: Colors.white.withValues(alpha: 0.45), fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                        )
                      else
                        ...paged.map((loan) {
                          final late = _isLate(loan);
                          return _LoanCard(
                            key: ValueKey(loan['id']),
                            itemName: loan['item_name']?.toString() ?? '-',
                            borrowerName: _borrowerName(loan),
                            isLate: late,
                            isDueToday: _isDueToday(loan),
                            isReturned: loan['status'] == 'returned',
                            timeIndicator: _timeIndicator(loan),
                            dueDate: _fmtDisplay(loan['due_date']?.toString()),
                            returnDate: _fmtDisplay(loan['return_date']?.toString()),
                            onDetail: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => DetailStatusBarangUserScreen(loan: loan),
                                ),
                              ).then((_) => _loadLoans());
                            },
                          );
                        }),

                      // ── Info + Pagination ──────────────────────────────────
                      if (!_isLoading && total > 0) ...[
                        Padding(
                          padding: const EdgeInsets.only(top: 4, bottom: 8),
                          child: Text(
                            'Menampilkan ${paged.length} dari $total peminjaman',
                            style: TextStyle(fontSize: 11, color: Colors.white.withValues(alpha: 0.4)),
                          ),
                        ),
                        if (_totalPages > 1)
                          _Pagination(
                            currentPage: _page,
                            totalPages: _totalPages,
                            onPage: (p) => setState(() => _page = p),
                          ),
                        const SizedBox(height: 8),
                      ],

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

// ── Stat Card ─────────────────────────────────────────────────────────────────

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

// ── Tab Button ────────────────────────────────────────────────────────────────

class _TabBtn extends StatelessWidget {
  const _TabBtn({required this.text, required this.active, required this.onTap});

  final String text;
  final bool active;
  final VoidCallback onTap;

  static const _blue = Color(0xFF4A6CF7);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 40,
        decoration: BoxDecoration(
          color: active ? _blue : Colors.white.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: active ? _blue : Colors.white.withValues(alpha: 0.15)),
          boxShadow: active ? [BoxShadow(color: _blue.withValues(alpha: 0.4), blurRadius: 8, offset: const Offset(0, 2))] : null,
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: active ? Colors.white : Colors.white60,
          ),
        ),
      ),
    );
  }
}

// ── Filter Button ─────────────────────────────────────────────────────────────

class _FilterBtn extends StatelessWidget {
  const _FilterBtn({required this.hasFilter, required this.onTap});

  final bool hasFilter;
  final VoidCallback onTap;

  static const _blue = Color(0xFF4A6CF7);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: hasFilter ? _blue : Colors.white.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: hasFilter ? _blue : Colors.white.withValues(alpha: 0.15)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.filter_list_rounded, size: 15, color: hasFilter ? Colors.white : Colors.white60),
            const SizedBox(width: 5),
            Text(
              'Filter',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: hasFilter ? Colors.white : Colors.white60),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Loan Card ─────────────────────────────────────────────────────────────────

class _LoanCard extends StatelessWidget {
  const _LoanCard({
    super.key,
    required this.itemName,
    required this.borrowerName,
    required this.isLate,
    required this.isDueToday,
    required this.isReturned,
    required this.timeIndicator,
    required this.dueDate,
    required this.returnDate,
    required this.onDetail,
  });

  final String itemName;
  final String borrowerName;
  final bool isLate;
  final bool isDueToday;
  final bool isReturned;
  final String timeIndicator;
  final String dueDate;
  final String returnDate;
  final VoidCallback onDetail;

  static const _blue = Color(0xFF4A6CF7);
  static const _green = Color(0xFF10B981);
  static const _red = Color(0xFFEF4444);
  static const _orange = Color(0xFFF97316);

  @override
  Widget build(BuildContext context) {
    final Color statusColor;
    final String statusText;

    if (isReturned) {
      statusColor = _green;
      statusText = 'Dikembalikan';
    } else if (isLate) {
      statusColor = _red;
      statusText = 'Terlambat';
    } else {
      statusColor = _orange;
      statusText = 'Dipinjam';
    }

    final Color timeColor = isLate ? _red : isDueToday ? _orange : Colors.white54;
    final IconData timeIcon = (isLate || isDueToday) ? Icons.warning_amber_rounded : Icons.access_time_rounded;
    final Color thumbColor = isLate ? _red : isReturned ? _green : _blue;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isLate
              ? _red.withValues(alpha: 0.07)
              : Colors.white.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isLate
                ? _red.withValues(alpha: 0.35)
                : Colors.white.withValues(alpha: 0.12),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon thumb
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: thumbColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.inventory_2_rounded, color: thumbColor, size: 24),
                ),
                const SizedBox(width: 12),
                // Name + borrower
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        itemName,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          Icon(Icons.person_outline_rounded, size: 12, color: Colors.white.withValues(alpha: 0.45)),
                          const SizedBox(width: 4),
                          Text(
                            borrowerName,
                            style: TextStyle(fontSize: 11, color: Colors.white.withValues(alpha: 0.5)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Status badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: statusColor.withValues(alpha: 0.4)),
                  ),
                  child: Text(
                    statusText,
                    style: TextStyle(color: statusColor, fontSize: 10, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Divider
            Divider(color: Colors.white.withValues(alpha: 0.08), height: 1),

            const SizedBox(height: 10),

            // Date info + detail button
            Row(
              children: [
                Icon(
                  isReturned ? Icons.check_circle_outline_rounded : Icons.calendar_today_rounded,
                  size: 13,
                  color: Colors.white.withValues(alpha: 0.4),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    isReturned
                        ? 'Dikembalikan: $returnDate'
                        : 'Jatuh tempo: $dueDate',
                    style: TextStyle(fontSize: 11, color: Colors.white.withValues(alpha: 0.5)),
                  ),
                ),
                GestureDetector(
                  onTap: onDetail,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: _blue,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [BoxShadow(color: _blue.withValues(alpha: 0.4), blurRadius: 6, offset: const Offset(0, 2))],
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Detail', style: TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.w700)),
                        SizedBox(width: 3),
                        Icon(Icons.chevron_right_rounded, size: 13, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Time indicator
            if (!isReturned && timeIndicator.isNotEmpty) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(timeIcon, size: 13, color: timeColor),
                  const SizedBox(width: 5),
                  Text(
                    timeIndicator,
                    style: TextStyle(fontSize: 11, color: timeColor, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ── Filter Sheet ──────────────────────────────────────────────────────────────

class _FilterSheet extends StatelessWidget {
  const _FilterSheet({required this.current, required this.onSelect});

  final String? current;
  final ValueChanged<String?> onSelect;

  static const _options = [
    ('', 'Semua Status', Icons.list_rounded),
    ('active', 'Sedang Dipinjam', Icons.content_paste_rounded),
    ('returned', 'Dikembalikan', Icons.inventory_2_rounded),
    ('late', 'Terlambat', Icons.warning_amber_rounded),
  ];

  static const _blue = Color(0xFF4A6CF7);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Filter Status',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.white),
                ),
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
            const SizedBox(height: 16),
            ..._options.map((opt) {
              final key = opt.$1.isEmpty ? null : opt.$1;
              final isSelected = current == key;
              return GestureDetector(
                onTap: () => onSelect(key),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: isSelected ? _blue.withValues(alpha: 0.15) : Colors.white.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? _blue : Colors.white.withValues(alpha: 0.12),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(opt.$3, size: 18, color: isSelected ? _blue : Colors.white54),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          opt.$2,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : Colors.white70,
                          ),
                        ),
                      ),
                      if (isSelected)
                        const Icon(Icons.check_rounded, size: 16, color: _blue),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}

// ── Pagination ────────────────────────────────────────────────────────────────

class _Pagination extends StatelessWidget {
  const _Pagination({
    required this.currentPage,
    required this.totalPages,
    required this.onPage,
  });

  final int currentPage;
  final int totalPages;
  final ValueChanged<int> onPage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _PageBtn(icon: Icons.chevron_left_rounded, enabled: currentPage > 1, onTap: () => onPage(currentPage - 1)),
        ...List.generate(totalPages, (i) {
          final p = i + 1;
          return _PageBtn(label: '$p', active: currentPage == p, onTap: () => onPage(p));
        }),
        _PageBtn(icon: Icons.chevron_right_rounded, enabled: currentPage < totalPages, onTap: () => onPage(currentPage + 1)),
      ],
    );
  }
}

class _PageBtn extends StatelessWidget {
  const _PageBtn({this.label, this.icon, this.active = false, this.enabled = true, required this.onTap});

  final String? label;
  final IconData? icon;
  final bool active;
  final bool enabled;
  final VoidCallback onTap;

  static const _blue = Color(0xFF4A6CF7);

  @override
  Widget build(BuildContext context) {
    final fg = active ? Colors.white : enabled ? Colors.white70 : Colors.white30;
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 3),
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: active ? _blue : Colors.white.withValues(alpha: enabled ? 0.08 : 0.04),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: active ? _blue : Colors.white.withValues(alpha: 0.12)),
        ),
        alignment: Alignment.center,
        child: label != null
            ? Text(label!, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: fg))
            : Icon(icon!, size: 16, color: fg),
      ),
    );
  }
}
