import 'package:flutter/material.dart';
import 'user_ui.dart';

class GenerateQrUser extends StatelessWidget {
  const GenerateQrUser({super.key});

  @override
  Widget build(BuildContext context) {
    return UserPageScaffold(
      title: 'Generate QR',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 220,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: UserUi.border, width: 2),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.qr_code_2_rounded, size: 120, color: UserUi.textMuted),
                SizedBox(height: 8),
                Text('QR Barang', style: TextStyle(fontWeight: FontWeight.w900)),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const UserSearchField(hintText: 'Cari barang untuk dibuat QR...'),
          const SizedBox(height: 12),
          UserListCard(
            title: 'Laptop',
            subtitle: 'Klik untuk generate QR',
            leadingIcon: Icons.laptop_rounded,
            trailingChip: const UserChip(
              text: 'Generate',
              background: UserUi.primary,
              foreground: Colors.white,
            ),
            onTap: () {},
          ),
          const SizedBox(height: 10),
          UserListCard(
            title: 'Printer',
            subtitle: 'Klik untuk generate QR',
            leadingIcon: Icons.print_rounded,
            trailingChip: const UserChip(
              text: 'Generate',
              background: UserUi.primary,
              foreground: Colors.white,
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

