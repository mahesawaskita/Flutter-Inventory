import 'package:flutter/material.dart';
import 'package:frontend/service/api_service.dart';
import 'package:frontend/service/auth_service.dart';

import 'detail_status_barang_user.dart';
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
  String? _filterStatus; // null=semua, 'active', 'returned', 'late'
  int _page = 1;
  String _username = '';
  static const _perPage = 5;

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
          setState(
            () => _myLoans =
                loans.map((e) => Map<String, dynamic>.from(e)).toList(),
          );
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
      return due.year == now.year &&
          due.month == now.month &&
          due.day == now.day;
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
      if (diff == 0) return 'Terlambat Besok';
      return '$diff hari lagi';
    } catch (_) {
      return '';
    }
  }

  // Semua yg sedang dipinjam (termasuk terlambat)
  int get _statActive =>
      _myLoans.where((l) => l['status'] == 'borrowed').length;
  int get _statReturned =>
      _myLoans.where((l) => l['status'] == 'returned').length;
  int get _statLate => _myLoans.where((l) => _isLate(l)).length;

  List<Map<String, dynamic>> get _filtered {
    var list = _myLoans.toList();

    if (_activeTab == 1) {
      list = list.where((l) => l['status'] == 'borrowed').toList();
    }

    if (_filterStatus == 'active') {
      list = list
          .where((l) => l['status'] == 'borrowed' && !_isLate(l))
          .toList();
    } else if (_filterStatus == 'late') {
      list = list.where((l) => _isLate(l)).toList();
    } else if (_filterStatus == 'returned') {
      list = list.where((l) => l['status'] == 'returned').toList();
    }

    if (_search.isNotEmpty) {
      list = list.where((l) {
        final name = (l['item_name'] ?? '').toString().toLowerCase();
        final user =
            (l['user_name'] ?? l['borrower_name'] ?? _username)
                .toString()
                .toLowerCase();
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
      _filtered.isEmpty
          ? 1
          : ((_filtered.length + _perPage - 1) / _perPage).ceil();

  String _fmtDisplay(String? s) {
    if (s == null) return '-';
    try {
      final d = DateTime.parse(s);
      const months = [
        'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
        'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des',
      ];
      return '${d.day} ${months[d.month - 1]} ${d.year}';
    } catch (_) {
      return s;
    }
  }

  String _borrowerName(Map<String, dynamic> loan) {
    final v =
        (loan['user_name'] ?? loan['borrower_name'] ?? '').toString().trim();
    return v.isNotEmpty ? v : (_username.isNotEmpty ? _username : '-');
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
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

    return UserPageScaffold(
      child: UserFramedPage(
        title: 'Status Barang',
        topIcon: const Icon(
          Icons.receipt_long_rounded,
          size: 46,
          color: Color(0xFF90B7E1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Stats ──────────────────────────────────────────
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _SummaryCard(
                    title: 'Sedang\nDipinjam',
                    value: '$_statActive',
                    subtitle: 'Barang',
                    color: const Color(0xFFDCE5FA),
                    icon: Icons.content_paste_rounded,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _SummaryCard(
                    title: 'Telah\nDikembalikan',
                    value: '$_statReturned',
                    subtitle: 'Barang',
                    color: const Color(0xFFE0F5E3),
                    icon: Icons.inventory_2_rounded,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _SummaryCard(
                    title: 'Terlambat\nDikembalikan',
                    value: '$_statLate',
                    subtitle: 'Barang',
                    color: const Color(0xFFFFE4D9),
                    icon: Icons.warning_amber_rounded,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // ── Tabs + Filter ──────────────────────────────────
            Row(
              children: [
                Expanded(
                  child: _SmallTab(
                    text: 'Semua',
                    active: _activeTab == 0,
                    showArrow: true,
                    onTap: () => setState(() {
                      _activeTab = 0;
                      _page = 1;
                    }),
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: _SmallTab(
                    text: 'Dipinjam',
                    active: _activeTab == 1,
                    onTap: () => setState(() {
                      _activeTab = 1;
                      _page = 1;
                    }),
                  ),
                ),
                const SizedBox(width: 6),
                _FilterButton(
                  hasFilter: _filterStatus != null,
                  onTap: _showFilterSheet,
                ),
              ],
            ),
            const SizedBox(height: 10),

            // ── Search ─────────────────────────────────────────
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
                    width: 18,
                    height: 18,
                    decoration: const BoxDecoration(
                      color: Color(0xFF9DE8F2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.search,
                      size: 13,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      style: const TextStyle(fontSize: 12),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        hintText: 'Cari barang atau peminjam...',
                        hintStyle: TextStyle(
                          fontSize: 12,
                          color: UserUi.textLight,
                        ),
                      ),
                      onChanged: (v) => setState(() {
                        _search = v.trim().toLowerCase();
                        _page = 1;
                      }),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // ── Loan list ──────────────────────────────────────
            if (_isLoading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: CircularProgressIndicator(color: UserUi.blue),
                ),
              )
            else if (paged.isEmpty)
              const Padding(
                padding: EdgeInsets.all(24),
                child: Center(
                  child: Text(
                    'Tidak ada data',
                    style: TextStyle(color: UserUi.textMuted),
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
                        builder: (_) =>
                            DetailStatusBarangUserScreen(loan: loan),
                      ),
                    ).then((_) => _loadLoans());
                  },
                );
              }),

            // ── Info + Pagination ──────────────────────────────
            if (!_isLoading && total > 0) ...[
              Padding(
                padding: const EdgeInsets.only(top: 2, bottom: 6),
                child: Text(
                  'Menampilkan ${paged.length} dari $total peminjaman',
                  style: const TextStyle(
                    fontSize: 11,
                    color: UserUi.textMuted,
                  ),
                ),
              ),
              if (_totalPages > 1)
                _Pagination(
                  currentPage: _page,
                  totalPages: _totalPages,
                  onPage: (p) => setState(() => _page = p),
                ),
              const SizedBox(height: 6),
            ],

          ],
        ),
      ),
    );
  }
}

// ─── Loan Card ────────────────────────────────────────────────────────────────

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

  @override
  Widget build(BuildContext context) {
    String statusText;
    Color statusBg;
    Color statusFg;

    if (isReturned) {
      statusText = 'Dikembalikan';
      statusBg = const Color(0xFFD8DEFF);
      statusFg = const Color(0xFF4D7BEE);
    } else if (isLate) {
      statusText = 'Telat Dikembalikan';
      statusBg = const Color(0xFFFFC2C0);
      statusFg = const Color(0xFFE05656);
    } else {
      statusText = 'Dipinjam';
      statusBg = const Color(0xFFF3D88B);
      statusFg = Colors.black87;
    }

    final Color timeColor = isLate
        ? const Color(0xFFE05656)
        : isDueToday
            ? const Color(0xFFFFA53B)
            : UserUi.textMuted;

    final IconData timeIcon =
        (isLate || isDueToday) ? Icons.warning_amber_rounded : Icons.access_time_rounded;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: UserSectionCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Row 1: thumb + name/borrower + pill/detail ──
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserProductThumb(
                  icon: Icons.inventory_2_rounded,
                  background: isLate
                      ? const Color(0xFFFFE0D7)
                      : const Color(0xFFE4E8FF),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // item name + status pill
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              itemName,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          UserPill(
                            text: statusText,
                            background: statusBg,
                            foreground: statusFg,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 7,
                              vertical: 3,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      // borrower name + Detail button
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              borrowerName,
                              style: const TextStyle(
                                fontSize: 11,
                                color: UserUi.textMuted,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          GestureDetector(
                            onTap: onDetail,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: UserUi.blue,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Detail',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(width: 2),
                                  Icon(
                                    Icons.chevron_right_rounded,
                                    size: 13,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // ── Dashed line for late items ──
            if (isLate) ...[
              const SizedBox(height: 6),
              _DashedRedLine(),
            ],

            const SizedBox(height: 6),

            // ── Date row ──
            Row(
              children: [
                Icon(
                  isReturned
                      ? Icons.check_circle_outline_rounded
                      : Icons.access_time_rounded,
                  size: 12,
                  color: UserUi.textMuted,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    isReturned
                        ? 'Dikembalikan: $returnDate'
                        : 'Batas Pengembalian $dueDate',
                    style: const TextStyle(
                      fontSize: 11,
                      color: UserUi.textMuted,
                    ),
                  ),
                ),
              ],
            ),

            // ── Time indicator ──
            if (!isReturned && timeIndicator.isNotEmpty) ...[
              const SizedBox(height: 2),
              Row(
                children: [
                  Icon(timeIcon, size: 12, color: timeColor),
                  const SizedBox(width: 4),
                  Text(
                    timeIndicator,
                    style: TextStyle(
                      fontSize: 11,
                      color: timeColor,
                      fontWeight: FontWeight.w700,
                    ),
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

// ─── Red Dashed Line ──────────────────────────────────────────────────────────

class _DashedRedLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) => CustomPaint(
        size: Size(constraints.maxWidth, 1.5),
        painter: _DashPainter(),
      ),
    );
  }
}

class _DashPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFE05656)
      ..strokeWidth = 1.5;
    const dashWidth = 5.0;
    const gapWidth = 4.0;
    double x = 0;
    while (x < size.width) {
      canvas.drawLine(Offset(x, 0), Offset((x + dashWidth).clamp(0, size.width), 0), paint);
      x += dashWidth + gapWidth;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

// ─── Summary Card ─────────────────────────────────────────────────────────────

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.color,
    required this.icon,
  });

  final String title;
  final String value;
  final String subtitle;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: UserUi.frameBorder),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: UserUi.textMuted),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    height: 1.3,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w900,
              height: 1.1,
            ),
          ),
          Text(subtitle, style: const TextStyle(fontSize: 11)),
        ],
      ),
    );
  }
}

// ─── Small Tab ────────────────────────────────────────────────────────────────

class _SmallTab extends StatelessWidget {
  const _SmallTab({
    required this.text,
    required this.active,
    required this.onTap,
    this.showArrow = false,
  });

  final String text;
  final bool active;
  final VoidCallback onTap;
  final bool showArrow;

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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showArrow && active) ...[
              const Icon(
                Icons.expand_more_rounded,
                size: 15,
                color: Colors.white,
              ),
              const SizedBox(width: 2),
            ],
            Flexible(
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  color: active ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Filter Button ────────────────────────────────────────────────────────────

class _FilterButton extends StatelessWidget {
  const _FilterButton({required this.hasFilter, required this.onTap});

  final bool hasFilter;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isActive = hasFilter;
    final fg = isActive ? Colors.white : Colors.black87;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 34,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: isActive ? UserUi.blue : const Color(0xFFF8F0F7),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isActive ? UserUi.blue : UserUi.softBorder,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.filter_list_rounded, size: 14, color: fg),
            const SizedBox(width: 4),
            Text(
              'Filter',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: fg,
              ),
            ),
            const SizedBox(width: 2),
            Icon(Icons.expand_more_rounded, size: 14, color: fg),
          ],
        ),
      ),
    );
  }
}

// ─── Filter Sheet ─────────────────────────────────────────────────────────────

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Filter Status',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 12),
            ..._options.map((opt) {
              // empty string means "semua" (null filter)
              final key = opt.$1.isEmpty ? null : opt.$1;
              final isSelected = current == key;
              return GestureDetector(
                onTap: () => onSelect(key),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFFEEF4FF)
                        : const Color(0xFFF8F1F7),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isSelected ? UserUi.blue : UserUi.softBorder,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        opt.$3,
                        size: 18,
                        color: isSelected ? UserUi.blue : UserUi.textMuted,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          opt.$2,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: isSelected ? UserUi.blue : Colors.black87,
                          ),
                        ),
                      ),
                      if (isSelected)
                        const Icon(
                          Icons.check_rounded,
                          size: 16,
                          color: UserUi.blue,
                        ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

// ─── Pagination ───────────────────────────────────────────────────────────────

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
        _PageBtn(
          icon: Icons.chevron_left_rounded,
          enabled: currentPage > 1,
          onTap: () => onPage(currentPage - 1),
        ),
        ...List.generate(totalPages, (i) {
          final p = i + 1;
          return _PageBtn(
            label: '$p',
            active: currentPage == p,
            onTap: () => onPage(p),
          );
        }),
        _PageBtn(
          icon: Icons.chevron_right_rounded,
          enabled: currentPage < totalPages,
          onTap: () => onPage(currentPage + 1),
        ),
      ],
    );
  }
}

class _PageBtn extends StatelessWidget {
  const _PageBtn({
    this.label,
    this.icon,
    this.active = false,
    this.enabled = true,
    required this.onTap,
  });

  final String? label;
  final IconData? icon;
  final bool active;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final fg = active
        ? Colors.white
        : enabled
            ? Colors.black87
            : UserUi.textMuted;

    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 3),
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: active
              ? UserUi.blue
              : enabled
                  ? const Color(0xFFF0EAF2)
                  : const Color(0xFFE8E8E8),
          borderRadius: BorderRadius.circular(6),
        ),
        alignment: Alignment.center,
        child: label != null
            ? Text(
                label!,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: fg,
                ),
              )
            : Icon(icon!, size: 16, color: fg),
      ),
    );
  }
}
