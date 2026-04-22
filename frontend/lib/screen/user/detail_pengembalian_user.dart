import 'package:flutter/material.dart';

import 'user_ui.dart';

class DetailPengembalianBarangUserScreen extends StatefulWidget {
  const DetailPengembalianBarangUserScreen({super.key});

  @override
  State<DetailPengembalianBarangUserScreen> createState() => _DetailPengembalianBarangUserScreenState();
}

class _DetailPengembalianBarangUserScreenState extends State<DetailPengembalianBarangUserScreen> {
  @override
  Widget build(BuildContext context) {
    return UserPageScaffold(
      child: UserFramedPage(
        title: 'Detail Pengembalian Barang',
        topIcon: const Icon(Icons.sync_alt_rounded, size: 48, color: Color(0xFF33343D)),
        child: UserSectionCard(
          color: const Color(0xFFF8F2F7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Barang yang Dikembalikan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
              const SizedBox(height: 8),
              const UserInfoTile(
                leading: UserProductThumb(icon: Icons.laptop_mac_rounded),
                title: 'Laptop',
                subtitle: 'Bintang Audi',
              ),
              const SizedBox(height: 8),
              Row(
                children: const [
                  Icon(Icons.list_alt_rounded, color: Color(0xFF52B2F1)),
                  SizedBox(width: 8),
                  Text('24 Maret 2024', style: TextStyle(fontSize: 13)),
                ],
              ),
              const SizedBox(height: 10),
              UserSectionCard(
                child: Column(
                  children: const [
                    _DateGroup(title: 'Tanggal Peminjaman', start: '24 Maret 2024', end: '1 Mei 2024'),
                    SizedBox(height: 10),
                    _SingleDateGroup(title: 'Tanggal Pengembalian', value: '29 April 2024'),
                    SizedBox(height: 10),
                    _PhotoArea(),
                    SizedBox(height: 10),
                    _OptionalNote(),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 86),
                child: UserPrimaryButton(text: 'Konfirmasi'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DateGroup extends StatelessWidget {
  const _DateGroup({
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
          children: const [
            Icon(Icons.calendar_month_rounded),
            SizedBox(width: 8),
            Text('Tanggal Peminjaman', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(child: UserTextInputMock(text: start, icon: const Icon(Icons.calendar_today_rounded, size: 14), muted: true)),
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

class _SingleDateGroup extends StatelessWidget {
  const _SingleDateGroup({
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(Icons.check_circle_rounded, color: Color(0xFF33B35A)),
            SizedBox(width: 8),
            Text('Tanggal Pengembalian', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
          ],
        ),
        const SizedBox(height: 6),
        UserTextInputMock(text: value, icon: const Icon(Icons.calendar_today_rounded, size: 14), muted: true),
      ],
    );
  }
}

class _PhotoArea extends StatelessWidget {
  const _PhotoArea();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(Icons.photo_camera_rounded),
            SizedBox(width: 8),
            Text('Foto Barang', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
          ],
        ),
        const SizedBox(height: 8),
        Center(
          child: Stack(
            children: [
              Container(
                width: 144,
                height: 76,
                decoration: BoxDecoration(
                  color: const Color(0xFFD7D7D7),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: UserUi.frameBorder.withOpacity(.7)),
                ),
                child: const Icon(Icons.laptop_mac_rounded, size: 46, color: Color(0xFF4460C8)),
              ),
              Positioned(
                top: 4,
                right: 4,
                child: Container(
                  width: 26,
                  height: 26,
                  decoration: const BoxDecoration(color: Color(0xFFD63A30), shape: BoxShape.circle),
                  child: const Icon(Icons.delete_rounded, size: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _OptionalNote extends StatelessWidget {
  const _OptionalNote();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: 'Catatan ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
              TextSpan(text: '(Opsional)', style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
        SizedBox(height: 6),
        UserTextInputMock(text: 'Masukkan catatan pengembalian barang...', muted: true),
      ],
    );
  }
}
