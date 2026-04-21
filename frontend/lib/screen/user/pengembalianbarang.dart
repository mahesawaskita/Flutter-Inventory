import 'package:flutter/material.dart';
import 'user_ui.dart';

class PengembalianBarangUser extends StatelessWidget {
  const PengembalianBarangUser({super.key});

  @override
  Widget build(BuildContext context) {
    return UserPageScaffold(
      title: 'Pengembalian Barang',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const UserSearchField(hintText: 'Cari barang yang ingin dikembalikan...'),
          const SizedBox(height: 12),
          UserListCard(
            title: 'Laptop',
            subtitle: 'Bintang Audi • Batas 28 Maret 2024',
            leadingIcon: Icons.laptop_rounded,
            trailingChip: const UserChip(
              text: 'Kembalikan',
              background: Color(0xFF8BAFE6),
              foreground: Color(0xFF00599E),
            ),
            onTap: () {},
          ),
          const SizedBox(height: 10),
          UserListCard(
            title: 'Mouse',
            subtitle: 'Melissa Putri • Batas 27 Maret 2024',
            leadingIcon: Icons.mouse_rounded,
            trailingChip: const UserChip(
              text: 'Kembalikan',
              background: Color(0xFF8BAFE6),
              foreground: Color(0xFF00599E),
            ),
            onTap: () {},
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: UserUi.card,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFC5C5C5)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('Informasi', style: TextStyle(fontWeight: FontWeight.w900)),
                const SizedBox(height: 8),
                const Text(
                  'Pastikan barang dikembalikan dalam kondisi baik.\n'
                  'Jika ada kerusakan, laporkan melalui menu perbaikan.',
                  style: TextStyle(fontSize: 11, height: 1.25),
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
                      'Konfirmasi Pengembalian',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

