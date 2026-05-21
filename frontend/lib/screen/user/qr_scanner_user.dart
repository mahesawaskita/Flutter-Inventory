import 'package:flutter/material.dart';
import 'package:frontend/service/api_service.dart';
import 'package:frontend/service/auth_service.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'detail_pengembalian_user.dart';
import 'user_ui.dart';

class QRScannerUserScreen extends StatefulWidget {
  const QRScannerUserScreen({super.key});

  @override
  State<QRScannerUserScreen> createState() => _QRScannerUserScreenState();
}

class _QRScannerUserScreenState extends State<QRScannerUserScreen> {
  Map<String, dynamic>? _item;
  List<dynamic> _loans = [];
  bool _isLoading = false;
  int _activeScanTab = 0;   // 0 = Peminjaman, 1 = Perbaikan
  int _activeInnerTab = 0;  // 0 = Peminjaman, 1 = Perbaikan
  bool _showAll = false;
  String? _currentUsername;
  String? _error;

  // ── Helpers ──────────────────────────────────────────────────────────────

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

  String _daysLeft(String? dueDateStr) {
    if (dueDateStr == null) return '';
    try {
      final due = DateTime.parse(dueDateStr);
      final diff = due.difference(DateTime.now()).inDays;
      if (diff < 0) return '${-diff} hari terlambat';
      if (diff == 0) return 'Jatuh tempo hari ini';
      return '$diff hari lagi';
    } catch (_) {
      return '';
    }
  }

  bool _isLate(String? dueDateStr) {
    if (dueDateStr == null) return false;
    try {
      return DateTime.parse(dueDateStr).isBefore(DateTime.now());
    } catch (_) {
      return false;
    }
  }

  Map<String, dynamic>? get _activeLoanForCurrentUser {
    if (_currentUsername == null) return null;
    for (final l in _loans) {
      final loan = Map<String, dynamic>.from(l as Map);
      if (loan['status'] == 'borrowed' && loan['username'] == _currentUsername) {
        return loan;
      }
    }
    return null;
  }

  List<dynamic> get _loanHistory =>
      _loans.where((l) => (l as Map)['status'] == 'borrowed' || l['status'] == 'returned').toList();

  // ── Actions ───────────────────────────────────────────────────────────────

  Future<void> _scan() async {
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (_) => const _ScannerPage()),
    );
    if (result == null) return;
    final id = int.tryParse(result.trim());
    if (id == null) {
      if (mounted) setState(() => _error = 'QR tidak valid: "$result"');
      return;
    }
    await _loadItem(id);
  }

  Future<void> _loadItem(int id) async {
    setState(() {
      _isLoading = true;
      _error = null;
      _item = null;
      _loans = [];
      _showAll = false;
    });

    final token = await AuthService.getToken();
    final username = await AuthService.getUsername();

    if (token == null) {
      if (mounted) setState(() { _isLoading = false; _error = 'Silakan login ulang.'; });
      return;
    }

    final results = await Future.wait([
      ApiService.getItemById(token, id),
      ApiService.getLoansByItem(token, id),
    ]);

    if (!mounted) return;

    final item = results[0] as Map<String, dynamic>?;
    final loans = results[1] as List<dynamic>;

    setState(() {
      _isLoading = false;
      _item = item;
      _loans = loans;
      _currentUsername = username;
      if (item == null) _error = 'Barang dengan ID $id tidak ditemukan.';
    });
  }

  // ── Build ──────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final item = _item;
    final activeLoan = _activeLoanForCurrentUser;
    final late = activeLoan != null && _isLate(activeLoan['due_date']?.toString());

    return UserPageScaffold(
      child: UserFramedPage(
        title: 'QR Scanner',
        topIcon: const Icon(Icons.qr_code_2_rounded, size: 46, color: Color(0xFF545163)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            // ── QR / Scanner Box ──────────────────────────────────────────
            GestureDetector(
              onTap: _isLoading ? null : _scan,
              child: Container(
                height: 184,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: UserUi.softBorder),
                  image: const DecorationImage(
                    image: AssetImage('assets/image/user/detail QR scanner/image 20.png'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(Color(0x66FFFFFF), BlendMode.lighten),
                  ),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 7),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(17),
                          child: _isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(color: UserUi.blue))
                              : item != null
                                  ? QrImageView(
                                      data: item['id'].toString(),
                                      version: QrVersions.auto,
                                      size: 106,
                                      backgroundColor: Colors.white,
                                    )
                                  : const Center(
                                      child: Icon(Icons.qr_code_2_rounded,
                                          size: 90, color: Colors.black)),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      bottom: 10,
                      child: GestureDetector(
                        onTap: _isLoading ? null : _scan,
                        child: Container(
                          width: 72,
                          height: 72,
                          decoration: BoxDecoration(
                            color: _isLoading ? Colors.grey.withValues(alpha: .7) : Colors.black54,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                          ),
                          child: const Icon(Icons.document_scanner_rounded,
                              size: 38, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Error / hint ──────────────────────────────────────────────
            if (_error != null) ...[
              const SizedBox(height: 8),
              Text(_error!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red, fontSize: 12)),
            ] else if (!_isLoading && item == null) ...[
              const SizedBox(height: 8),
              const Text('Tap tombol scan untuk memindai QR barang',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: UserUi.textMuted)),
            ],

            // ── Item Info ─────────────────────────────────────────────────
            if (item != null) ...[
              const SizedBox(height: 10),
              UserInfoTile(
                leading: const UserProductThumb(icon: Icons.inventory_2_rounded),
                title: item['name']?.toString() ?? '-',
                subtitle: item['category_name']?.toString() ?? '-',
                trailing: activeLoan != null
                    ? GestureDetector(
                        onTap: () async {
                          final returned = await Navigator.push<bool>(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetailPengembalianBarangUserScreen(
                                  loan: activeLoan),
                            ),
                          );
                          if (returned == true) {
                            await _loadItem((item['id'] as num).toInt());
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: UserUi.blue,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text('Kembalikan',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700)),
                        ),
                      )
                    : null,
              ),

              // ── Due date row ────────────────────────────────────────────
              if (activeLoan != null) ...[
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Batas Pengembalian ${_fmtDisplay(activeLoan['due_date']?.toString())}  '
                    '${_daysLeft(activeLoan['due_date']?.toString())}',
                    style: TextStyle(
                      fontSize: 11,
                      color: late ? Colors.red : UserUi.textMuted,
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 10),

              // ── Outer tabs ──────────────────────────────────────────────
              Row(
                children: [
                  Expanded(
                    child: _ScanTab(
                      text: 'Riwayat Peminjaman',
                      active: _activeScanTab == 0,
                      count: 0,
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

              // ── Inner card ──────────────────────────────────────────────
              UserSectionCard(
                color: const Color(0xFFF8F2F7),
                child: Column(
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
                        const Icon(Icons.more_horiz_rounded, color: UserUi.blue),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // ── History list ──────────────────────────────────────
                    if (_activeInnerTab == 0) ..._buildLoanRows()
                    else
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Center(
                          child: Text('Belum ada riwayat perbaikan',
                              style: TextStyle(fontSize: 12, color: UserUi.textMuted)),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  List<Widget> _buildLoanRows() {
    final list = _loanHistory;
    if (list.isEmpty) {
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
    final displayed = _showAll ? list : list.take(maxVisible).toList();

    return [
      ...displayed.map((l) {
        final loan = Map<String, dynamic>.from(l as Map);
        final isActive = loan['status'] == 'borrowed';
        final name = loan['username']?.toString() ?? '-';
        final subtitle = isActive ? 'Pinjam hingga' : 'Di pinjam selama';
        final date = isActive
            ? _fmtDisplay(loan['due_date']?.toString())
            : _fmtDisplay(loan['borrow_date']?.toString());
        return UserHistoryRow(
          avatar: const UserProductThumb(icon: Icons.inventory_2_rounded),
          name: name,
          subtitle: subtitle,
          date: date,
          status: isActive ? 'Sedang Dipinjam' : 'Sudah Dikembalikan',
          statusColor: isActive ? const Color(0xFF68B45B) : const Color(0xFF4D7BEE),
        );
      }),
      const SizedBox(height: 8),
      if (list.length > maxVisible)
        GestureDetector(
          onTap: () => setState(() => _showAll = !_showAll),
          child: Center(
            child: Container(
              width: 160,
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
                    style: const TextStyle(color: UserUi.blue, fontSize: 12),
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
}

// ── Sub-widgets ─────────────────────────────────────────────────────────────

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
        decoration: BoxDecoration(
          color: active ? UserUi.blue : const Color(0xFFFBE1A4),
          borderRadius: BorderRadius.circular(18),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                  fontSize: 12, color: active ? Colors.white : Colors.black87),
            ),
            if (!active) ...[
              const SizedBox(width: 8),
              Text('$count', style: const TextStyle(fontSize: 12)),
              const SizedBox(width: 2),
              const Icon(Icons.chevron_right_rounded, size: 18),
            ],
          ],
        ),
      ),
    );
  }
}

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
          style: TextStyle(
              fontSize: 12, color: active ? Colors.white : Colors.black87),
        ),
      ),
    );
  }
}

// ── Full-screen scanner ──────────────────────────────────────────────────────

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
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                border: Border.all(color: UserUi.blue, width: 3),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          const Positioned(
            bottom: 32,
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
