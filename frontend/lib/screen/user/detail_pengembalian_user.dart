import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/service/api_service.dart';
import 'package:frontend/service/auth_service.dart';
import 'package:image_picker/image_picker.dart';

import 'user_ui.dart';

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

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  String _fmtDisplay(String? s) {
    if (s == null) return '-';
    try {
      final d = DateTime.parse(s);
      const m = ['Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun', 'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'];
      return '${d.day} ${m[d.month - 1]} ${d.year}';
    } catch (_) {
      return s;
    }
  }

  String get _todayFormatted {
    final d = DateTime.now();
    const m = ['Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun', 'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'];
    return '${d.day} ${m[d.month - 1]} ${d.year}';
  }

  Future<void> _takePhoto() async {
    try {
      final picker = ImagePicker();
      final picked = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
        maxWidth: 1280,
      );
      if (picked != null && mounted) {
        setState(() => _photoFile = File(picked.path));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal membuka kamera: $e'),
            backgroundColor: Colors.red,
          ),
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

    if (result['success'] == true) {
      Navigator.pop(context, true);
    }
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

    return UserPageScaffold(
      child: UserFramedPage(
        title: 'Detail Pengembalian Barang',
        topIcon: const Icon(Icons.sync_alt_rounded, size: 48, color: Color(0xFF33343D)),
        child: UserSectionCard(
          color: const Color(0xFFF8F2F7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Barang yang Dikembalikan',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
              const SizedBox(height: 8),
              UserInfoTile(
                leading: const UserProductThumb(icon: Icons.inventory_2_rounded),
                title: itemName,
                subtitle: borrowerName,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.list_alt_rounded, color: Color(0xFF52B2F1)),
                  const SizedBox(width: 8),
                  Text(borrowDate, style: const TextStyle(fontSize: 13)),
                ],
              ),
              const SizedBox(height: 10),
              UserSectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _DateGroup(start: borrowDate, end: dueDate),
                    const SizedBox(height: 10),
                    _SingleDateGroup(value: _todayFormatted),
                    const SizedBox(height: 10),

                    // ── Foto Barang ──
                    Row(
                      children: const [
                        Icon(Icons.photo_camera_rounded),
                        SizedBox(width: 8),
                        Text('Foto Barang',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: _photoFile != null
                          ? Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.file(
                                    _photoFile!,
                                    width: 144,
                                    height: 144,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 4,
                                  right: 4,
                                  child: GestureDetector(
                                    onTap: _removePhoto,
                                    child: Container(
                                      width: 26,
                                      height: 26,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFD63A30),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(Icons.delete_rounded,
                                          size: 16, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : GestureDetector(
                              onTap: _takePhoto,
                              child: Container(
                                width: 144,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFD7D7D7),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: UserUi.frameBorder.withValues(alpha: .7)),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.camera_alt_rounded,
                                        size: 36, color: Color(0xFF4460C8)),
                                    SizedBox(height: 6),
                                    Text('Buka Kamera',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF4460C8),
                                            fontWeight: FontWeight.w700)),
                                  ],
                                ),
                              ),
                            ),
                    ),

                    const SizedBox(height: 10),

                    // ── Catatan ──
                    const Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text: 'Catatan ',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w800)),
                          TextSpan(
                              text: '(Opsional)',
                              style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      controller: _noteController,
                      maxLines: 3,
                      style: const TextStyle(fontSize: 13),
                      decoration: InputDecoration(
                        hintText: 'Masukkan catatan pengembalian barang...',
                        hintStyle: const TextStyle(
                            color: Color(0xFFAAAAAA), fontSize: 13),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: UserUi.frameBorder.withValues(alpha: .5)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: UserUi.frameBorder.withValues(alpha: .5)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: UserUi.blue),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 86),
                child: UserPrimaryButton(
                  text: _isSubmitting ? 'Memproses...' : 'Konfirmasi',
                  background: _isSubmitting ? Colors.grey : UserUi.blue,
                  onTap: _isSubmitting ? null : _konfirmasi,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Sub-widgets ─────────────────────────────────────────────────────────────

class _DateGroup extends StatelessWidget {
  const _DateGroup({required this.start, required this.end});

  final String start;
  final String end;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(Icons.calendar_month_rounded),
            SizedBox(width: 8),
            Text('Tanggal Peminjaman',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: UserTextInputMock(
                text: start,
                icon: const Icon(Icons.calendar_today_rounded, size: 14),
                muted: true,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                height: 34,
                decoration: BoxDecoration(
                  color: const Color(0xFFFBE3AF),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    const Icon(Icons.bolt_rounded,
                        size: 15, color: Color(0xFFB07D00)),
                    const SizedBox(width: 6),
                    Text(end, style: const TextStyle(fontSize: 12)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SingleDateGroup extends StatelessWidget {
  const _SingleDateGroup({required this.value});

  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(Icons.check_circle_rounded, color: Color(0xFF33B35A)),
            SizedBox(width: 8),
            Text('Tanggal Pengembalian',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
          ],
        ),
        const SizedBox(height: 6),
        UserTextInputMock(
          text: value,
          icon: const Icon(Icons.calendar_today_rounded, size: 14),
          muted: true,
        ),
      ],
    );
  }
}
