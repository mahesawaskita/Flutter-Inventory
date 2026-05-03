import 'package:flutter/material.dart';

import 'user_ui.dart';

class PengembalianBarangUserScreen extends StatefulWidget {
  const PengembalianBarangUserScreen({super.key});

  @override
  State<PengembalianBarangUserScreen> createState() => _PengembalianBarangUserScreenState();
}

class _PengembalianBarangUserScreenState extends State<PengembalianBarangUserScreen> {
  @override
  Widget build(BuildContext context) {
    final dipinjam = <({IconData icon, String name, String borrower, String due, String meta, String action, Color actionColor, bool showDetail, bool late})>[
      (icon: Icons.laptop_mac_rounded, name: 'Laptop', borrower: 'Bintang Audi', due: 'Batas Pengembalian 28 Maret 2024', meta: '2 hari lagi', action: 'Kembalikan', actionColor: UserUi.blue, showDetail: false, late: false),
      (icon: Icons.mouse_rounded, name: 'Mouse', borrower: 'Melissa Putri', due: 'Batas Pengembalian 27 Maret 2024', meta: '1 hari lagi', action: 'Kembalikan', actionColor: UserUi.blue, showDetail: false, late: false),
      (icon: Icons.print_rounded, name: 'Printer', borrower: 'Budi Agung', due: 'Batas Pengembalian 25 Maret 2024', meta: 'Terlambat 2 hari', action: 'Telat Dikembalikan', actionColor: const Color(0xFFFFC3CB), showDetail: true, late: true),
    ];

    return UserPageScaffold(
      child: UserFramedPage(
        title: 'Pengembalian Barang',
        topIcon: const Icon(Icons.sync_alt_rounded, size: 50, color: Color(0xFF3D3D3D)),
        child: Column(
          children: [
            const Row(
              children: [
                Expanded(child: _Segment(text: 'Sedang Dipinjam', active: true)),
                SizedBox(width: 6),
                Expanded(child: _Segment(text: 'Terlambat')),
                SizedBox(width: 6),
                Expanded(child: _Segment(text: 'Riwayat')),
              ],
            ),
            const SizedBox(height: 10),
            const UserMockSearch(hint: 'Cari barang yang hendak dikembalikan...'),
            const SizedBox(height: 12),
            ...dipinjam.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: UserSectionCard(
                  child: Row(
                    children: [
                      UserProductThumb(icon: item.icon, background: const Color(0xFFE7E8F4)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.name, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
                            Text(item.borrower, style: const TextStyle(fontSize: 12)),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Expanded(child: Text(item.due, style: const TextStyle(fontSize: 11))),
                                Text(
                                  item.meta,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: item.late ? const Color(0xFFE06E6A) : UserUi.textMuted,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Container(
                              height: 5,
                              width: item.late ? 72 : 28,
                              decoration: BoxDecoration(
                                color: item.late ? const Color(0xFFFF8296) : const Color(0xFFD6D1D7),
                                borderRadius: BorderRadius.circular(99),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        children: [
                          UserPill(
                            text: item.action,
                            background: item.actionColor,
                            foreground: item.action == 'Kembalikan' ? Colors.white : const Color(0xFFE16D6D),
                          ),
                          if (item.showDetail) ...[
                            const SizedBox(height: 8),
                            const UserPill(text: 'Detail  >', background: UserUi.blue, foreground: Colors.white),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const UserSectionCard(
              color: Colors.white,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Menampilkan 2 dari 2 barang dikembalikan', style: TextStyle(fontSize: 12)),
              ),
            ),
            const SizedBox(height: 8),
            UserSectionCard(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Barang yang akan dikembalikan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
                  const Divider(height: 16),
                  Row(
                    children: const [
                      UserProductThumb(icon: Icons.print_rounded, background: Color(0xFFE7E8F4)),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Printer', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
                            Text('Putri Ayu'),
                            SizedBox(height: 4),
                            Text('Batas Pengembalian 25 Maret 2024', style: TextStyle(fontSize: 11)),
                          ],
                        ),
                      ),
                      UserPill(text: 'Kembalikan', background: UserUi.blue, foreground: Colors.white),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Center(
                    child: Text(
                      'Ada 1 barang yang siap dikembalikan',
                      style: TextStyle(fontSize: 12, color: UserUi.textLight),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8DEF4),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const UserPrimaryButton(
                      text: 'Konfirmasi Pengembalian',
                      icon: Icons.check_rounded,
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

class _Segment extends StatelessWidget {
  const _Segment({required this.text, this.active = false});

  final String text;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34,
      decoration: BoxDecoration(
        color: active ? UserUi.blue : const Color(0xFFF6EEF6),
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (active) const Icon(Icons.keyboard_arrow_down_rounded, size: 18, color: Colors.white),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: active ? Colors.white : Colors.black87,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
