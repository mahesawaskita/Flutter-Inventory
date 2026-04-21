import 'package:flutter/material.dart';

import 'user_ui.dart';

class DetailPeminjamanBarangUserScreen extends StatelessWidget {
  const DetailPeminjamanBarangUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return UserPageScaffold(
      child: UserFramedPage(
        title: 'Detail Peminjaman Barang',
        topIcon: const Icon(Icons.local_shipping_rounded, size: 48, color: Color(0xFFEA6482)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            UserSectionCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: const [
                        UserProductThumb(icon: Icons.laptop_mac_rounded),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Laptop', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
                              Text('Elektronik', style: TextStyle(fontSize: 12)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 1,
                    color: UserUi.softBorder,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: Row(
                      children: const [
                        Icon(Icons.list_alt_rounded, color: Color(0xFF51B1F1)),
                        SizedBox(width: 8),
                        Text('Stok ', style: TextStyle(fontSize: 13)),
                        Text('10 Tersedia', style: TextStyle(fontSize: 13, color: Color(0xFF00C853))),
                        Spacer(),
                        Icon(Icons.chevron_right_rounded),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Text('Informasi Peminjaman', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
            const SizedBox(height: 8),
            UserSectionCard(
              child: Column(
                children: [
                  UserInfoTile(
                    leading: const CircleAvatar(
                      radius: 22,
                      backgroundColor: Color(0xFFD9EEF7),
                      child: Icon(Icons.person, color: Color(0xFF5C6D91)),
                    ),
                    title: 'Bintang Audi',
                    subtitle: '+ Tambah Nama',
                  ),
                  const SizedBox(height: 8),
                  const _LabeledDate(title: 'Tanggal Peminjaman', start: '24 April 2024', end: '1 Mei 2024'),
                  const SizedBox(height: 8),
                  const _FieldBlock(label: 'Catatan (Opsional)', icon: Icons.edit_note_rounded, hint: 'Masukkan catatan peminjaman barang...'),
                  const SizedBox(height: 8),
                  UserSectionCard(
                    padding: const EdgeInsets.all(10),
                    color: const Color(0xFFF7F1F6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.photo_camera_rounded, size: 18),
                            SizedBox(width: 8),
                            Text('Foto Barang', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Center(
                          child: Container(
                            width: 144,
                            height: 76,
                            decoration: BoxDecoration(
                              color: const Color(0xFFD7D7D7),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: UserUi.frameBorder.withOpacity(.7)),
                            ),
                            child: const Icon(Icons.laptop_mac_rounded, size: 46, color: Color(0xFF4460C8)),
                          ),
                        ),
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

class _LabeledDate extends StatelessWidget {
  const _LabeledDate({
    required this.title,
    required this.start,
    required this.end,
  });

  final String title;
  final String start;
  final String end;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.calendar_month_rounded, size: 18, color: Color(0xFF748BCB)),
            const SizedBox(width: 8),
            Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(child: UserTextInputMock(text: start, icon: const Icon(Icons.calendar_today_rounded, size: 14))),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                height: 34,
                decoration: BoxDecoration(
                  color: const Color(0xFFFBE3AF),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    const Icon(Icons.bolt_rounded, size: 15, color: Color(0xFFB07D00)),
                    const SizedBox(width: 6),
                    Text(end, style: const TextStyle(fontSize: 12)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _FieldBlock extends StatelessWidget {
  const _FieldBlock({
    required this.label,
    required this.icon,
    required this.hint,
  });

  final String label;
  final IconData icon;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: const Color(0xFF748BCB)),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
          ],
        ),
        const SizedBox(height: 6),
        UserTextInputMock(text: hint, muted: true),
      ],
    );
  }
}
