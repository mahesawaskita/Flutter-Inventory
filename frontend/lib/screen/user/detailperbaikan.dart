import 'package:flutter/material.dart';

import 'user_ui.dart';

class DetailPerbaikanUser extends StatefulWidget {
  const DetailPerbaikanUser({super.key});

  @override
  State<DetailPerbaikanUser> createState() => _DetailPerbaikanUserState();
}

class _DetailPerbaikanUserState extends State<DetailPerbaikanUser> {
  @override
  Widget build(BuildContext context) {
    final items = <({String title, String date, String status, Color color, bool active})>[
      (title: 'Perbaikan hingga', date: '28 Maret 2024', status: 'Sedang Dalam Perbaikan', color: const Color(0xFF98D687), active: true),
      (title: 'Di perbaikan pada Tanggal', date: '14 Maret 2024', status: 'Selesai Perbaikan', color: const Color(0xFF98D687), active: false),
      (title: 'Di perbaikan pada tanggal', date: '15 Feb 2024', status: 'Selesai Perbaikan', color: const Color(0xFF98D687), active: false),
    ];

    return UserPageScaffold(
      child: UserFramedPage(
        title: 'Detail Perbaikan',
        topIcon: const Icon(Icons.sync_rounded, size: 46, color: Color(0xFF33343D)),
        child: SizedBox(
          height: 600,
          child: UserSectionCard(
            child: Column(
              children: [
                const Spacer(),
                const Row(
                  children: [
                    Expanded(child: _RepairTab(text: 'Riwayat Peminjaman')),
                    SizedBox(width: 8),
                    Expanded(child: _RepairTab(text: 'Riwayat Perbaikan', active: true)),
                  ],
                ),
                const SizedBox(height: 14),
                UserSectionCard(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: items.map((item) {
                      return Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide(color: UserUi.softBorder)),
                        ),
                        child: Row(
                          children: [
                            const UserProductThumb(icon: Icons.laptop_mac_rounded),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.title, style: const TextStyle(fontSize: 12)),
                                  Text(item.date, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w900)),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  item.active ? 'Dalam perbaikan' : 'Perbaikan selesai',
                                  style: const TextStyle(fontSize: 12, color: UserUi.textMuted),
                                ),
                                const SizedBox(height: 8),
                                UserPill(
                                  text: item.status,
                                  background: item.color,
                                  foreground: const Color(0xFF2D6525),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const Spacer(),
                Center(
                  child: Container(
                    width: 162,
                    height: 30,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE1DCE6),
                      borderRadius: BorderRadius.circular(18),
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
                const SizedBox(height: 6),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RepairTab extends StatelessWidget {
  const _RepairTab({required this.text, this.active = false});

  final String text;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      decoration: BoxDecoration(
        color: active ? UserUi.blue : const Color(0xFFFBE1A4),
        borderRadius: BorderRadius.circular(18),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: active ? Colors.white : Colors.black87,
        ),
      ),
    );
  }
}