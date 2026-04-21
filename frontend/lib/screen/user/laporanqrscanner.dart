import 'package:flutter/material.dart';
import 'user_ui.dart';

class LaporanQrScannerUser extends StatelessWidget {
  const LaporanQrScannerUser({super.key});

  @override
  Widget build(BuildContext context) {
    return UserPageScaffold(
      title: 'Laporan QR Scanner',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const UserSearchField(hintText: 'Cari laporan...'),
          const SizedBox(height: 12),
          UserListCard(
            title: 'Laptop',
            subtitle: 'Scan pada 21 Apr 2026 • Status: Dipinjam',
            leadingIcon: Icons.laptop_rounded,
            trailingChip: const UserChip(
              text: 'Dipinjam',
              background: Color(0xFFFDEDC7),
              foreground: Colors.black,
            ),
            onTap: () {},
          ),
          const SizedBox(height: 10),
          UserListCard(
            title: 'Printer',
            subtitle: 'Scan pada 20 Apr 2026 • Status: Tersedia',
            leadingIcon: Icons.print_rounded,
            trailingChip: const UserChip(
              text: 'Tersedia',
              background: Color(0xFF74D294),
              foreground: Colors.white,
            ),
            onTap: () {},
          ),
          const SizedBox(height: 10),
          UserListCard(
            title: 'Monitor',
            subtitle: 'Scan pada 19 Apr 2026 • Status: Perbaikan',
            leadingIcon: Icons.monitor_rounded,
            trailingChip: const UserChip(
              text: 'Perbaikan',
              background: Color(0xFFDEDEF9),
              foreground: Color(0xFF329CFA),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

