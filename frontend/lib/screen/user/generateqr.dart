import 'package:flutter/material.dart';
import 'package:frontend/service/api_service.dart';
import 'package:frontend/service/auth_service.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'detail_pengembalian_user.dart';
import 'user_ui.dart';

class GenerateQrUser extends StatefulWidget {
  const GenerateQrUser({super.key});

  @override
  State<GenerateQrUser> createState() => _GenerateQrUserState();
}

class _GenerateQrUserState extends State<GenerateQrUser> {
  Map<String, dynamic>? _item;
  List<dynamic> _loans = [];
  bool _isLoading = false;
  int _activeTab = 0;
  String? _currentUsername;
  String? _error;

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
      if (diff < 0) return '· Terlambat ${-diff} hari';
      if (diff == 0) return '· Jatuh tempo hari ini';
      return '· $diff hari lagi';
    } catch (_) {
      return '';
    }
  }

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

  @override
  Widget build(BuildContext context) {
    final item = _item;
    final activeLoan = _activeLoanForCurrentUser;

    return UserPageScaffold(
      child: UserFramedPage(
        title: 'QR Scanner',
        topIcon: const Icon(Icons.qr_code_2_rounded, size: 46, color: Color(0xFF545163)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── QR Box + Scan Button ──
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: 148,
                    height: 148,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: UserUi.frameBorder, width: 2.5),
                    ),
                    alignment: Alignment.center,
                    child: _isLoading
                        ? const CircularProgressIndicator(color: UserUi.blue)
                        : item != null
                            ? QrImageView(
                                data: item['id'].toString(),
                                version: QrVersions.auto,
                                size: 120,
                                backgroundColor: Colors.white,
                              )
                            : const Icon(Icons.qr_code_2_rounded,
                                size: 96, color: Color(0xFFCCCCCC)),
                  ),
                  GestureDetector(
                    onTap: _isLoading ? null : _scan,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: _isLoading ? Colors.grey : const Color(0xFF555555),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2.5),
                      ),
                      child: const Icon(Icons.crop_free_rounded,
                          color: Colors.white, size: 20),
                    ),
                  ),
                ],
              ),
            ),

            if (_error != null) ...[
              const SizedBox(height: 10),
              Text(_error!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red, fontSize: 12)),
            ],

            if (!_isLoading && item == null && _error == null) ...[
              const SizedBox(height: 8),
              const Text('Tap tombol scan untuk memindai QR barang',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: UserUi.textMuted)),
            ],

            // ── Item Card ──
            if (item != null) ...[
              const SizedBox(height: 12),
              UserSectionCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          const UserProductThumb(icon: Icons.inventory_2_rounded),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['name']?.toString() ?? '-',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w800, fontSize: 14),
                                ),
                                Text(
                                  item['category_name']?.toString() ?? '-',
                                  style: const TextStyle(
                                      fontSize: 12, color: UserUi.textMuted),
                                ),
                              ],
                            ),
                          ),
                          if (activeLoan != null)
                            GestureDetector(
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
                            ),
                        ],
                      ),
                    ),
                    if (activeLoan != null) ...[
                      Container(height: 1, color: UserUi.softBorder),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        child: Row(
                          children: [
                            const Icon(Icons.access_time_rounded,
                                size: 14, color: UserUi.textMuted),
                            const SizedBox(width: 6),
                            Text(
                              'Batas Pengembalian ${_fmtDisplay(activeLoan['due_date']?.toString())} '
                              '${_daysLeft(activeLoan['due_date']?.toString())}',
                              style: TextStyle(
                                fontSize: 12,
                                color: _daysLeft(activeLoan['due_date']?.toString())
                                        .contains('Terlambat')
                                    ? Colors.red
                                    : Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // ── Tabs ──
              Row(
                children: [
                  Expanded(child: _TabButton(
                    label: 'Riwayat Peminjaman',
                    active: _activeTab == 0,
                    onTap: () => setState(() => _activeTab = 0),
                  )),
                  const SizedBox(width: 8),
                  Expanded(child: _TabButton(
                    label: 'Riwayat Perbaikan',
                    active: _activeTab == 1,
                    onTap: () => setState(() => _activeTab = 1),
                  )),
                ],
              ),

              const SizedBox(height: 8),

              // ── History list ──
              if (_activeTab == 0) ..._buildLoanHistory(),
              if (_activeTab == 1)
                UserSectionCard(
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text('Belum ada riwayat perbaikan',
                          style: TextStyle(
                              fontSize: 13, color: UserUi.textMuted)),
                    ),
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }

  List<Widget> _buildLoanHistory() {
    if (_loans.isEmpty) {
      return [
        UserSectionCard(
          child: const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text('Belum ada riwayat peminjaman',
                  style: TextStyle(fontSize: 13, color: UserUi.textMuted)),
            ),
          ),
        ),
      ];
    }
    return _loans.map((l) {
      final loan = Map<String, dynamic>.from(l as Map);
      final isActive = loan['status'] == 'borrowed';
      final name = loan['username']?.toString() ?? '-';
      final date = isActive
          ? 'Pinjam hingga ${_fmtDisplay(loan['due_date']?.toString())}'
          : 'Di pinjam selama ${_fmtDisplay(loan['borrow_date']?.toString())}';
      return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: UserSectionCard(
          child: Row(
            children: [
              const UserProductThumb(
                icon: Icons.person_rounded,
                background: Color(0xFFE7E8F4),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 13)),
                    Text(date,
                        style: const TextStyle(
                            fontSize: 11, color: UserUi.textMuted)),
                  ],
                ),
              ),
              UserPill(
                text: isActive ? 'Sedang Dipinjam' : 'Sudah Dikembalikan',
                background: isActive
                    ? const Color(0xFFD6F5E3)
                    : const Color(0xFFD8DEFF),
                foreground: isActive
                    ? const Color(0xFF1A7A40)
                    : const Color(0xFF4D7BEE),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.label,
    required this.active,
    required this.onTap,
  });

  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 34,
        decoration: BoxDecoration(
          color: active ? UserUi.blue : const Color(0xFFF6EEF6),
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: active ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }
}

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
