import 'package:flutter/material.dart';
import 'user_ui.dart';

class PeminjamanBarangUser extends StatelessWidget {
  const PeminjamanBarangUser({super.key});

  @override
  Widget build(BuildContext context) {
    return UserPageScaffold(
      title: 'Peminjaman Barang',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const UserSearchField(hintText: 'Cari barang yang ingin dipinjam...'),
          const SizedBox(height: 12),
          _FormCard(
            title: 'Ajukan Peminjaman',
            children: [
              const _FieldRow(label: 'Nama Peminjam', value: 'Muhammad Riza'),
              const Divider(height: 18),
              const _FieldRow(label: 'Barang yang dipinjam', value: 'Laptop'),
              const Divider(height: 18),
              const _FieldRow(label: 'Waktu peminjaman', value: '26–28 Maret 2024'),
              const Divider(height: 18),
              const _FieldRow(label: 'Keperluan', value: 'Mengerjakan tugas kantor'),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8EEF7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Barang hanya boleh dipinjam untuk keperluan kantor.\n'
                  'Batas waktu peminjaman maksimal 3 hari.\n'
                  'Keterlambatan pengembalian akan dikenakan sanksi.',
                  style: TextStyle(fontSize: 11, height: 1.25),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 44,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: UserUi.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Ajukan Peminjaman',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text('Riwayat Peminjaman Saya', style: TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 10),
          UserListCard(
            title: 'Mouse',
            subtitle: '05–08 Apr 2024 • Sudah dikembalikan',
            leadingIcon: Icons.mouse_rounded,
            trailingChip: const UserChip(
              text: 'Selesai',
              background: Color(0xFFDEDEF9),
              foreground: Color(0xFF329CFA),
            ),
            onTap: () {},
          ),
          const SizedBox(height: 10),
          UserListCard(
            title: 'Projector',
            subtitle: '17–19 Apr 2024 • Sudah dikembalikan',
            leadingIcon: Icons.videocam_rounded,
            trailingChip: const UserChip(
              text: 'Selesai',
              background: Color(0xFFDEDEF9),
              foreground: Color(0xFF329CFA),
            ),
            onTap: () {},
          ),
          const SizedBox(height: 6),
          Center(
            child: TextButton(
              onPressed: () {},
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Lihat Selengkapnya'),
                  SizedBox(width: 6),
                  Icon(Icons.chevron_right_rounded),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FormCard extends StatelessWidget {
  const _FormCard({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: UserUi.card,
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w900)),
          const SizedBox(height: 10),
          ...children,
        ],
      ),
    );
  }
}

class _FieldRow extends StatelessWidget {
  const _FieldRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(label, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12))),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 12, color: UserUi.textMuted),
          ),
        ),
      ],
    );
  }
}

