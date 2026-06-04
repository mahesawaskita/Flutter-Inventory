import 'dart:io';
import 'package:flutter/material.dart';
import 'package:frontend/service/api_service.dart';
import 'package:frontend/service/auth_service.dart';
import 'package:image_picker/image_picker.dart';

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

  static const _bg     = Color(0xFF0D1117);
  static const _purple = Color(0xFF8A20F7);
  static const _blue   = Color(0xFF4A6CF7);
  static const _green  = Color(0xFF10B981);
  static const _orange = Color(0xFFF97316);
  static const _red    = Color(0xFFEF4444);

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
        'item_id'    : loan['item_id'],
        'purpose'    : _notesCtrl.text.trim(),
        'borrow_date': loan['borrow_date'],
        'due_date'   : loan['due_date'],
        'quantity'   : _quantity,
      },
      imagePath: _photoFile?.path,
    );

    if (!mounted) return;
    setState(() => _isSubmitting = false);

    if (result['success'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Peminjaman berhasil dikonfirmasi!'),
        backgroundColor: Color(0xFF10B981),
      ));
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(result['message']?.toString() ?? 'Gagal'),
        backgroundColor: _red,
      ));
    }
  }

  Future<void> _takePhoto() async {
    try {
      final picked = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
        maxWidth: 1080,
      );
      if (picked != null && mounted) setState(() => _photoFile = File(picked.path));
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Kamera tidak tersedia: $e'), backgroundColor: _red),
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
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Barang berhasil dikembalikan!'),
        backgroundColor: Color(0xFF10B981),
      ));
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(result['message']?.toString() ?? 'Gagal'),
        backgroundColor: _red,
      ));
    }
  }

  String _fmtDisplay(String? s) {
    if (s == null || s.isEmpty) return '-';
    try {
      final d = DateTime.parse(s);
      const m = ['Jan','Feb','Mar','Apr','Mei','Jun','Jul','Agu','Sep','Okt','Nov','Des'];
      return '${d.day} ${m[d.month - 1]} ${d.year}';
    } catch (_) { return s; }
  }

  String get _todayFmt {
    final d = DateTime.now();
    const m = ['Jan','Feb','Mar','Apr','Mei','Jun','Jul','Agu','Sep','Okt','Nov','Des'];
    return '${d.day} ${m[d.month - 1]} ${d.year}';
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final loan         = widget.loan;
    final isReturnMode = widget.isReturnMode;
    final itemName     = loan?['item_name']?.toString() ?? 'Barang';
    final borrowDate   = _fmtDisplay(loan?['borrow_date']?.toString());
    final dueDate      = _fmtDisplay(loan?['due_date']?.toString());
    final returnDate   = _fmtDisplay(loan?['return_date']?.toString());
    final status       = loan?['status']?.toString() ?? 'borrowed';
    final isBorrowed   = status == 'borrowed';
    final isReturned   = status == 'returned';
    final isPending    = status == 'pending';
    final maxStock     = int.tryParse(loan?['stock']?.toString() ?? '99') ?? 99;

    // Status appearance
    final Color bannerColor;
    final String bannerLabel;
    final IconData bannerIcon;
    if (isReturnMode) {
      if (isReturned) {
        bannerColor = _green; bannerLabel = 'Dikembalikan'; bannerIcon = Icons.check_circle_rounded;
      } else {
        bannerColor = _orange; bannerLabel = 'Dipinjam'; bannerIcon = Icons.swap_horiz_rounded;
      }
    } else if (isPending) {
      bannerColor = _orange; bannerLabel = 'Menunggu Persetujuan'; bannerIcon = Icons.pending_actions_rounded;
    } else {
      bannerColor = _purple; bannerLabel = 'Konfirmasi Peminjaman'; bannerIcon = Icons.local_shipping_rounded;
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
                            width: 38, height: 38,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
                            ),
                            child: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 20),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          isReturnMode ? 'Detail Pengembalian' : 'Detail Peminjaman',
                          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
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
                        color: bannerColor,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [BoxShadow(color: bannerColor.withValues(alpha: 0.4), blurRadius: 16, offset: const Offset(0, 6))],
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            right: -12, top: -12,
                            child: Icon(bannerIcon, size: 110, color: Colors.white.withValues(alpha: 0.12)),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 48, height: 48,
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Icon(bannerIcon, color: Colors.white, size: 26),
                              ),
                              const SizedBox(height: 14),
                              Text(itemName,
                                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(bannerLabel,
                                    style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ── Peminjam ─────────────────────────────────────────────
                    _SectionLabel('Info Peminjam'),
                    const SizedBox(height: 10),
                    _InfoCard(children: [
                      _InfoRow(
                        icon: Icons.person_rounded, iconColor: _blue,
                        label: 'Nama Peminjam',
                        value: _username.isEmpty ? '-' : _username,
                      ),
                      if (loan != null) ...[
                        _RowDivider(),
                        _InfoRow(
                          icon: Icons.info_outline_rounded, iconColor: bannerColor,
                          label: 'Status',
                          valueWidget: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: bannerColor.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: bannerColor.withValues(alpha: 0.4)),
                            ),
                            child: Text(bannerLabel,
                                style: TextStyle(color: bannerColor, fontSize: 11, fontWeight: FontWeight.w700)),
                          ),
                        ),
                      ],
                    ]),

                    const SizedBox(height: 16),

                    // ── Jumlah (hanya mode pinjam) ────────────────────────
                    if (!isReturnMode) ...[
                      _SectionLabel('Jumlah Dipinjam'),
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
                                Container(
                                  width: 32, height: 32,
                                  decoration: BoxDecoration(
                                    color: _purple.withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(Icons.layers_rounded, color: _purple, size: 16),
                                ),
                                const SizedBox(width: 12),
                                const Text('Jumlah', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white)),
                                const Spacer(),
                                _QtyBtn(
                                  icon: Icons.remove_rounded,
                                  enabled: _quantity > 1,
                                  onTap: () => setState(() => _quantity--),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Text('$_quantity',
                                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.white)),
                                ),
                                _QtyBtn(
                                  icon: Icons.add_rounded,
                                  enabled: _quantity < maxStock,
                                  onTap: () => setState(() => _quantity++),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(Icons.inventory_2_outlined, size: 12, color: Colors.white.withValues(alpha: 0.35)),
                                const SizedBox(width: 6),
                                Text('Stok tersedia: $maxStock unit',
                                    style: TextStyle(fontSize: 11, color: Colors.white.withValues(alpha: 0.4))),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],

                    // ── Tanggal ──────────────────────────────────────────────
                    _SectionLabel('Tanggal Peminjaman'),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(child: _DateChip(
                          icon: Icons.login_rounded, iconColor: _blue,
                          label: 'Mulai', value: borrowDate,
                        )),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Icon(Icons.arrow_forward_rounded, size: 16,
                              color: Colors.white.withValues(alpha: 0.25)),
                        ),
                        Expanded(child: _DateChip(
                          icon: Icons.logout_rounded, iconColor: _orange,
                          label: 'Kembali', value: dueDate,
                        )),
                      ],
                    ),

                    // Tanggal pengembalian (mode return)
                    if (isReturnMode) ...[
                      const SizedBox(height: 10),
                      _DateChip(
                        icon: Icons.check_circle_rounded, iconColor: _green,
                        label: 'Dikembalikan',
                        value: isReturned ? returnDate : _todayFmt,
                        fullWidth: true,
                      ),
                    ],

                    const SizedBox(height: 16),

                    // ── Foto Barang ──────────────────────────────────────────
                    _SectionLabel('Foto Barang'),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: _takePhoto,
                      child: Container(
                        width: double.infinity,
                        height: 140,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: _photoFile != null
                                ? _green.withValues(alpha: 0.5)
                                : Colors.white.withValues(alpha: 0.12),
                            style: _photoFile != null ? BorderStyle.solid : BorderStyle.solid,
                          ),
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: _photoFile != null
                            ? Stack(
                                fit: StackFit.expand,
                                children: [
                                  Image.file(_photoFile!, fit: BoxFit.cover),
                                  Positioned(
                                    bottom: 8, right: 8,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: _green,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.check_rounded, color: Colors.white, size: 12),
                                          SizedBox(width: 4),
                                          Text('Foto diambil', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 52, height: 52,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.08),
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    child: Icon(Icons.camera_alt_rounded, size: 26,
                                        color: Colors.white.withValues(alpha: 0.4)),
                                  ),
                                  const SizedBox(height: 10),
                                  Text('Tap untuk mengambil foto',
                                      style: TextStyle(fontSize: 13, color: Colors.white.withValues(alpha: 0.4))),
                                  const SizedBox(height: 4),
                                  Text('(Opsional)',
                                      style: TextStyle(fontSize: 11, color: Colors.white.withValues(alpha: 0.25))),
                                ],
                              ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // ── Catatan ──────────────────────────────────────────────
                    _SectionLabel('Catatan (Opsional)'),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Container(
                              width: 30, height: 30,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFC400).withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(Icons.notes_rounded, size: 15, color: Color(0xFFFFC400)),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: _notesCtrl,
                              style: const TextStyle(fontSize: 13, color: Colors.white),
                              maxLines: 3,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                isDense: true,
                                hintText: isReturnMode
                                    ? 'Catatan pengembalian...'
                                    : 'Keperluan peminjaman...',
                                hintStyle: TextStyle(fontSize: 13, color: Colors.white.withValues(alpha: 0.3)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    // ── Action Button ────────────────────────────────────────
                    if (isReturnMode) ...[
                      GestureDetector(
                        onTap: (isBorrowed && !_isSubmitting) ? _confirmReturn : null,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: double.infinity,
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: isReturned
                                ? Colors.grey.withValues(alpha: 0.3)
                                : _isSubmitting
                                    ? _green.withValues(alpha: 0.5)
                                    : _green,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: (isBorrowed && !_isSubmitting)
                                ? [BoxShadow(color: _green.withValues(alpha: 0.4), blurRadius: 14, offset: const Offset(0, 5))]
                                : null,
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 46, height: 46,
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: _isSubmitting
                                    ? const Padding(
                                        padding: EdgeInsets.all(12),
                                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                                      )
                                    : Icon(isReturned ? Icons.check_rounded : Icons.assignment_return_rounded,
                                          color: Colors.white, size: 24),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _isSubmitting ? 'Memproses...' : isReturned ? 'Sudah Dikembalikan' : 'Konfirmasi Pengembalian',
                                      style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      isReturned ? 'Barang telah dikembalikan' : 'Kembalikan barang ke tempat semula',
                                      style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 11),
                                    ),
                                  ],
                                ),
                              ),
                              if (!isReturned)
                                Icon(Icons.arrow_forward_rounded, color: Colors.white.withValues(alpha: 0.85), size: 18),
                            ],
                          ),
                        ),
                      ),
                    ] else ...[
                      GestureDetector(
                        onTap: _isSubmitting ? null : _confirmLoan,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: double.infinity,
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: _isSubmitting ? _purple.withValues(alpha: 0.5) : _purple,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: _isSubmitting
                                ? null
                                : [BoxShadow(color: _purple.withValues(alpha: 0.4), blurRadius: 14, offset: const Offset(0, 5))],
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 46, height: 46,
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: _isSubmitting
                                    ? const Padding(
                                        padding: EdgeInsets.all(12),
                                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                                      )
                                    : const Icon(Icons.check_circle_outline_rounded, color: Colors.white, size: 24),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _isSubmitting ? 'Memproses...' : 'Konfirmasi Peminjaman',
                                      style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      'Pengajuan akan dikirim ke admin',
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

// ── Shared widgets ────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.label);
  final String label;

  @override
  Widget build(BuildContext context) => Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
      );
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
        ),
        child: Column(children: children),
      );
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.iconColor,
    required this.label,
    this.value,
    this.valueWidget,
  });
  final IconData icon;
  final Color iconColor;
  final String label;
  final String? value;
  final Widget? valueWidget;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 32, height: 32,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 16, color: iconColor),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(label,
                  style: TextStyle(fontSize: 13, color: Colors.white.withValues(alpha: 0.55))),
            ),
            valueWidget ??
                Text(value ?? '-',
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white)),
          ],
        ),
      );
}

class _RowDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Divider(height: 1, color: Colors.white.withValues(alpha: 0.08));
}

class _DateChip extends StatelessWidget {
  const _DateChip({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    this.fullWidth = false,
  });
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) => Container(
        width: fullWidth ? double.infinity : null,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: iconColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: iconColor.withValues(alpha: 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(fontSize: 10, color: Colors.white.withValues(alpha: 0.5), fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(icon, size: 14, color: iconColor),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(value,
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      );
}

class _QtyBtn extends StatelessWidget {
  const _QtyBtn({required this.icon, required this.enabled, required this.onTap});
  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;

  static const _blue = Color(0xFF4A6CF7);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: enabled ? onTap : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: 36, height: 36,
          decoration: BoxDecoration(
            color: enabled ? _blue : Colors.white.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: enabled ? _blue : Colors.white.withValues(alpha: 0.12)),
          ),
          child: Icon(icon, size: 18, color: enabled ? Colors.white : Colors.white30),
        ),
      );
}
