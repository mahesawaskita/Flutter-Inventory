import 'package:flutter/material.dart';
import 'package:frontend/service/auth_service.dart';

import 'peminjaman_barang_user.dart';
import 'user_ui.dart';

class DetailStatusBarangUserScreen extends StatefulWidget {
  final Map<String, dynamic> loan;

  const DetailStatusBarangUserScreen({super.key, required this.loan});

  @override
  State<DetailStatusBarangUserScreen> createState() =>
      _DetailStatusBarangUserScreenState();
}

class _DetailStatusBarangUserScreenState
    extends State<DetailStatusBarangUserScreen> {
  String _username = '';

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    final name = await AuthService.getUsername();
    if (mounted) setState(() => _username = name ?? '');
  }

  bool _isLate() {
    if (widget.loan['status'] != 'borrowed') return false;
    try {
      final due = DateTime.parse(widget.loan['due_date'].toString());
      final now = DateTime.now();
      return DateTime(due.year, due.month, due.day)
          .isBefore(DateTime(now.year, now.month, now.day));
    } catch (_) {
      return false;
    }
  }

  int _daysLate() {
    try {
      final due = DateTime.parse(widget.loan['due_date'].toString());
      final now = DateTime.now();
      final dueDay = DateTime(due.year, due.month, due.day);
      final today = DateTime(now.year, now.month, now.day);
      return today.difference(dueDay).inDays;
    } catch (_) {
      return 0;
    }
  }

  String _fmtDisplay(String? s) {
    if (s == null || s.isEmpty) return '-';
    try {
      final d = DateTime.parse(s);
      const m = [
        'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
        'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des',
      ];
      return '${d.day} ${m[d.month - 1]} ${d.year}';
    } catch (_) {
      return s;
    }
  }

  @override
  Widget build(BuildContext context) {
    final loan = widget.loan;
    final itemName = loan['item_name']?.toString() ?? '-';
    final raw = (loan['user_name'] ?? loan['borrower_name'] ?? '').toString().trim();
    final borrowerName = raw.isNotEmpty ? raw : (_username.isNotEmpty ? _username : '-');
    final status = loan['status']?.toString() ?? 'borrowed';
    final isReturned = status == 'returned';
    final late = _isLate();
    final daysLate = late ? _daysLate() : 0;

    final borrowDate = _fmtDisplay(loan['borrow_date']?.toString());
    final dueDate = _fmtDisplay(loan['due_date']?.toString());
    final returnDate = _fmtDisplay(loan['return_date']?.toString());
    final purpose =
        (loan['purpose'] ?? loan['notes'] ?? '').toString().trim();

    String statusLabel;
    Color statusBg;
    Color statusFg;
    if (isReturned) {
      statusLabel = 'Dikembalikan';
      statusBg = const Color(0xFFD8DEFF);
      statusFg = const Color(0xFF4D7BEE);
    } else if (late) {
      statusLabel = 'Terlambat $daysLate Hari';
      statusBg = const Color(0xFFFFA53B);
      statusFg = Colors.white;
    } else {
      statusLabel = 'Dipinjam';
      statusBg = const Color(0xFFF3D88B);
      statusFg = Colors.black87;
    }

    return UserPageScaffold(
      child: UserFramedPage(
        title: 'Detail Status Barang',
        topIcon: const Icon(Icons.inventory_2_rounded,
            size: 48, color: Color(0xFF4B4B4B)),
        child: Column(
          children: [
            // ── Header card: item + borrower + date + status ──
            UserSectionCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        UserProductThumb(
                          icon: Icons.inventory_2_rounded,
                          background: late
                              ? const Color(0xFFFFE0D7)
                              : const Color(0xFFF3EEF3),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text.rich(
                            TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'Nama Barang\n',
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                                TextSpan(
                                  text: itemName,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w900),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(height: 1, color: UserUi.softBorder),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 16,
                              backgroundColor: Color(0xFFE8EEF8),
                              child: Icon(Icons.person,
                                  size: 18, color: Color(0xFF5A6C91)),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: 'Peminjam\n',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    TextSpan(
                                      text: borrowerName,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.calendar_month_rounded),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text('$borrowDate - $dueDate'),
                            ),
                            UserPill(
                              text: statusLabel,
                              background: statusBg,
                              foreground: statusFg,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // ── Detail peminjaman card ──
            UserSectionCard(
              padding: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    color: const Color(0xFFF7F0F6),
                    child: const Row(
                      children: [
                        Icon(Icons.fact_check_rounded,
                            color: Color(0xFF7ABB23)),
                        SizedBox(width: 8),
                        Text('Detail Peminjaman',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w900)),
                      ],
                    ),
                  ),
                  _DetailRow(
                    icon: Icons.person_outline_rounded,
                    label: 'Nama Peminjam',
                    value: borrowerName,
                  ),
                  _DetailRow(
                    icon: Icons.calendar_month_rounded,
                    label: 'Tanggal Dipinjam',
                    value: borrowDate,
                  ),
                  _DetailRow(
                    icon: Icons.calendar_month_rounded,
                    label: 'Tanggal Kembali',
                    value: dueDate,
                  ),
                  _DetailRow(
                    icon: Icons.info_outline_rounded,
                    label: 'Status',
                    value: statusLabel,
                    isBadge: true,
                    badgeText: statusLabel,
                    badgeBackground: statusBg,
                    badgeForeground: statusFg,
                  ),
                  if (isReturned)
                    _DetailRow(
                      icon: Icons.assignment_return_rounded,
                      label: 'Tanggal Dikembalikan',
                      value: returnDate,
                    ),
                  if (purpose.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.notes_rounded,
                              color: Color(0xFFFFC400), size: 30),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 10),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF9F4F8),
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: UserUi.softBorder),
                              ),
                              child: Text(purpose),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),

            // ── Tombol Pinjam Barang (hanya jika sudah dikembalikan) ──
            if (isReturned) ...[
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: UserPrimaryButton(
                  text: 'Pinjam Barang',
                  icon: Icons.arrow_forward_rounded,
                  onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PeminjamanBarangUserScreen(
                        selectedItem: {
                          'id': widget.loan['item_id'],
                          'name': widget.loan['item_name'],
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],

            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
    this.isBadge = false,
    this.badgeText,
    this.badgeBackground,
    this.badgeForeground,
  });

  final IconData icon;
  final String label;
  final String value;
  final bool isBadge;
  final String? badgeText;
  final Color? badgeBackground;
  final Color? badgeForeground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: UserUi.softBorder)),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF444444)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(label, style: const TextStyle(fontSize: 14)),
          ),
          if (isBadge && badgeText != null)
            UserPill(
              text: badgeText!,
              background: badgeBackground ?? UserUi.blue.withValues(alpha: 0.2),
              foreground: badgeForeground ?? UserUi.blue,
            )
          else
            Text(value,
                style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w800)),
          const SizedBox(width: 4),
          const Icon(Icons.chevron_right_rounded),
        ],
      ),
    );
  }
}
