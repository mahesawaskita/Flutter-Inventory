import 'package:flutter/material.dart';
import 'package:frontend/service/auth_service.dart';

import 'peminjaman_barang_user.dart';

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

  static const _bg = Color(0xFF0D1117);
  static const _purple = Color(0xFF8A20F7);
  static const _blue = Color(0xFF4A6CF7);
  static const _green = Color(0xFF10B981);
  static const _red = Color(0xFFEF4444);
  static const _orange = Color(0xFFF97316);

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
      const m = ['Jan','Feb','Mar','Apr','Mei','Jun','Jul','Agu','Sep','Okt','Nov','Des'];
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
    final purpose = (loan['purpose'] ?? loan['notes'] ?? '').toString().trim();

    final Color statusColor;
    final String statusLabel;
    final IconData statusIcon;

    if (isReturned) {
      statusColor = _green;
      statusLabel = 'Dikembalikan';
      statusIcon = Icons.check_circle_rounded;
    } else if (late) {
      statusColor = _red;
      statusLabel = 'Terlambat $daysLate Hari';
      statusIcon = Icons.warning_amber_rounded;
    } else {
      statusColor = _orange;
      statusLabel = 'Dipinjam';
      statusIcon = Icons.swap_horiz_rounded;
    }

    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // ── Header ──────────────────────────────────────────────
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
                          'Detail Status Barang',
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        const Spacer(),
                        const SizedBox(width: 38),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // ── Status Banner ────────────────────────────────────────
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [BoxShadow(color: statusColor.withValues(alpha: 0.4), blurRadius: 16, offset: const Offset(0, 6))],
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            right: -10,
                            top: -10,
                            child: Icon(statusIcon, size: 100, color: Colors.white.withValues(alpha: 0.12)),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Icon(statusIcon, color: Colors.white, size: 26),
                              ),
                              const SizedBox(height: 14),
                              Text(
                                itemName,
                                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  statusLabel,
                                  style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ── Info Peminjam ────────────────────────────────────────
                    _SectionLabel(label: 'Info Peminjam'),
                    const SizedBox(height: 10),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 46,
                            height: 46,
                            decoration: BoxDecoration(
                              color: _blue.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.person_rounded, color: _blue, size: 24),
                          ),
                          const SizedBox(width: 14),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Peminjam',
                                style: TextStyle(fontSize: 11, color: Colors.white.withValues(alpha: 0.5)),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                borrowerName,
                                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ── Detail Peminjaman ────────────────────────────────────
                    _SectionLabel(label: 'Detail Peminjaman'),
                    const SizedBox(height: 10),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
                      ),
                      child: Column(
                        children: [
                          _DetailRow(
                            icon: Icons.inventory_2_rounded,
                            label: 'Nama Barang',
                            value: itemName,
                            iconColor: _purple,
                            isFirst: true,
                          ),
                          _DetailRow(
                            icon: Icons.login_rounded,
                            label: 'Tanggal Dipinjam',
                            value: borrowDate,
                            iconColor: _blue,
                          ),
                          _DetailRow(
                            icon: Icons.logout_rounded,
                            label: 'Tanggal Kembali',
                            value: dueDate,
                            iconColor: _orange,
                          ),
                          _DetailRow(
                            icon: Icons.info_outline_rounded,
                            label: 'Status',
                            value: statusLabel,
                            iconColor: statusColor,
                            isStatus: true,
                            statusColor: statusColor,
                          ),
                          if (isReturned)
                            _DetailRow(
                              icon: Icons.assignment_return_rounded,
                              label: 'Tanggal Dikembalikan',
                              value: returnDate,
                              iconColor: _green,
                              isLast: !purpose.isNotEmpty,
                            ),
                          if (purpose.isNotEmpty)
                            _NoteRow(note: purpose),
                        ],
                      ),
                    ),

                    // ── Pinjam Barang button (hanya jika sudah dikembalikan) ──
                    if (isReturned) ...[
                      const SizedBox(height: 24),
                      GestureDetector(
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
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: _purple,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [BoxShadow(color: _purple.withValues(alpha: 0.4), blurRadius: 14, offset: const Offset(0, 5))],
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                right: -10,
                                top: -10,
                                child: Icon(Icons.swap_horiz_rounded, size: 90, color: Colors.white.withValues(alpha: 0.1)),
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 46,
                                    height: 46,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.2),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Icon(Icons.swap_horiz_rounded, color: Colors.white, size: 26),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Pinjam Barang',
                                          style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          'Pinjam barang ini kembali',
                                          style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 11),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text('Buka', style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 11, fontWeight: FontWeight.w600)),
                                      const SizedBox(width: 3),
                                      Icon(Icons.arrow_forward_rounded, color: Colors.white.withValues(alpha: 0.85), size: 14),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Section Label ─────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
    );
  }
}

// ── Detail Row ────────────────────────────────────────────────────────────────

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.iconColor,
    this.isFirst = false,
    this.isLast = false,
    this.isStatus = false,
    this.statusColor,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color iconColor;
  final bool isFirst;
  final bool isLast;
  final bool isStatus;
  final Color? statusColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(bottom: BorderSide(color: Colors.white.withValues(alpha: 0.08))),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 16, color: iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: TextStyle(fontSize: 13, color: Colors.white.withValues(alpha: 0.6)),
            ),
          ),
          if (isStatus && statusColor != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor!.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: statusColor!.withValues(alpha: 0.4)),
              ),
              child: Text(
                value,
                style: TextStyle(color: statusColor, fontSize: 11, fontWeight: FontWeight.w700),
              ),
            )
          else
            Text(
              value,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white),
            ),
        ],
      ),
    );
  }
}

// ── Note Row ──────────────────────────────────────────────────────────────────

class _NoteRow extends StatelessWidget {
  const _NoteRow({required this.note});
  final String note;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.08))),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: const Color(0xFFFFC400).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.notes_rounded, size: 16, color: Color(0xFFFFC400)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Catatan',
                  style: TextStyle(fontSize: 13, color: Colors.white.withValues(alpha: 0.6)),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                  ),
                  child: Text(
                    note,
                    style: TextStyle(fontSize: 13, color: Colors.white.withValues(alpha: 0.8)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
