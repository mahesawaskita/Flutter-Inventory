import 'package:flutter/material.dart';
import 'package:frontend/service/api_service.dart';
import 'package:frontend/service/auth_service.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'detail_pengembalian_user.dart';
import 'pengajuan_peminjaman_user.dart';
import 'user_ui.dart';

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

  // user's own loans (always loaded on open)
  List<Map<String, dynamic>> _myLoans = [];
  bool _isLoadingMyLoans = false;

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
      const m = [
        'Jan','Feb','Mar','Apr','Mei','Jun',
        'Jul','Agu','Sep','Okt','Nov','Des'
      ];
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
      if (l['status'] == 'borrowed' && l['username'] == _currentUsername) {
        return l;
      }
    }
    return null;
  }

  bool get _hasPendingLoan {
    if (_currentUsername == null) return false;
    for (final l in _loans) {
      if (l['status'] == 'pending' && l['username'] == _currentUsername) {
        return true;
      }
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

  int get _activeLoanCount =>
      _loans.where((l) => l['status'] == 'borrowed').length;

  Color _avatarBg(String name) {
    const colors = [
      Color(0xFFD9EEF7),
      Color(0xFFF7D4D8),
      Color(0xFFE7E6F4),
      Color(0xFFD7EDD7),
      Color(0xFFFBE8C8),
    ];
    return colors[name.isEmpty ? 0 : name.codeUnitAt(0) % colors.length];
  }

  Color _avatarIcon(String name) {
    const colors = [
      Color(0xFF5C6D91),
      Color(0xFF89545C),
      Color(0xFF5C5C91),
      Color(0xFF3A7A3A),
      Color(0xFF8A6D30),
    ];
    return colors[name.isEmpty ? 0 : name.codeUnitAt(0) % colors.length];
  }

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
    setState(() {
      _isLoading = true;
      _error = null;
      _item = null;
      _loans = [];
      _showAll = false;
      _activeScanTab = 0;
      _activeInnerTab = 0;
    });

    final token = await AuthService.getToken();
    final username = await AuthService.getUsername();
    if (token == null) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _error = 'Silakan login ulang.';
        });
      }
      return;
    }

    final results = await Future.wait([
      ApiService.getItemById(token, id),
      ApiService.getLoansByItem(token, id),
    ]);
    if (!mounted) return;

    final rawItem = results[0] as Map<String, dynamic>?;
    final rawLoans = (results[1] as List<dynamic>)
        .map((e) => Map<String, dynamic>.from(e as Map))
        .toList();

    setState(() {
      _isLoading = false;
      _item = rawItem;
      _loans = rawLoans;
      _currentUsername = username;
      if (rawItem == null) _error = 'Barang dengan ID $id tidak ditemukan.';
    });
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final item = _item;
    final myLoan = _myActiveLoan;
    final borrower = _currentBorrower;
    final late = myLoan != null && _isLate(myLoan['due_date']?.toString());

    return UserPageScaffold(
      child: UserFramedPage(
        title: 'QR Scanner',
        topIcon: const Icon(Icons.qr_code_2_rounded, size: 46,
            color: Color(0xFF545163)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            // ── Scanner box ───────────────────────────────────────────────
            GestureDetector(
              onTap: _isLoading ? null : _openScanner,
              child: Container(
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: UserUi.softBorder),
                  image: const DecorationImage(
                    image: AssetImage(
                        'assets/image/user/detail QR scanner/image 20.png'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Color(0x55FFFFFF), BlendMode.lighten),
                  ),
                ),
                child: Stack(
                  children: [
                    // QR frame corners overlay
                    Positioned.fill(
                      child: CustomPaint(painter: _CornerFramePainter()),
                    ),
                    // Center QR display
                    Center(
                      child: Container(
                        width: 118,
                        height: 118,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha:0.25),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: _isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                      color: UserUi.blue))
                              : item != null
                                  ? QrImageView(
                                      data: item['id'].toString(),
                                      version: QrVersions.auto,
                                      size: 118,
                                      backgroundColor: Colors.white,
                                    )
                                  : const Center(
                                      child: Icon(Icons.qr_code_2_rounded,
                                          size: 88, color: Colors.black87)),
                        ),
                      ),
                    ),
                    // Scan button (bottom-right)
                    Positioned(
                      right: 10,
                      bottom: 10,
                      child: GestureDetector(
                        onTap: _isLoading ? null : _openScanner,
                        child: Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            color: item != null
                                ? const Color(0xFF3C4EBD)
                                : const Color(0xFF444455),
                            shape: BoxShape.circle,
                            border:
                                Border.all(color: Colors.white, width: 2.5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha:0.3),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            item != null
                                ? Icons.qr_code_scanner_rounded
                                : Icons.document_scanner_rounded,
                            size: 26,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Hint / Error / Manual input ───────────────────────────────
            if (_error != null) ...[
              const SizedBox(height: 8),
              Text(_error!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red, fontSize: 12)),
            ],
            if (!_isLoading && item == null) ...[
              const SizedBox(height: 8),
              const Text(
                'Tap kotak di atas untuk memindai QR barang',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: UserUi.textMuted),
              ),
            ],

            // ── Barang yang Saya Pinjam ───────────────────────────────────
            if (_isLoadingMyLoans) ...[
              const SizedBox(height: 12),
              const Center(child: CircularProgressIndicator(color: UserUi.blue, strokeWidth: 2)),
            ] else if (_myLoans.isNotEmpty) ...[
              const SizedBox(height: 14),
              const Text(
                'Barang yang Saya Pinjam',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 8),
              ..._myLoans
                  .where((l) => l['status'] == 'borrowed')
                  .map((loan) => _myLoanCard(loan)),
            ],

            // ── Item info + history ───────────────────────────────────────
            if (item != null) ...[
              const SizedBox(height: 10),

              // Item info tile
              UserInfoTile(
                leading: const UserProductThumb(
                    icon: Icons.inventory_2_rounded),
                title: item['name']?.toString() ?? '-',
                subtitle: borrower != null
                    ? borrower['username']?.toString() ?? '-'
                    : item['category_name']?.toString() ?? '-',
                trailing: myLoan != null
                    ? GestureDetector(
                        onTap: () async {
                          final returned = await Navigator.push<bool>(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  DetailPengembalianBarangUserScreen(
                                      loan: myLoan),
                            ),
                          );
                          if (returned == true && mounted) {
                            await _loadItem((item['id'] as num).toInt());
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: UserUi.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            'Kembalikan',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      )
                    : null,
              ),

              // Batas pengembalian row
              if (borrower != null) ...[
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Row(
                    children: [
                      Icon(
                        Icons.schedule_rounded,
                        size: 13,
                        color: late ? Colors.red : UserUi.textMuted,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Batas Pengembalian '
                        '${_fmt(borrower['due_date']?.toString())}  '
                        '${_daysLeft(borrower['due_date']?.toString())}',
                        style: TextStyle(
                          fontSize: 11,
                          color: late ? Colors.red : UserUi.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 10),

              // ── Pinjam / status button ────────────────────────────────
              if (_canBorrow)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () async {
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
                    icon: const Icon(Icons.assignment_add, size: 18),
                    label: const Text('Pinjam Barang', style: TextStyle(fontWeight: FontWeight.w700)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF28A745),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      elevation: 0,
                    ),
                  ),
                )
              else if (_hasPendingLoan)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF3CD),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFFFD700)),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.pending_actions_rounded, size: 16, color: Color(0xFFD4890A)),
                      SizedBox(width: 8),
                      Text(
                        'Menunggu persetujuan admin',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFD4890A),
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 10),

              // ── Outer tabs ────────────────────────────────────────────
              Row(
                children: [
                  Expanded(
                    child: _ScanTab(
                      text: 'Riwayat Peminjaman',
                      active: _activeScanTab == 0,
                      count: _activeLoanCount,
                      onTap: () => setState(() {
                        _activeScanTab = 0;
                        _activeInnerTab = 0;
                      }),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _ScanTab(
                      text: 'Riwayat Perbaikan',
                      active: _activeScanTab == 1,
                      count: 0,
                      onTap: () => setState(() {
                        _activeScanTab = 1;
                        _activeInnerTab = 1;
                      }),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // ── Inner card ────────────────────────────────────────────
              UserSectionCard(
                color: const Color(0xFFF8F2F7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _InnerTab(
                            text: 'Riwayat Peminjaman',
                            active: _activeInnerTab == 0,
                            onTap: () => setState(() {
                              _activeInnerTab = 0;
                              _activeScanTab = 0;
                            }),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _InnerTab(
                            text: 'Riwayat Perbaikan',
                            active: _activeInnerTab == 1,
                            onTap: () => setState(() {
                              _activeInnerTab = 1;
                              _activeScanTab = 1;
                            }),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.more_horiz_rounded,
                            color: UserUi.blue),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (_activeInnerTab == 0)
                      ..._buildLoanRows()
                    else
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Center(
                          child: Text(
                            'Belum ada riwayat perbaikan',
                            style: TextStyle(
                                fontSize: 12, color: UserUi.textMuted),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              // Scan ulang button
              const SizedBox(height: 10),
              OutlinedButton.icon(
                onPressed: _isLoading ? null : _openScanner,
                icon: const Icon(Icons.qr_code_scanner_rounded, size: 16),
                label: const Text('Scan Ulang',
                    style: TextStyle(fontSize: 12)),
                style: OutlinedButton.styleFrom(
                  foregroundColor: UserUi.blue,
                  side: const BorderSide(color: UserUi.blue),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // ── Loan rows ─────────────────────────────────────────────────────────────

  List<Widget> _buildLoanRows() {
    if (_loans.isEmpty) {
      return [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Center(
            child: Text('Belum ada riwayat peminjaman',
                style: TextStyle(fontSize: 12, color: UserUi.textMuted)),
          ),
        ),
      ];
    }

    const maxVisible = 3;
    final displayed =
        _showAll ? _loans : _loans.take(maxVisible).toList();

    return [
      for (final loan in displayed) _loanRow(loan),
      const SizedBox(height: 8),
      if (_loans.length > maxVisible)
        GestureDetector(
          onTap: () => setState(() => _showAll = !_showAll),
          child: Center(
            child: Container(
              width: 170,
              height: 30,
              decoration: BoxDecoration(
                color: const Color(0xFFE6E1EF),
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _showAll ? 'Sembunyikan' : 'Lihat Selengkapnya',
                    style:
                        const TextStyle(color: UserUi.blue, fontSize: 12),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    _showAll
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.chevron_right_rounded,
                    size: 18,
                    color: UserUi.blue,
                  ),
                ],
              ),
            ),
          ),
        ),
    ];
  }

  Widget _loanRow(Map<String, dynamic> loan) {
    final isActive = loan['status'] == 'borrowed';
    final name = loan['username']?.toString() ?? '-';
    final label = isActive ? 'Pinjam hingga' : 'Di pinjam selama';
    final date = isActive
        ? _fmt(loan['due_date']?.toString())
        : _fmt(loan['borrow_date']?.toString());
    final statusText =
        isActive ? 'Sedang Dipinjam' : 'Sudah Dikembalikan';
    final statusColor =
        isActive ? const Color(0xFF5DAA56) : const Color(0xFF4D7BEE);
    final bgColor = _avatarBg(name);
    final iconColor = _avatarIcon(name);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: UserUi.softBorder)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: bgColor,
            child: Icon(Icons.person_rounded, color: iconColor, size: 26),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w700)),
                const SizedBox(height: 2),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                        fontSize: 11, color: UserUi.textMuted),
                    children: [
                      TextSpan(text: '$label '),
                      TextSpan(
                        text: date,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha:0.16),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              statusText,
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: statusColor),
            ),
          ),
        ],
      ),
    );
  }

  // ── Card for current user's own loan ─────────────────────────────────────

  Widget _myLoanCard(Map<String, dynamic> loan) {
    final itemName = loan['item_name']?.toString() ?? '-';
    final dueDate = _fmt(loan['due_date']?.toString());
    final daysLeftText = _daysLeft(loan['due_date']?.toString());
    final late = _isLate(loan['due_date']?.toString());

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: UserSectionCard(
        child: Row(
          children: [
            const UserProductThumb(icon: Icons.inventory_2_rounded),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(itemName,
                      style: const TextStyle(
                          fontWeight: FontWeight.w800, fontSize: 13)),
                  const SizedBox(height: 2),
                  Text('Jatuh tempo: $dueDate',
                      style: const TextStyle(fontSize: 11)),
                  const SizedBox(height: 2),
                  Text(
                    daysLeftText,
                    style: TextStyle(
                      fontSize: 11,
                      color: late ? Colors.red : UserUi.textMuted,
                      fontWeight: late ? FontWeight.w700 : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () async {
                final returned = await Navigator.push<bool>(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        DetailPengembalianBarangUserScreen(loan: loan),
                  ),
                );
                if (returned == true && mounted) _loadMyLoans();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                decoration: BoxDecoration(
                  color: UserUi.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text('Kembalikan',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w700)),
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
      ..color = const Color(0xFF3B82F6)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    const len = 22.0;
    const pad = 20.0;

    // top-left
    canvas.drawLine(Offset(pad, pad + len), Offset(pad, pad), paint);
    canvas.drawLine(Offset(pad, pad), Offset(pad + len, pad), paint);
    // top-right
    canvas.drawLine(
        Offset(size.width - pad, pad + len), Offset(size.width - pad, pad), paint);
    canvas.drawLine(
        Offset(size.width - pad, pad), Offset(size.width - pad - len, pad), paint);
    // bottom-left
    canvas.drawLine(
        Offset(pad, size.height - pad - len), Offset(pad, size.height - pad), paint);
    canvas.drawLine(
        Offset(pad, size.height - pad), Offset(pad + len, size.height - pad), paint);
    // bottom-right
    canvas.drawLine(Offset(size.width - pad, size.height - pad - len),
        Offset(size.width - pad, size.height - pad), paint);
    canvas.drawLine(Offset(size.width - pad, size.height - pad),
        Offset(size.width - pad - len, size.height - pad), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ── Outer tab ─────────────────────────────────────────────────────────────────

class _ScanTab extends StatelessWidget {
  const _ScanTab({
    required this.text,
    required this.active,
    required this.count,
    required this.onTap,
  });

  final String text;
  final bool active;
  final int count;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 34,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: active ? UserUi.blue : const Color(0xFFFBE1A4),
          borderRadius: BorderRadius.circular(18),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: active ? Colors.white : Colors.black87,
                ),
              ),
            ),
            if (!active) ...[
              const SizedBox(width: 6),
              Text('$count',
                  style: const TextStyle(
                      fontSize: 11, fontWeight: FontWeight.w800)),
              const SizedBox(width: 2),
              const Icon(Icons.chevron_right_rounded, size: 16),
            ],
          ],
        ),
      ),
    );
  }
}

// ── Inner tab ─────────────────────────────────────────────────────────────────

class _InnerTab extends StatelessWidget {
  const _InnerTab({
    required this.text,
    required this.active,
    required this.onTap,
  });

  final String text;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 32,
        decoration: BoxDecoration(
          color: active ? UserUi.blue : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: UserUi.softBorder),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: active ? Colors.white : Colors.black87,
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
      ..color = const Color(0xFF3B82F6)
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

    canvas.drawLine(Offset(size.width - len, size.height),
        Offset(size.width, size.height), paint);
    canvas.drawLine(Offset(size.width, size.height - len),
        Offset(size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
