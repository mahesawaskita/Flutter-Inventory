import 'package:flutter/material.dart';

import 'user_ui.dart';

class PeminjamanBarangUserScreen extends StatelessWidget {
  const PeminjamanBarangUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final history = <({IconData icon, String name, String date})>[
      (icon: Icons.mouse_rounded, name: 'Mouse', date: '17 - 19 Apr 2024'),
      (icon: Icons.videocam_rounded, name: 'Projector', date: '05 - 08 Apr 2024'),
    ];

    return UserPageScaffold(
      child: UserFramedPage(
        title: 'Peminjaman Barang',
        topIcon: const Icon(Icons.local_shipping_rounded, size: 50, color: Color(0xFFEA6482)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const UserMockSearch(hint: 'Cari barang yang ingin dipinjam...'),
            const SizedBox(height: 10),
            const _ArrowRow(icon: Icons.person_pin_circle_rounded, title: 'Nama Peminjam'),
            const SizedBox(height: 6),
            const _ArrowRow(icon: Icons.laptop_mac_rounded, title: 'Barang yang Dipinjam', subtitle: 'Laptop'),
            const SizedBox(height: 6),
            UserSectionCard(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: const [
                  Icon(Icons.calendar_month_rounded, color: Color(0xFF748BCB)),
                  SizedBox(width: 8),
                  Text('Waktu Peminjaman', style: TextStyle(fontWeight: FontWeight.w700)),
                  Spacer(),
                  Text('26 Maret 2024', style: TextStyle(fontSize: 13)),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_forward_ios_rounded, size: 14),
                  SizedBox(width: 4),
                  Text('28 Maret 2024', style: TextStyle(fontSize: 13)),
                ],
              ),
            ),
            const SizedBox(height: 6),
            const _ArrowRow(
              icon: Icons.edit_note_rounded,
              title: 'Keperluan',
              subtitle: 'Mengerjakan tugas kantor',
            ),
            const SizedBox(height: 10),
            UserSectionCard(
              color: const Color(0xFFF7F0F6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Icon(Icons.warning_amber_rounded, color: Color(0xFFFFB100)),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Peraturan Peminjaman', style: TextStyle(fontWeight: FontWeight.w800)),
                        SizedBox(height: 6),
                        Text(
                          '1. Barang hanya boleh dipinjam untuk keperluan kantor.\n2. Batas waktu peminjaman maksimal 3 hari.\n3. Keterlambatan pengembalian akan dikenakan sanksi.',
                          style: TextStyle(fontSize: 12, height: 1.45),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 62),
              child: UserPrimaryButton(text: 'Ajukan Peminjaman', icon: Icons.send_rounded),
            ),
            const SizedBox(height: 16),
            UserSectionCard(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Riwayat Peminjaman Saya', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      Expanded(child: _HistoryTab(text: 'Menunggu Persetujuan')),
                      SizedBox(width: 8),
                      Expanded(child: _HistoryTab(text: 'Sedang Dipinjam')),
                      SizedBox(width: 8),
                      Expanded(child: _HistoryTab(text: 'Riwayat', active: true)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ...history.map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          UserProductThumb(icon: item.icon, background: const Color(0xFFE5E5EA)),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
                                Text(item.date, style: const TextStyle(fontSize: 12)),
                              ],
                            ),
                          ),
                          const UserPill(
                            text: 'Sudah Dikembalikan',
                            background: Color(0xFFD8DEFF),
                            foreground: Color(0xFF4D7BEE),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
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

class _ArrowRow extends StatelessWidget {
  const _ArrowRow({
    required this.icon,
    required this.title,
    this.subtitle,
  });

  final IconData icon;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return UserSectionCard(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF7A9AD8)),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
                if (subtitle != null) Text(subtitle!, style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded),
        ],
      ),
    );
  }
}

class _HistoryTab extends StatelessWidget {
  const _HistoryTab({required this.text, this.active = false});

  final String text;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
        color: active ? UserUi.blue : const Color(0xFFECE5EC),
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          color: active ? Colors.white : Colors.black87,
        ),
      ),
    );
  }
}
