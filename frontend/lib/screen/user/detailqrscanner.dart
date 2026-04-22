import 'package:flutter/material.dart';

import 'user_ui.dart';

class DetailQrScannerUser extends StatefulWidget {
  const DetailQrScannerUser({super.key});

  @override
  State<DetailQrScannerUser> createState() => _DetailQrScannerUserState();
}

class _DetailQrScannerUserState extends State<DetailQrScannerUser> {
  @override
  Widget build(BuildContext context) {
    return UserPageScaffold(
      child: UserFramedPage(
        title: 'Detail QR Scanner',
        topIcon: const Icon(Icons.qr_code_2_rounded, size: 46, color: Color(0xFF545163)),
        child: Column(
          children: [
            const UserInfoTile(
              leading: UserProductThumb(icon: Icons.laptop_mac_rounded),
              title: 'Laptop',
              subtitle: 'Bintang Audi',
              trailing: Text('Batas Pengembalian 28 Maret 2024  2 hari lagi', style: TextStyle(fontSize: 11, color: UserUi.textMuted)),
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                Expanded(child: _TopTab(text: 'Riwayat Peminjaman', active: true)),
                SizedBox(width: 8),
                Expanded(child: _TopTab(text: 'Riwayat Perbaikan')),
              ],
            ),
            const SizedBox(height: 10),
            UserSectionCard(
              color: const Color(0xFFF6EFF6),
              child: Column(
                children: [
                  Row(
                    children: const [
                      Expanded(
                        child: Text('Riwayat Peminjaman', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
                      ),
                      Icon(Icons.more_horiz_rounded, color: UserUi.blue),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const UserHistoryRow(
                    avatar: CircleAvatar(radius: 22, backgroundColor: Color(0xFFD9EEF7), child: Icon(Icons.person, color: Color(0xFF5C6D91))),
                    name: 'Bintang Audi',
                    date: '26 Maret - 28 Maret 2024',
                    status: 'Sedang Dipinjam',
                    statusColor: Color(0xFF5DAA56),
                  ),
                  const UserHistoryRow(
                    avatar: CircleAvatar(radius: 22, backgroundColor: Color(0xFFF7D4D8), child: Icon(Icons.person, color: Color(0xFF89545C))),
                    name: 'Melissa Putri',
                    date: '12 Maret - 14 Maret 2024',
                    status: 'Sudah Dipinjamkan',
                    statusColor: Color(0xFF6BAE5F),
                  ),
                  const UserHistoryRow(
                    avatar: CircleAvatar(radius: 22, backgroundColor: Color(0xFFE7E6F4), child: Icon(Icons.person, color: Color(0xFF5C6D91))),
                    name: 'Budi Agung',
                    date: '15 Feb 2024',
                    status: 'Sudah Dikembalikan',
                    statusColor: Color(0xFF8A8BB7),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Container(
                      width: 158,
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
            const SizedBox(height: 14),
            const UserPrimaryButton(
              text: 'Generate QR Barang',
              icon: Icons.qr_code_rounded,
              background: Color(0xFF7060C7),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopTab extends StatelessWidget {
  const _TopTab({required this.text, this.active = false});

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
            style: TextStyle(
              fontSize: 12,
              color: active ? Colors.white : Colors.black87,
            ),
          ),
          if (!active) ...[
            const SizedBox(width: 4),
            const Icon(Icons.chevron_right_rounded, size: 18),
          ],
        ],
      ),
    );
  }
}
