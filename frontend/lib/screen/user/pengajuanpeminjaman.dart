import 'package:flutter/material.dart';
import 'user_ui.dart';

class PengajuanPeminjamanUser extends StatelessWidget {
  const PengajuanPeminjamanUser({super.key});

  @override
  Widget build(BuildContext context) {
    return UserPageScaffold(
      title: 'Pengajuan Peminjaman',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const UserSearchField(hintText: 'Cari pengajuan...'),
          const SizedBox(height: 12),
          UserListCard(
            title: 'Laptop',
            subtitle: 'Muhammad Riza • 26–28 Maret 2024',
            leadingIcon: Icons.laptop_rounded,
            trailingChip: const UserChip(
              text: 'Menunggu',
              background: Color(0xFFFDEDC7),
              foreground: Color(0xFF8C7A7A),
            ),
            onTap: () {},
          ),
          const SizedBox(height: 10),
          UserListCard(
            title: 'Mouse',
            subtitle: 'Muhammad Riza • 05–08 Apr 2024',
            leadingIcon: Icons.mouse_rounded,
            trailingChip: const UserChip(
              text: 'Disetujui',
              background: Color(0xFF74D294),
              foreground: Colors.white,
            ),
            onTap: () {},
          ),
          const SizedBox(height: 10),
          UserListCard(
            title: 'Projector',
            subtitle: 'Muhammad Riza • 17–19 Apr 2024',
            leadingIcon: Icons.videocam_rounded,
            trailingChip: const UserChip(
              text: 'Ditolak',
              background: Color(0xFFFFC0CA),
              foreground: Color(0xFFAB3B3B),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

