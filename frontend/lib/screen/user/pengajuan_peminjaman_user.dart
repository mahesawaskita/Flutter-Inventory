import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/service/api_service.dart';
import 'package:frontend/service/auth_service.dart';

class PengajuanPeminjamanUserScreen extends StatefulWidget {
  const PengajuanPeminjamanUserScreen({super.key, this.item});

  final Map<String, dynamic>? item;

  @override
  State<PengajuanPeminjamanUserScreen> createState() =>
      _PengajuanPeminjamanUserScreenState();
}

class _PengajuanPeminjamanUserScreenState
    extends State<PengajuanPeminjamanUserScreen> {
  final _qtyController = TextEditingController(text: '1');

  DateTime _borrowDate = DateTime.now();
  DateTime _returnDate = DateTime.now().add(const Duration(days: 7));
  bool _isSubmitting = false;

  static const _bg = Color(0xFF0D1117);
  static const _purple = Color(0xFF8A20F7);
  static const _blue = Color(0xFF4A6CF7);
  static const _green = Color(0xFF10B981);
  static const _orange = Color(0xFFF97316);

  @override
  void dispose() {
    _qtyController.dispose();
    super.dispose();
  }

  // ── Helpers ────────────────────────────────────────────────────────────────

  String _fmtDate(DateTime d) {
    const months = ['Jan','Feb','Mar','Apr','Mei','Jun','Jul','Agu','Sep','Okt','Nov','Des'];
    return '${d.day} ${months[d.month - 1]} ${d.year}';
  }

  String _isoDate(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  Future<void> _pickDate({required bool isBorrow}) async {
    final initial = isBorrow ? _borrowDate : _returnDate;
    final first = isBorrow ? DateTime.now() : _borrowDate.add(const Duration(days: 1));
    final picked = await showDatePicker(
      context: context,
      initialDate: initial.isBefore(first) ? first : initial,
      firstDate: first,
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: const ColorScheme.light(primary: _blue),
        ),
        child: child!,
      ),
    );
    if (picked == null || !mounted) return;
    setState(() {
      if (isBorrow) {
        _borrowDate = picked;
        if (_returnDate.isBefore(_borrowDate.add(const Duration(days: 1)))) {
          _returnDate = _borrowDate.add(const Duration(days: 7));
        }
      } else {
        _returnDate = picked;
      }
    });
  }

  Future<void> _submit() async {
    final item = widget.item;
    if (item == null) return;

    final qty = int.tryParse(_qtyController.text.trim()) ?? 0;
    final stock = (item['stock'] as num?)?.toInt() ?? 0;

    if (qty <= 0) {
      _showSnack('Jumlah harus lebih dari 0', isError: true);
      return;
    }
    if (qty > stock) {
      _showSnack('Jumlah melebihi stok tersedia ($stock)', isError: true);
      return;
    }

    setState(() => _isSubmitting = true);
    try {
      final token = await AuthService.getToken();
      if (token == null) {
        _showSnack('Sesi berakhir. Silakan login ulang.', isError: true);
        return;
      }

      final result = await ApiService.createLoan(token, {
        'item_id': item['id'],
        'borrow_date': _isoDate(_borrowDate),
        'due_date': _isoDate(_returnDate),
        'quantity': qty,
      });

      if (!mounted) return;

      if (result['success'] == true) {
        _showSnack('Pengajuan berhasil! Menunggu persetujuan admin.');
        await Future.delayed(const Duration(milliseconds: 1200));
        if (mounted) Navigator.of(context).pop(true);
      } else {
        _showSnack(result['message'] ?? 'Gagal mengajukan peminjaman', isError: true);
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  void _showSnack(String msg, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: isError ? const Color(0xFFEF4444) : _green,
    ));
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final stock = (item?['stock'] as num?)?.toInt() ?? 0;
    final duration = _returnDate.difference(_borrowDate).inDays;

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
                          'Pengajuan Peminjaman',
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        const Spacer(),
                        const SizedBox(width: 38),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // ── Item Info ────────────────────────────────────────────
                    if (item != null) ...[
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: _purple,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [BoxShadow(color: _purple.withValues(alpha: 0.4), blurRadius: 16, offset: const Offset(0, 6))],
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              right: -10,
                              top: -10,
                              child: Icon(Icons.inventory_2_rounded, size: 100, color: Colors.white.withValues(alpha: 0.12)),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 46,
                                  height: 46,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(Icons.inventory_2_rounded, color: Colors.white, size: 26),
                                ),
                                const SizedBox(height: 14),
                                Text(
                                  item['name']?.toString() ?? '-',
                                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item['category_name']?.toString() ?? '-',
                                  style: TextStyle(fontSize: 13, color: Colors.white.withValues(alpha: 0.7)),
                                ),
                                const SizedBox(height: 14),
                                Row(
                                  children: [
                                    _InfoBadge(icon: Icons.layers_rounded, label: 'Stok: $stock'),
                                    const SizedBox(width: 8),
                                    if ((item['condition']?.toString() ?? '').isNotEmpty)
                                      _InfoBadge(icon: Icons.check_circle_rounded, label: item['condition'].toString()),
                                  ],
                                ),
                                if ((item['description']?.toString() ?? '').isNotEmpty) ...[
                                  const SizedBox(height: 12),
                                  Text(
                                    item['description'].toString(),
                                    style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.65), height: 1.4),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                      ),
                    ] else ...[
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.06),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              Icon(Icons.qr_code_scanner_rounded, size: 40, color: Colors.white.withValues(alpha: 0.3)),
                              const SizedBox(height: 10),
                              Text(
                                'Scan QR barang terlebih dahulu',
                                style: TextStyle(color: Colors.white.withValues(alpha: 0.45), fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],

                    const SizedBox(height: 20),

                    // ── Tanggal Peminjaman ───────────────────────────────────
                    _SectionLabel(label: 'Tanggal Peminjaman'),
                    const SizedBox(height: 10),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: _DateField(
                                  label: 'Tanggal Pinjam',
                                  value: _fmtDate(_borrowDate),
                                  icon: Icons.login_rounded,
                                  iconColor: _blue,
                                  onTap: () => _pickDate(isBorrow: true),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Icon(Icons.arrow_forward_rounded, size: 16, color: Colors.white.withValues(alpha: 0.3)),
                              ),
                              Expanded(
                                child: _DateField(
                                  label: 'Tanggal Kembali',
                                  value: _fmtDate(_returnDate),
                                  icon: Icons.logout_rounded,
                                  iconColor: _orange,
                                  onTap: () => _pickDate(isBorrow: false),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: _blue.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: _blue.withValues(alpha: 0.25)),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.info_outline_rounded, size: 14, color: _blue),
                                const SizedBox(width: 8),
                                Text(
                                  'Durasi peminjaman: $duration hari',
                                  style: TextStyle(fontSize: 12, color: _blue, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // ── Jumlah Peminjaman ────────────────────────────────────
                    _SectionLabel(label: 'Jumlah Peminjaman'),
                    const SizedBox(height: 10),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              _QtyButton(
                                icon: Icons.remove_rounded,
                                color: Colors.white.withValues(alpha: 0.1),
                                onTap: () {
                                  final cur = int.tryParse(_qtyController.text) ?? 1;
                                  if (cur > 1) setState(() => _qtyController.text = '${cur - 1}');
                                },
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Container(
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.08),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                                  ),
                                  child: TextField(
                                    controller: _qtyController,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.zero,
                                    ),
                                    onChanged: (_) => setState(() {}),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              _QtyButton(
                                icon: Icons.add_rounded,
                                color: _blue,
                                onTap: () {
                                  final cur = int.tryParse(_qtyController.text) ?? 1;
                                  if (cur < stock) setState(() => _qtyController.text = '${cur + 1}');
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(Icons.inventory_2_outlined, size: 13, color: Colors.white.withValues(alpha: 0.4)),
                              const SizedBox(width: 6),
                              Text(
                                'Stok tersedia: $stock unit',
                                style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.45)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    // ── Submit button ────────────────────────────────────────
                    GestureDetector(
                      onTap: _isSubmitting || item == null ? null : _submit,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: _isSubmitting || item == null
                              ? _green.withValues(alpha: 0.4)
                              : _green,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: _isSubmitting || item == null
                              ? null
                              : [BoxShadow(color: _green.withValues(alpha: 0.4), blurRadius: 14, offset: const Offset(0, 5))],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 46,
                              height: 46,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: _isSubmitting
                                  ? const Padding(
                                      padding: EdgeInsets.all(12),
                                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                                    )
                                  : const Icon(Icons.send_rounded, color: Colors.white, size: 24),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _isSubmitting ? 'Mengirim...' : 'Kirim Pengajuan',
                                    style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'Menunggu persetujuan admin',
                                    style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 11),
                                  ),
                                ],
                              ),
                            ),
                            Icon(Icons.arrow_forward_rounded, color: Colors.white.withValues(alpha: 0.85), size: 18),
                          ],
                        ),
                      ),
                    ),
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

// ── Info Badge ────────────────────────────────────────────────────────────────

class _InfoBadge extends StatelessWidget {
  const _InfoBadge({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: Colors.white),
          const SizedBox(width: 5),
          Text(label, style: const TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

// ── Date Field ────────────────────────────────────────────────────────────────

class _DateField extends StatelessWidget {
  const _DateField({
    required this.label,
    required this.value,
    required this.icon,
    required this.iconColor,
    required this.onTap,
  });
  final String label;
  final String value;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 10, color: Colors.white.withValues(alpha: 0.5), fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: iconColor.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                Icon(icon, size: 14, color: iconColor),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    value,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                ),
                Icon(Icons.edit_calendar_rounded, size: 13, color: Colors.white.withValues(alpha: 0.35)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Qty Button ────────────────────────────────────────────────────────────────

class _QtyButton extends StatelessWidget {
  const _QtyButton({required this.icon, required this.color, required this.onTap});
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
        ),
        child: Icon(icon, color: Colors.white, size: 22),
      ),
    );
  }
}
