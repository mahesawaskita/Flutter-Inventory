import 'package:flutter/material.dart';
import 'package:frontend/service/api_service.dart';
import 'package:frontend/service/auth_service.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'detail_pengembalian_user.dart';
import 'pengajuan_peminjaman_user.dart';

class QRScannerUserScreen extends StatefulWidget {
  const QRScannerUserScreen({super.key});

  @override
  State<QRScannerUserScreen> createState() => _QRScannerUserScreenState();
}

class _QRScannerUserScreenState extends State<QRScannerUserScreen> {
  Map<String, dynamic>? _item;
  List<Map<String, dynamic>> _loans = [];
  bool _isLoading = false;
  int _activeScanTab = 0;
  int _activeInnerTab = 0;
  bool _showAll = false;
  String? _currentUsername;
  String? _error;

  List<Map<String, dynamic>> _myLoans = [];
  bool _isLoadingMyLoans = false;

  static const _bg = Color(0xFF0D1117);
  static const _purple = Color(0xFF8A20F7);
  static const _blue = Color(0xFF4A6CF7);
  static const _green = Color(0xFF10B981);
  static const _orange = Color(0xFFF97316);
  static const _red = Color(0xFFEF4444);

  // ── Lifecycle ─────────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    _loadMyLoans();
  }

  Future<void> _loadMyLoans() async {
    setState(() => _isLoadingMyLoans = true);
    final token = await AuthService.getToken();
    final username = await AuthService.getUsername();
    if (token == null || !mounted) {
      if (mounted) setState(() => _isLoadingMyLoans = false);
      return;
    }
    final raw = await ApiService.getMyLoans(token);
    if (!mounted) return;
    setState(() {
      _myLoans = raw.map((e) => Map<String, dynamic>.from(e as Map)).toList();
      _currentUsername = username;
      _isLoadingMyLoans = false;
    });
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  String _fmt(String? s) {
    if (s == null) return '-';
    try {
      final d = DateTime.parse(s);
      const m = ['Jan','Feb','Mar','Apr','Mei','Jun','Jul','Agu','Sep','Okt','Nov','Des'];
      return '${d.day} ${m[d.month - 1]} ${d.year}';
    } catch (_) {
      return s;
    }
  }

  String _daysLeft(String? s) {
    if (s == null) return '';
    try {
      final diff = DateTime.parse(s).difference(DateTime.now()).inDays;
      if (diff < 0) return '${-diff} hari terlambat';
      if (diff == 0) return 'Jatuh tempo hari ini';
      return '$diff hari lagi';
    } catch (_) {
      return '';
    }
  }

  bool _isLate(String? s) {
    if (s == null) return false;
    try {
      return DateTime.parse(s).isBefore(DateTime.now());
    } catch (_) {
      return false;
    }
  }

  Map<String, dynamic>? get _myActiveLoan {
    if (_currentUsername == null) return null;
    for (final l in _loans) {
      if (l['status'] == 'borrowed' && l['username'] == _currentUsername) return l;
    }
    return null;
  }

  bool get _hasPendingLoan {
    if (_currentUsername == null) return false;
    for (final l in _loans) {
      if (l['status'] == 'pending' && l['username'] == _currentUsername) return true;
    }
    return false;
  }

  bool get _canBorrow {
    final stock = (_item?['stock'] as num?)?.toInt() ?? 0;
    return stock > 0 && _myActiveLoan == null && !_hasPendingLoan;
  }

  Map<String, dynamic>? get _currentBorrower {
    for (final l in _loans) {
      if (l['status'] == 'borrowed') return l;
    }
    return null;
  }

  int get _activeLoanCount => _loans.where((l) => l['status'] == 'borrowed').length;

  // ── Actions ───────────────────────────────────────────────────────────────

  Future<void> _openScanner() async {
    final raw = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (_) => const _ScannerPage()),
    );
    if (raw == null || !mounted) return;
    _processQrValue(raw.trim());
  }

  void _processQrValue(String raw) {
    final id = int.tryParse(raw);
    if (id == null) {
      setState(() => _error = 'QR tidak valid: "$raw"');
      return;
    }
    _loadItem(id);
  }

  Future<void> _loadItem(int id) async {
    setState(() { _isLoading = true; _error = null; });

    final token = await AuthService.getToken();
    if (token == null) {
      if (mounted) setState(() { _isLoading = false; _error = 'Silakan login ulang.'; });
      return;
    }

    final item = await ApiService.getItemById(token, id);
    if (!mounted) return;
    setState(() => _isLoading = false);

    if (item == null) {
      setState(() => _error = 'Barang dengan ID $id tidak ditemukan.');
      return;
    }

    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => PengajuanPeminjamanUserScreen(item: item)),
    );

    if (result == true && mounted) _loadMyLoans();
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final item = _item;
    final myLoan = _myActiveLoan;
    final borrower = _currentBorrower;
    final late = myLoan != null && _isLate(myLoan['due_date']?.toString());

    return Scaffold(
      backgroundColor: _bg,
      body: RefreshIndicator(
        onRefresh: _loadMyLoans,
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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [

                      // ── Header ──────────────────────────────────────────
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
                            'QR Scanner',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          const Spacer(),
                          const SizedBox(width: 38),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // ── Scanner box ──────────────────────────────────────
                      GestureDetector(
                        onTap: _isLoading ? null : _openScanner,
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                            color: const Color(0xFF0D1F3C),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
                          ),
                          child: Stack(
                            children: [
                              // Corner frames
                              Positioned.fill(
                                child: CustomPaint(painter: _CornerFramePainter()),
                              ),
                              // Center content
                              Center(
                                child: Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: _blue.withValues(alpha: 0.4),
                                        blurRadius: 20,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: _isLoading
                                        ? const Center(child: CircularProgressIndicator(color: _blue))
                                        : item != null
                                            ? QrImageView(
                                                data: item['id'].toString(),
                                                version: QrVersions.auto,
                                                size: 120,
                                                backgroundColor: Colors.white,
                                              )
                                            : const Center(
                                                child: Icon(Icons.qr_code_2_rounded, size: 80, color: Colors.black87),
                                              ),
                                  ),
                                ),
                              ),
                              // Scan FAB
                              Positioned(
                                right: 14,
                                bottom: 14,
                                child: GestureDetector(
                                  onTap: _isLoading ? null : _openScanner,
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: item != null ? _blue : _purple,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.white, width: 2),
                                      boxShadow: [
                                        BoxShadow(
                                          color: (item != null ? _blue : _purple).withValues(alpha: 0.5),
                                          blurRadius: 10,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      item != null ? Icons.qr_code_scanner_rounded : Icons.document_scanner_rounded,
                                      size: 24,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              // Hint text bottom-left
                              Positioned(
                                left: 14,
                                bottom: 14,
                                child: Text(
                                  item != null ? 'QR Barang' : 'Tap untuk scan',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.white.withValues(alpha: 0.5),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // ── Error ────────────────────────────────────────────
                      if (_error != null) ...[
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            color: _red.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: _red.withValues(alpha: 0.35)),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.error_outline_rounded, color: _red, size: 16),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(_error!, style: const TextStyle(color: _red, fontSize: 12, fontWeight: FontWeight.w600)),
                              ),
                            ],
                          ),
                        ),
                      ],

                      if (!_isLoading && item == null) ...[
                        const SizedBox(height: 10),
                        Center(
                          child: Text(
                            'Tap kotak di atas untuk memindai QR barang',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.4)),
                          ),
                        ),
                      ],

                      // ── Barang yang Saya Pinjam ──────────────────────────
                      if (_isLoadingMyLoans) ...[
                        const SizedBox(height: 20),
                        const Center(child: CircularProgressIndicator(color: _purple, strokeWidth: 2)),
                      ] else if (_myLoans.where((l) => l['status'] == 'borrowed').isNotEmpty) ...[
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            const Text(
                              'Barang yang Saya Pinjam',
                              style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: _orange,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                '${_myLoans.where((l) => l['status'] == 'borrowed').length}',
                                style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ..._myLoans
                            .where((l) => l['status'] == 'borrowed')
                            .map((loan) => _myLoanCard(loan)),
                      ],

                      // ── Item info setelah scan ───────────────────────────
                      if (item != null) ...[
                        const SizedBox(height: 20),

                        // Item info card
                        Container(
                          padding: const EdgeInsets.all(14),
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
                                    width: 46,
                                    height: 46,
                                    decoration: BoxDecoration(
                                      color: _blue.withValues(alpha: 0.15),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Icon(Icons.inventory_2_rounded, color: _blue, size: 24),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item['name']?.toString() ?? '-',
                                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          borrower != null
                                              ? 'Dipinjam oleh: ${borrower['username'] ?? '-'}'
                                              : item['category_name']?.toString() ?? '-',
                                          style: TextStyle(fontSize: 11, color: Colors.white.withValues(alpha: 0.5)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (myLoan != null)
                                    GestureDetector(
                                      onTap: () async {
                                        final returned = await Navigator.push<bool>(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => DetailPengembalianBarangUserScreen(loan: myLoan),
                                          ),
                                        );
                                        if (returned == true && mounted) {
                                          await _loadItem((item['id'] as num).toInt());
                                        }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                                        decoration: BoxDecoration(
                                          color: _orange,
                                          borderRadius: BorderRadius.circular(10),
                                          boxShadow: [BoxShadow(color: _orange.withValues(alpha: 0.4), blurRadius: 8, offset: const Offset(0, 2))],
                                        ),
                                        child: const Text(
                                          'Kembalikan',
                                          style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              if (borrower != null) ...[
                                const SizedBox(height: 10),
                                Divider(color: Colors.white.withValues(alpha: 0.08), height: 1),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.schedule_rounded,
                                      size: 13,
                                      color: late ? _red : Colors.white.withValues(alpha: 0.4),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      'Batas pengembalian: ${_fmt(borrower['due_date']?.toString())}  ${_daysLeft(borrower['due_date']?.toString())}',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: late ? _red : Colors.white.withValues(alpha: 0.5),
                                        fontWeight: late ? FontWeight.w700 : FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        ),

                        const SizedBox(height: 12),

                        // ── Pinjam / Pending button ──────────────────────
                        if (_canBorrow)
                          GestureDetector(
                            onTap: () async {
                              final result = await Navigator.push<bool>(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => PengajuanPeminjamanUserScreen(item: item),
                                ),
                              );
                              if (result == true && mounted) {
                                await _loadItem((item['id'] as num).toInt());
                                _loadMyLoans();
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              decoration: BoxDecoration(
                                color: _green,
                                borderRadius: BorderRadius.circular(14),
                                boxShadow: [BoxShadow(color: _green.withValues(alpha: 0.4), blurRadius: 10, offset: const Offset(0, 4))],
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.assignment_add, color: Colors.white, size: 18),
                                  SizedBox(width: 8),
                                  Text(
                                    'Pinjam Barang',
                                    style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                          )
                        else if (_hasPendingLoan)
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(
                              color: _orange.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: _orange.withValues(alpha: 0.4)),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.pending_actions_rounded, size: 16, color: _orange),
                                SizedBox(width: 8),
                                Text(
                                  'Menunggu persetujuan admin',
                                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: _orange),
                                ),
                              ],
                            ),
                          ),

                        const SizedBox(height: 16),

                        // ── Tabs ─────────────────────────────────────────
                        Row(
                          children: [
                            Expanded(
                              child: _TabBtn(
                                text: 'Riwayat Peminjaman',
                                active: _activeScanTab == 0,
                                badge: _activeLoanCount,
                                onTap: () => setState(() { _activeScanTab = 0; _activeInnerTab = 0; }),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _TabBtn(
                                text: 'Riwayat Perbaikan',
                                active: _activeScanTab == 1,
                                badge: 0,
                                onTap: () => setState(() { _activeScanTab = 1; _activeInnerTab = 1; }),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        // ── History card ─────────────────────────────────
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.06),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: _InnerTabBtn(
                                      text: 'Riwayat Peminjaman',
                                      active: _activeInnerTab == 0,
                                      onTap: () => setState(() { _activeInnerTab = 0; _activeScanTab = 0; }),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: _InnerTabBtn(
                                      text: 'Riwayat Perbaikan',
                                      active: _activeInnerTab == 1,
                                      onTap: () => setState(() { _activeInnerTab = 1; _activeScanTab = 1; }),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              if (_activeInnerTab == 0)
                                ..._buildLoanRows()
                              else
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 20),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Icon(Icons.build_outlined, size: 36, color: Colors.white.withValues(alpha: 0.25)),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Belum ada riwayat perbaikan',
                                          style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.4)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),

                        // ── Scan ulang ───────────────────────────────────
                        const SizedBox(height: 12),
                        GestureDetector(
                          onTap: _isLoading ? null : _openScanner,
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.06),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: _blue.withValues(alpha: 0.4)),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.qr_code_scanner_rounded, size: 16, color: _blue),
                                SizedBox(width: 8),
                                Text('Scan Ulang', style: TextStyle(fontSize: 13, color: _blue, fontWeight: FontWeight.w700)),
                              ],
                            ),
                          ),
                        ),
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

  // ── Loan rows ─────────────────────────────────────────────────────────────

  List<Widget> _buildLoanRows() {
    if (_loans.isEmpty) {
      return [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Center(
            child: Column(
              children: [
                Icon(Icons.receipt_long_outlined, size: 36, color: Colors.white.withValues(alpha: 0.25)),
                const SizedBox(height: 8),
                Text('Belum ada riwayat peminjaman',
                    style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.4))),
              ],
            ),
          ),
        ),
      ];
    }

    const maxVisible = 3;
    final displayed = _showAll ? _loans : _loans.take(maxVisible).toList();

    return [
      for (final loan in displayed) _loanRow(loan),
      const SizedBox(height: 4),
      if (_loans.length > maxVisible)
        GestureDetector(
          onTap: () => setState(() => _showAll = !_showAll),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _showAll ? 'Sembunyikan' : 'Lihat Selengkapnya',
                  style: const TextStyle(color: _blue, fontSize: 12, fontWeight: FontWeight.w600),
                ),
                const SizedBox(width: 4),
                Icon(
                  _showAll ? Icons.keyboard_arrow_up_rounded : Icons.chevron_right_rounded,
                  size: 16,
                  color: _blue,
                ),
              ],
            ),
          ),
        ),
    ];
  }

  Widget _loanRow(Map<String, dynamic> loan) {
    final isActive = loan['status'] == 'borrowed';
    final name = loan['username']?.toString() ?? '-';
    final label = isActive ? 'Pinjam hingga' : 'Dipinjam selama';
    final date = isActive ? _fmt(loan['due_date']?.toString()) : _fmt(loan['borrow_date']?.toString());
    final statusText = isActive ? 'Dipinjam' : 'Dikembalikan';
    final statusColor = isActive ? _orange : _green;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.person_rounded, color: statusColor, size: 20),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white)),
                  const SizedBox(height: 2),
                  Text(
                    '$label $date',
                    style: TextStyle(fontSize: 11, color: Colors.white.withValues(alpha: 0.45)),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: statusColor.withValues(alpha: 0.35)),
              ),
              child: Text(
                statusText,
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: statusColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _myLoanCard(Map<String, dynamic> loan) {
    final itemName = loan['item_name']?.toString() ?? '-';
    final dueDate = _fmt(loan['due_date']?.toString());
    final daysLeftText = _daysLeft(loan['due_date']?.toString());
    final late = _isLate(loan['due_date']?.toString());
    final cardColor = late ? _red : _orange;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: late ? _red.withValues(alpha: 0.08) : Colors.white.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: late ? _red.withValues(alpha: 0.35) : Colors.white.withValues(alpha: 0.12),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: cardColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.inventory_2_rounded, color: cardColor, size: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(itemName, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Colors.white)),
                  const SizedBox(height: 3),
                  Text(
                    'Jatuh tempo: $dueDate',
                    style: TextStyle(fontSize: 11, color: Colors.white.withValues(alpha: 0.5)),
                  ),
                  if (daysLeftText.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      daysLeftText,
                      style: TextStyle(
                        fontSize: 11,
                        color: late ? _red : Colors.white.withValues(alpha: 0.45),
                        fontWeight: late ? FontWeight.w700 : FontWeight.normal,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () async {
                final returned = await Navigator.push<bool>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailPengembalianBarangUserScreen(loan: loan),
                  ),
                );
                if (returned == true && mounted) _loadMyLoans();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: _blue,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [BoxShadow(color: _blue.withValues(alpha: 0.4), blurRadius: 8, offset: const Offset(0, 2))],
                ),
                child: const Text(
                  'Kembalikan',
                  style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Corner frame painter ──────────────────────────────────────────────────────

class _CornerFramePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF4A6CF7)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    const len = 24.0;
    const pad = 20.0;

    canvas.drawLine(Offset(pad, pad + len), Offset(pad, pad), paint);
    canvas.drawLine(Offset(pad, pad), Offset(pad + len, pad), paint);

    canvas.drawLine(Offset(size.width - pad, pad + len), Offset(size.width - pad, pad), paint);
    canvas.drawLine(Offset(size.width - pad, pad), Offset(size.width - pad - len, pad), paint);

    canvas.drawLine(Offset(pad, size.height - pad - len), Offset(pad, size.height - pad), paint);
    canvas.drawLine(Offset(pad, size.height - pad), Offset(pad + len, size.height - pad), paint);

    canvas.drawLine(Offset(size.width - pad, size.height - pad - len), Offset(size.width - pad, size.height - pad), paint);
    canvas.drawLine(Offset(size.width - pad, size.height - pad), Offset(size.width - pad - len, size.height - pad), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ── Tab button ────────────────────────────────────────────────────────────────

class _TabBtn extends StatelessWidget {
  const _TabBtn({required this.text, required this.active, required this.badge, required this.onTap});

  final String text;
  final bool active;
  final int badge;
  final VoidCallback onTap;

  static const _blue = Color(0xFF4A6CF7);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 38,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: active ? _blue : Colors.white.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: active ? _blue : Colors.white.withValues(alpha: 0.15)),
          boxShadow: active ? [BoxShadow(color: _blue.withValues(alpha: 0.35), blurRadius: 8, offset: const Offset(0, 2))] : null,
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: active ? Colors.white : Colors.white60),
              ),
            ),
            if (!active && badge > 0) ...[
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                decoration: BoxDecoration(
                  color: const Color(0xFFF97316),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text('$badge', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ── Inner tab button ──────────────────────────────────────────────────────────

class _InnerTabBtn extends StatelessWidget {
  const _InnerTabBtn({required this.text, required this.active, required this.onTap});

  final String text;
  final bool active;
  final VoidCallback onTap;

  static const _blue = Color(0xFF4A6CF7);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 32,
        decoration: BoxDecoration(
          color: active ? _blue.withValues(alpha: 0.2) : Colors.white.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: active ? _blue.withValues(alpha: 0.6) : Colors.white.withValues(alpha: 0.08)),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: active ? _blue : Colors.white38,
          ),
        ),
      ),
    );
  }
}

// ── Full-screen camera scanner ────────────────────────────────────────────────

class _ScannerPage extends StatefulWidget {
  const _ScannerPage();

  @override
  State<_ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<_ScannerPage> {
  bool _scanned = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('Scan QR Barang'),
        elevation: 0,
      ),
      body: Stack(
        children: [
          MobileScanner(
            onDetect: (capture) {
              if (_scanned) return;
              final value = capture.barcodes.firstOrNull?.rawValue;
              if (value != null) {
                _scanned = true;
                Navigator.pop(context, value);
              }
            },
          ),
          Center(
            child: CustomPaint(
              painter: _ScanFramePainter(),
              child: const SizedBox(width: 220, height: 220),
            ),
          ),
          const Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Text(
              'Arahkan kamera ke QR code barang',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScanFramePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF4A6CF7)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    const len = 30.0;

    canvas.drawLine(Offset(0, len), Offset.zero, paint);
    canvas.drawLine(Offset.zero, Offset(len, 0), paint);

    canvas.drawLine(Offset(size.width - len, 0), Offset(size.width, 0), paint);
    canvas.drawLine(Offset(size.width, 0), Offset(size.width, len), paint);

    canvas.drawLine(Offset(0, size.height - len), Offset(0, size.height), paint);
    canvas.drawLine(Offset(0, size.height), Offset(len, size.height), paint);

    canvas.drawLine(Offset(size.width - len, size.height), Offset(size.width, size.height), paint);
    canvas.drawLine(Offset(size.width, size.height - len), Offset(size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
