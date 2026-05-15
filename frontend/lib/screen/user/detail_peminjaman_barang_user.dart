import 'dart:io';
import 'package:flutter/material.dart';
import 'package:frontend/service/api_service.dart';
import 'package:frontend/service/auth_service.dart';
import 'package:image_picker/image_picker.dart';
import 'user_ui.dart';

class DetailPeminjamanBarangUserScreen extends StatefulWidget {
  final Map<String, dynamic>? loan;
  final bool isReturnMode;

  const DetailPeminjamanBarangUserScreen({
    super.key,
    this.loan,
    this.isReturnMode = false,
  });

  @override
  State<DetailPeminjamanBarangUserScreen> createState() =>
      _DetailPeminjamanBarangUserScreenState();
}

class _DetailPeminjamanBarangUserScreenState
    extends State<DetailPeminjamanBarangUserScreen> {
  final _notesCtrl = TextEditingController();
  bool _isSubmitting = false;
  String _username = '';
  File? _photoFile;
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  @override
  void dispose() {
    _notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadUsername() async {
    final name = await AuthService.getUsername();
    if (mounted) setState(() => _username = name ?? '');
  }

  Future<void> _confirmLoan() async {
    final loan = widget.loan;
    if (loan == null) return;

    setState(() => _isSubmitting = true);
    final token = await AuthService.getToken();
    if (token == null) {
      if (mounted) setState(() => _isSubmitting = false);
      return;
    }

    final result = await ApiService.createLoan(
      token,
      {
        'item_id': loan['item_id'],
        'purpose': _notesCtrl.text.trim(),
        'borrow_date': loan['borrow_date'],
        'due_date': loan['due_date'],
        'quantity': _quantity,
      },
      imagePath: _photoFile?.path,
    );

    if (!mounted) return;
    setState(() => _isSubmitting = false);

    if (result['success'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Peminjaman berhasil dikonfirmasi!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['message']?.toString() ?? 'Gagal'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _takePhoto() async {
    try {
      final picked = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
        maxWidth: 1080,
      );
      if (picked != null && mounted) {
        setState(() => _photoFile = File(picked.path));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Kamera tidak tersedia: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  Future<void> _confirmReturn() async {
    final loan = widget.loan;
    if (loan == null) return;

    setState(() => _isSubmitting = true);
    final token = await AuthService.getToken();
    if (token == null) {
      if (mounted) setState(() => _isSubmitting = false);
      return;
    }

    final id = int.tryParse(loan['id']?.toString() ?? '');
    if (id == null) {
      if (mounted) setState(() => _isSubmitting = false);
      return;
    }

    final result = await ApiService.returnLoan(token, id);
    if (!mounted) return;
    setState(() => _isSubmitting = false);

    if (result['success'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Barang berhasil dikembalikan!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['message']?.toString() ?? 'Gagal'),
          backgroundColor: Colors.red,
        ),
      );
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

  String get _todayFmt {
    final d = DateTime.now();
    const m = [
      'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
      'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des',
    ];
    return '${d.day} ${m[d.month - 1]} ${d.year}';
  }

  @override
  Widget build(BuildContext context) {
    final loan = widget.loan;
    final isReturnMode = widget.isReturnMode;
    final itemName = loan?['item_name']?.toString() ?? 'Barang';
    final borrowDate = _fmtDisplay(loan?['borrow_date']?.toString());
    final dueDate = _fmtDisplay(loan?['due_date']?.toString());
    final returnDate = _fmtDisplay(loan?['return_date']?.toString());
    final status = loan?['status']?.toString() ?? 'borrowed';
    final isBorrowed = status == 'borrowed';
    final isReturned = status == 'returned';
    final maxStock = int.tryParse(loan?['stock']?.toString() ?? '99') ?? 99;

    return UserPageScaffold(
      child: UserFramedPage(
        title: isReturnMode ? 'Detail Pengembalian Barang' : 'Detail Peminjaman Barang',
        topIcon: Icon(
          isReturnMode ? Icons.assignment_return_rounded : Icons.local_shipping_rounded,
          size: 46,
          color: const Color(0xFFEA6482),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Barang ──
            _SectionLabel(isReturnMode ? 'Barang yang Dikembalikan' : 'Barang yang Dipinjam'),
            const SizedBox(height: 6),
            UserSectionCard(
              color: Colors.white,
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const UserProductThumb(icon: Icons.laptop_mac_rounded),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              itemName,
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w800),
                            ),
                            Text(
                              _username.isEmpty ? '-' : _username,
                              style: const TextStyle(
                                  fontSize: 12, color: UserUi.textMuted),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.calendar_today_rounded,
                                    size: 13, color: UserUi.blue),
                                const SizedBox(width: 4),
                                Text(
                                  borrowDate,
                                  style: const TextStyle(
                                      fontSize: 12, color: UserUi.blue),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (loan != null)
                        UserPill(
                          text: isReturned
                              ? 'Dikembalikan'
                              : isBorrowed
                                  ? 'Dipinjam'
                                  : 'Menunggu',
                          background: isReturned
                              ? const Color(0xFFD8DEFF)
                              : isBorrowed
                                  ? const Color(0xFFDCF5E3)
                                  : const Color(0xFFFFF3CD),
                          foreground: isReturned
                              ? const Color(0xFF4D7BEE)
                              : isBorrowed
                                  ? Colors.green
                                  : Colors.orange,
                        ),
                    ],
                  ),

                  // ── Jumlah dipinjam (hanya mode peminjaman) ──
                  if (!isReturnMode) ...[
                    const SizedBox(height: 10),
                    const Divider(height: 1, color: UserUi.softBorder),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.layers_rounded,
                            size: 16, color: UserUi.textMuted),
                        const SizedBox(width: 6),
                        const Text('Jumlah Dipinjam',
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w700)),
                        const Spacer(),
                        _QtyButton(
                          icon: Icons.remove_rounded,
                          enabled: _quantity > 1,
                          onTap: () => setState(() => _quantity--),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 14),
                          child: Text(
                            '$_quantity',
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                        _QtyButton(
                          icon: Icons.add_rounded,
                          enabled: _quantity < maxStock,
                          onTap: () => setState(() => _quantity++),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Stok tersedia: $maxStock',
                        style: const TextStyle(
                            fontSize: 11, color: UserUi.textMuted),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 12),

            // ── Tanggal Peminjaman ──
            const _SectionLabel('Tanggal Peminjaman'),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(
                  child: _DateChip(
                    icon: Icons.calendar_month_rounded,
                    text: borrowDate,
                    iconColor: const Color(0xFF748BCB),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _DateChip(
                    icon: Icons.bolt_rounded,
                    text: dueDate,
                    iconColor: const Color(0xFFB07D00),
                    background: const Color(0xFFFBE3AF),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // ── Tanggal Pengembalian (hanya mode pengembalian) ──
            if (isReturnMode) ...[
              Row(
                children: const [
                  Icon(Icons.check_circle_rounded, size: 16, color: Colors.green),
                  SizedBox(width: 6),
                  _SectionLabel('Tanggal Pengembalian'),
                ],
              ),
              const SizedBox(height: 6),
              _DateChip(
                icon: Icons.calendar_today_rounded,
                text: isReturned ? returnDate : _todayFmt,
                iconColor: const Color(0xFF748BCB),
              ),
              const SizedBox(height: 12),
            ],

            // ── Foto Barang ──
            const _SectionLabel('Foto Barang'),
            const SizedBox(height: 6),
            UserSectionCard(
              color: const Color(0xFFF7F1F6),
              child: Center(
                child: GestureDetector(
                  onTap: _takePhoto,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 144,
                        height: 96,
                        decoration: BoxDecoration(
                          color: UserUi.productThumbBackground,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: UserUi.frameBorder.withValues(alpha: .7)),
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: _photoFile != null
                            ? Image.file(_photoFile!, fit: BoxFit.cover)
                            : const Icon(
                                Icons.laptop_mac_rounded,
                                size: 52,
                                color: UserUi.productThumbIconColor,
                              ),
                      ),
                      Positioned(
                          bottom: -6,
                          right: -6,
                          child: Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: _photoFile != null ? Colors.green : Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(color: UserUi.softBorder),
                            ),
                            child: Icon(
                              _photoFile != null ? Icons.check_rounded : Icons.camera_alt_rounded,
                              size: 14,
                              color: _photoFile != null ? Colors.white : Colors.red,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // ── Catatan ──
            const _SectionLabel('Catatan (Opsional)'),
            const SizedBox(height: 6),
            UserSectionCard(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: TextField(
                controller: _notesCtrl,
                style: const TextStyle(fontSize: 13),
                maxLines: 3,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                  hintText: isReturnMode
                      ? 'Masukkan catatan pengembalian barang...'
                      : 'Keperluan peminjaman...',
                  hintStyle: const TextStyle(fontSize: 13, color: UserUi.textMuted),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // ── Button ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: isReturnMode
                  ? UserPrimaryButton(
                      text: _isSubmitting
                          ? 'Memproses...'
                          : isReturned
                              ? 'Sudah Dikembalikan'
                              : 'Konfirmasi Pengembalian',
                      icon: isReturned
                          ? Icons.check_rounded
                          : Icons.check_circle_outline_rounded,
                      background: isReturned ? Colors.grey : UserUi.blue,
                      onTap: (isBorrowed && !_isSubmitting) ? _confirmReturn : null,
                    )
                  : UserPrimaryButton(
                      text: _isSubmitting
                          ? 'Memproses...'
                          : 'Konfirmasi Peminjaman',
                      icon: _isSubmitting
                          ? null
                          : Icons.check_circle_outline_rounded,
                      onTap: _isSubmitting ? null : _confirmLoan,
                    ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _QtyButton extends StatelessWidget {
  const _QtyButton({
    required this.icon,
    required this.enabled,
    required this.onTap,
  });
  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: enabled ? UserUi.blue : const Color(0xFFE0E0E0),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 18, color: Colors.white),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
          fontSize: 13, fontWeight: FontWeight.w800, color: Colors.black87),
    );
  }
}

class _DateChip extends StatelessWidget {
  const _DateChip({
    required this.icon,
    required this.text,
    required this.iconColor,
    this.background = const Color(0xFFF6F3F8),
  });

  final IconData icon;
  final String text;
  final Color iconColor;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: UserUi.softBorder),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: iconColor),
          const SizedBox(width: 6),
          Expanded(
            child: Text(text, style: const TextStyle(fontSize: 12)),
          ),
        ],
      ),
    );
  }
}
