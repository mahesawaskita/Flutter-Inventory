import 'package:flutter/material.dart';

import 'user_ui.dart';

class QRScannerUserScreen extends StatefulWidget {
  const QRScannerUserScreen({super.key});

  @override
  State<QRScannerUserScreen> createState() => _QRScannerUserScreenState();
}

class _QRScannerUserScreenState extends State<QRScannerUserScreen> {
  @override
  Widget build(BuildContext context) {
    return UserPageScaffold(
      child: UserFramedPage(
        title: 'QR Scanner',
        topIcon: const Icon(Icons.qr_code_2_rounded, size: 46, color: Color(0xFF545163)),
        child: Column(
          children: [
            Container(
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
                        border: Border.all(color: Colors.black, width: 7),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const Center(
                        child: Icon(Icons.qr_code_2_rounded, size: 90, color: Colors.black),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 10,
                    bottom: 10,
                    child: Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                      ),
                      child: const Icon(Icons.document_scanner_rounded, size: 38, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const UserInfoTile(
              leading: UserProductThumb(icon: Icons.laptop_mac_rounded),
              title: 'Laptop',
              subtitle: 'Bintang Audi',
              trailing: UserPill(text: 'Kembalikan', background: UserUi.blue, foreground: Colors.white),
            ),
            const SizedBox(height: 4),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text('Batas Pengembalian 28 Maret 2024  2 hari lagi', style: TextStyle(fontSize: 11, color: UserUi.textMuted)),
              ),
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                Expanded(child: _ScanTab(text: 'Riwayat Peminjaman', active: true)),
                SizedBox(width: 8),
                Expanded(child: _ScanTab(text: 'Riwayat Perbaikan')),
              ],
            ),
            const SizedBox(height: 8),
            UserSectionCard(
              color: const Color(0xFFF8F2F7),
              child: Column(
                children: [
                  Row(
                    children: const [
                      Expanded(child: _InnerTab(text: 'Riwayat Peminjaman', active: true)),
                      SizedBox(width: 8),
                      Expanded(child: _InnerTab(text: 'Riwayat Perbaikan')),
                      SizedBox(width: 8),
                      Icon(Icons.more_horiz_rounded, color: UserUi.blue),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const UserHistoryRow(
                    avatar: UserProductThumb(icon: Icons.laptop_mac_rounded),
                    name: 'Bintang Audi',
                    subtitle: 'Pinjam hingga',
                    date: '28 Maret 2024',
                    status: 'Sedang Dipinjam',
                    statusColor: Color(0xFF68B45B),
                  ),
                  const UserHistoryRow(
                    avatar: UserProductThumb(icon: Icons.laptop_mac_rounded),
                    name: 'Melissa Putri',
                    subtitle: 'Di pinjam selama',
                    date: '14 Maret 2024',
                    status: 'Sudah Dikembalikan',
                    statusColor: Color(0xFF68B45B),
                  ),
                  const UserHistoryRow(
                    avatar: UserProductThumb(icon: Icons.laptop_mac_rounded),
                    name: 'Budi Agung',
                    subtitle: 'Di pinjam selama',
                    date: '15 Feb 2024',
                    status: 'Sudah Dikembalikan',
                    statusColor: Color(0xFF68B45B),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Container(
                      width: 160,
                      height: 30,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE6E1EF),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      alignment: Alignment.center,
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Lihat Selengkapnya', style: TextStyle(color: UserUi.blue)),
                          SizedBox(width: 4),
                          Icon(Icons.chevron_right_rounded, size: 18, color: UserUi.blue),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScanTab extends StatelessWidget {
  const _ScanTab({required this.text, this.active = false});

  final String text;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            style: TextStyle(fontSize: 12, color: active ? Colors.white : Colors.black87),
          ),
          if (!active) ...[
            const SizedBox(width: 8),
            const Text('1'),
            const SizedBox(width: 2),
            const Icon(Icons.chevron_right_rounded, size: 18),
          ],
        ],
      ),
    );
  }
}

class _InnerTab extends StatelessWidget {
  const _InnerTab({required this.text, this.active = false});

  final String text;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      decoration: BoxDecoration(
        color: active ? UserUi.blue : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: UserUi.softBorder),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(fontSize: 12, color: active ? Colors.white : Colors.black87),
      ),
    );
  }
}
