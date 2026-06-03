import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/service/api_service.dart';
import 'package:frontend/service/auth_service.dart';

import 'user_ui.dart';

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

  @override
  void dispose() {
    _qtyController.dispose();
    super.dispose();
  }

  // ── Helpers ────────────────────────────────────────────────────────────────

  String _fmtDate(DateTime d) {
    const months = [
      'Jan','Feb','Mar','Apr','Mei','Jun',
      'Jul','Agu','Sep','Okt','Nov','Des'
    ];
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
          colorScheme: const ColorScheme.light(primary: UserUi.blue),
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
      backgroundColor: isError ? Colors.red : Colors.green,
    ));
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final stock = (item?['stock'] as num?)?.toInt() ?? 0;

    return UserPageScaffold(
      child: UserFramedPage(
        title: 'Pengajuan Peminjaman',
        topIcon: const Icon(Icons.assignment_rounded, size: 46, color: Color(0xFF33343D)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            // ── Item info (read-only) ────────────────────────────────────
            if (item != null) ...[
              UserSectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UserInfoTile(
                      leading: const UserProductThumb(
                        icon: Icons.inventory_2_rounded,
                        background: Color(0xFFF7E3C1),
                      ),
                      title: item['name']?.toString() ?? '-',
                      subtitle: item['category_name']?.toString() ?? '-',
                    ),
                    const SizedBox(height: 10),
                    Container(height: 1, color: UserUi.softBorder),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        _InfoChip(
                          icon: Icons.layers_rounded,
                          label: 'Stok',
                          value: '$stock',
                          color: const Color(0xFF52B2F1),
                        ),
                        const SizedBox(width: 10),
                        _InfoChip(
                          icon: Icons.check_circle_rounded,
                          label: 'Kondisi',
                          value: item['condition']?.toString() ?? '-',
                          color: const Color(0xFF4CAF50),
                        ),
                      ],
                    ),
                    if ((item['description']?.toString() ?? '').isNotEmpty) ...[
                      const SizedBox(height: 10),
                      Container(height: 1, color: UserUi.softBorder),
                      const SizedBox(height: 8),
                      Text(
                        item['description'].toString(),
                        style: const TextStyle(fontSize: 12, color: UserUi.textMuted, height: 1.4),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ] else ...[
              // No item — user opened screen without scanning
              UserSectionCard(
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Scan QR barang terlebih dahulu',
                      style: TextStyle(color: UserUi.textMuted),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],

            // ── Tanggal ─────────────────────────────────────────────────
            UserSectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tanggal Peminjaman',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: _DateField(
                          label: 'Tgl Pinjam',
                          value: _fmtDate(_borrowDate),
                          icon: Icons.calendar_today_rounded,
                          onTap: () => _pickDate(isBorrow: true),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _DateField(
                          label: 'Tgl Kembali',
                          value: _fmtDate(_returnDate),
                          icon: Icons.event_rounded,
                          onTap: () => _pickDate(isBorrow: false),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // ── Jumlah ───────────────────────────────────────────────────
            UserSectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Jumlah Peminjaman',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      // Minus button
                      _QtyButton(
                        icon: Icons.remove_rounded,
                        onTap: () {
                          final cur = int.tryParse(_qtyController.text) ?? 1;
                          if (cur > 1) _qtyController.text = '${cur - 1}';
                        },
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          height: 42,
                          decoration: BoxDecoration(
                            color: UserUi.input,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: UserUi.softBorder),
                          ),
                          child: TextField(
                            controller: _qtyController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Plus button
                      _QtyButton(
                        icon: Icons.add_rounded,
                        onTap: () {
                          final cur = int.tryParse(_qtyController.text) ?? 1;
                          if (cur < stock) _qtyController.text = '${cur + 1}';
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Stok tersedia: $stock unit',
                    style: const TextStyle(fontSize: 11, color: UserUi.textMuted),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ── Submit ───────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: UserPrimaryButton(
                text: _isSubmitting ? 'Mengirim...' : 'Kirim Pengajuan',
                icon: Icons.send_rounded,
                background: _isSubmitting || item == null
                    ? UserUi.blue.withValues(alpha: 0.5)
                    : UserUi.blue,
                onTap: _isSubmitting || item == null ? null : _submit,
              ),
            ),

            const SizedBox(height: 8),

            // Pending notice
            const Center(
              child: Text(
                'Pengajuan akan menunggu persetujuan admin',
                style: TextStyle(fontSize: 11, color: UserUi.textMuted),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Helper widgets ────────────────────────────────────────────────────────────

class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 38,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 6),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: TextStyle(fontSize: 10, color: color.withValues(alpha: 0.7))),
                  Text(value, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: color)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DateField extends StatelessWidget {
  const _DateField({
    required this.label,
    required this.value,
    required this.icon,
    required this.onTap,
  });
  final String label;
  final String value;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 11, color: UserUi.textMuted)),
          const SizedBox(height: 4),
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: UserUi.input,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: UserUi.softBorder),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Icon(icon, size: 15, color: UserUi.blue),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    value,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                  ),
                ),
                const Icon(Icons.edit_calendar_rounded, size: 14, color: UserUi.textMuted),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QtyButton extends StatelessWidget {
  const _QtyButton({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: UserUi.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}
