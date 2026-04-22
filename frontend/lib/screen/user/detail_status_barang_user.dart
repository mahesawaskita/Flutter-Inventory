import 'package:flutter/material.dart';

import 'user_ui.dart';

class DetailStatusBarangUserScreen extends StatefulWidget {
  const DetailStatusBarangUserScreen({super.key});

  @override
  State<DetailStatusBarangUserScreen> createState() => _DetailStatusBarangUserScreenState();
}

class _DetailStatusBarangUserScreenState extends State<DetailStatusBarangUserScreen> {
  @override
  Widget build(BuildContext context) {
    return UserPageScaffold(
      child: UserFramedPage(
        title: 'Detail Status Barang',
        topIcon: const Icon(Icons.inventory_2_rounded, size: 48, color: Color(0xFF4B4B4B)),
        child: Column(
          children: [
            UserSectionCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: const [
                        UserProductThumb(icon: Icons.laptop_mac_rounded, background: Color(0xFFF3EEF3)),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(text: 'Nama Barang\n', style: TextStyle(fontWeight: FontWeight.w700)),
                                TextSpan(text: 'Laptop', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(height: 1, color: UserUi.softBorder),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
                    child: Column(
                      children: [
                        Row(
                          children: const [
                            CircleAvatar(
                              radius: 16,
                              backgroundColor: Color(0xFFE8EEF8),
                              child: Icon(Icons.person, size: 18, color: Color(0xFF5A6C91)),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(text: 'Peminjam\n', style: TextStyle(fontSize: 12)),
                                    TextSpan(text: 'Budi Agung', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: const [
                            Icon(Icons.calendar_month_rounded),
                            SizedBox(width: 8),
                            Expanded(child: Text('24 Mar 2024 - 26 Mar 2024')),
                            UserPill(
                              text: 'Terlambat 2 Hari',
                              background: Color(0xFFFFA53B),
                              foreground: Colors.white,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            UserSectionCard(
              padding: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    color: const Color(0xFFF7F0F6),
                    child: const Row(
                      children: [
                        Icon(Icons.fact_check_rounded, color: Color(0xFF7ABB23)),
                        SizedBox(width: 8),
                        Text('Detail Peminjaman', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900)),
                      ],
                    ),
                  ),
                  const _DetailRow(icon: Icons.person_outline_rounded, label: 'Nama Peminjam', value: 'Budi Agung'),
                  const _DetailRow(icon: Icons.calendar_month_rounded, label: 'Tanggal Dipinjam', value: '24 Mar 2024'),
                  const _DetailRow(icon: Icons.calendar_month_rounded, label: 'Tanggal Kembali', value: '26 Mar 2024'),
                  const _DetailRow(
                    icon: Icons.photo_camera_rounded,
                    label: 'Status',
                    value: 'Terlambat 2 Hari',
                    isBadge: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.thumb_up_alt_rounded, color: Color(0xFFFFC400), size: 30),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF9F4F8),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: UserUi.softBorder),
                            ),
                            child: const Text('Laptop rusak LCD retak, perlu perbaikan'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    color: const Color(0xFFF7F0F6),
                    child: const Row(
                      children: [
                        Icon(Icons.photo_camera_rounded),
                        SizedBox(width: 8),
                        Text('Foto Pengembalian', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: const [
                        Expanded(child: _DamagePhoto()),
                        SizedBox(width: 12),
                        Expanded(child: _DamagePhoto()),
                      ],
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

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
    this.isBadge = false,
  });

  final IconData icon;
  final String label;
  final String value;
  final bool isBadge;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: UserUi.softBorder)),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF444444)),
          const SizedBox(width: 8),
          Expanded(child: Text(label, style: const TextStyle(fontSize: 14))),
          if (isBadge)
            const UserPill(
              text: 'Terlambat 2 Hari',
              background: Color(0xFFFFA53B),
              foreground: Colors.white,
            )
          else
            Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
          const SizedBox(width: 4),
          const Icon(Icons.chevron_right_rounded),
        ],
      ),
    );
  }
}

class _DamagePhoto extends StatelessWidget {
  const _DamagePhoto();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 92,
          decoration: BoxDecoration(
            color: const Color(0xFFD7D7D7),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: UserUi.frameBorder.withOpacity(.7)),
          ),
          child: const Center(
            child: Icon(Icons.broken_image_rounded, size: 44, color: Color(0xFF6E6E6E)),
          ),
        ),
        Positioned(
          top: 4,
          left: 4,
          child: Container(
            width: 26,
            height: 26,
            decoration: const BoxDecoration(color: Color(0xFFD63A30), shape: BoxShape.circle),
            child: const Icon(Icons.delete_rounded, size: 16, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
