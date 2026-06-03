import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/service/api_service.dart';
import 'package:frontend/service/auth_service.dart';
import 'package:image_picker/image_picker.dart';

class DetailPengembalianBarangUserScreen extends StatefulWidget {
  const DetailPengembalianBarangUserScreen({super.key, required this.loan});

  final Map<String, dynamic> loan;

  @override
  State<DetailPengembalianBarangUserScreen> createState() =>
      _DetailPengembalianBarangUserScreenState();
}

class _DetailPengembalianBarangUserScreenState
    extends State<DetailPengembalianBarangUserScreen> {
  final _noteController = TextEditingController();
  File? _photoFile;
  bool _isSubmitting = false;

  static const _bg = Color(0xFF0D1117);
  static const _cardBorder = Color(0xFF30363D);
  static const _blue = Color(0xFF4A6CF7);

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
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

  String get _todayFormatted {
    final d = DateTime.now();
    const m = ['Jan','Feb','Mar','Apr','Mei','Jun','Jul','Agu','Sep','Okt','Nov','Des'];
    return '${d.day} ${m[d.month - 1]} ${d.year}';
  }

  Future<void> _takePhoto() async {
    try {
      final picker = ImagePicker();
      final picked = await picker.pickImage(source: ImageSource.camera, imageQuality: 80, maxWidth: 1280);
      if (picked != null && mounted) setState(() => _photoFile = File(picked.path));
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal membuka kamera: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  void _removePhoto() => setState(() => _photoFile = null);

  Future<void> _konfirmasi() async {
    setState(() => _isSubmitting = true);
    final token = await AuthService.getToken();
    if (token == null) {
      if (mounted) setState(() => _isSubmitting = false);
      return;
    }

    final loanId = (widget.loan['id'] as num).toInt();
    final result = await ApiService.returnLoan(
      token,
      loanId,
      imagePath: _photoFile?.path,
      catatan: _noteController.text.trim().isEmpty ? null : _noteController.text.trim(),
    );

    if (!mounted) return;
    setState(() => _isSubmitting = false);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(result['message']?.toString() ?? ''),
      backgroundColor: result['success'] == true ? Colors.green : Colors.red,
    ));

    if (result['success'] == true) Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final loan = widget.loan;
    final itemName = loan['item_name']?.toString() ?? '-';
    final borrowerName =
        loan['username']?.toString() ??
        loan['user_name']?.toString() ??
        loan['borrower_name']?.toString() ??
        '-';
    final borrowDate = _fmtDisplay(loan['borrow_date']?.toString() ?? loan['created_at']?.toString());
    final dueDate = _fmtDisplay(loan['due_date']?.toString());

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
          'Detail Pengembalian',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            // ── Item info card ────────────────────────────────────────────
            Container(
              decoration: BoxDecoration(
                color: _blue,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: _blue.withValues(alpha: 0.35), blurRadius: 12, offset: const Offset(0, 4))],
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.inventory_2_rounded, color: Colors.white, size: 28),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(itemName,
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 2),
                        Text(borrowerName,
                            style: const TextStyle(color: Colors.white70, fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // ── Tanggal Peminjaman ────────────────────────────────────────
            _SectionCard(
              title: 'Tanggal Peminjaman',
              titleIcon: Icons.calendar_month_rounded,
              child: Row(
                children: [
                  Expanded(child: _DateChip(label: 'Mulai', value: borrowDate, color: const Color(0xFF4A6CF7))),
                  const SizedBox(width: 10),
                  Expanded(child: _DateChip(label: 'Jatuh Tempo', value: dueDate, color: const Color(0xFFF97316))),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // ── Tanggal Pengembalian ──────────────────────────────────────
            _SectionCard(
              title: 'Tanggal Pengembalian',
              titleIcon: Icons.check_circle_rounded,
              titleColor: const Color(0xFF10B981),
              child: _DateChip(label: 'Hari ini', value: _todayFormatted, color: const Color(0xFF10B981)),
            ),

            const SizedBox(height: 10),

            // ── Foto Barang ───────────────────────────────────────────────
            _SectionCard(
              title: 'Foto Barang',
              titleIcon: Icons.photo_camera_rounded,
              child: Center(
                child: _photoFile != null
                    ? Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(_photoFile!, width: 160, height: 160, fit: BoxFit.cover),
                          ),
                          Positioned(
                            top: 6,
                            right: 6,
                            child: GestureDetector(
                              onTap: _removePhoto,
                              child: Container(
                                width: 28,
                                height: 28,
                                decoration: const BoxDecoration(color: Color(0xFFD63A30), shape: BoxShape.circle),
                                child: const Icon(Icons.close_rounded, size: 16, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      )
                    : GestureDetector(
                        onTap: _takePhoto,
                        child: Container(
                          width: 160,
                          height: 110,
                          decoration: BoxDecoration(
                            color: const Color(0xFF21262D),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: _cardBorder),
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.camera_alt_rounded, size: 36, color: _blue),
                              SizedBox(height: 8),
                              Text('Buka Kamera',
                                  style: TextStyle(fontSize: 12, color: _blue, fontWeight: FontWeight.w700)),
                            ],
                          ),
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 10),

            // ── Catatan ───────────────────────────────────────────────────
            _SectionCard(
              title: 'Catatan (Opsional)',
              titleIcon: Icons.notes_rounded,
              child: TextField(
                controller: _noteController,
                maxLines: 3,
                style: const TextStyle(fontSize: 13, color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Masukkan catatan pengembalian barang...',
                  hintStyle: const TextStyle(color: Colors.white38, fontSize: 13),
                  filled: true,
                  fillColor: const Color(0xFF21262D),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: _cardBorder),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: _cardBorder),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: _blue, width: 1.5),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ── Tombol Konfirmasi ─────────────────────────────────────────
            SizedBox(
              height: 50,
              child: ElevatedButton.icon(
                onPressed: _isSubmitting ? null : _konfirmasi,
                icon: _isSubmitting
                    ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : const Icon(Icons.check_circle_rounded, size: 20),
                label: Text(
                  _isSubmitting ? 'Memproses...' : 'Konfirmasi Pengembalian',
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isSubmitting ? const Color(0xFF21262D) : _blue,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: const Color(0xFF21262D),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  elevation: 0,
                ),
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

// ── Helper widgets ─────────────────────────────────────────────────────────

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.titleIcon,
    required this.child,
    this.titleColor = Colors.white,
  });
  final String title;
  final IconData titleIcon;
  final Widget child;
  final Color titleColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF161B22),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF30363D)),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(titleIcon, size: 16, color: titleColor),
              const SizedBox(width: 8),
              Text(title, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: titleColor)),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _DateChip extends StatelessWidget {
  const _DateChip({required this.label, required this.value, required this.color});
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 10, color: color.withValues(alpha: 0.8))),
          const SizedBox(height: 2),
          Text(value, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: color)),
        ],
      ),
    );
  }
}
