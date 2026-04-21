import 'package:flutter/material.dart';
import 'user_ui.dart';

class QrScannerUser extends StatelessWidget {
  const QrScannerUser({super.key});

  @override
  Widget build(BuildContext context) {
    return UserPageScaffold(
      title: 'QR Scanner',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 190,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: UserUi.border, width: 2),
            ),
            child: Stack(
              children: [
                Center(
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFAF0F8),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFC5C5C5)),
                    ),
                    child: const Icon(Icons.qr_code_rounded, size: 80, color: UserUi.textMuted),
                  ),
                ),
                Positioned(
                  right: 12,
                  bottom: 12,
                  child: FloatingActionButton.small(
                    heroTag: 'scan',
                    backgroundColor: const Color(0xFF313B4A),
                    onPressed: () {},
                    child: const Icon(Icons.camera_alt_rounded, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: UserUi.card,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFC5C5C5)),
            ),
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: const [
                    Expanded(child: _TabPill(selected: true, text: 'Riwayat Peminjaman')),
                    SizedBox(width: 10),
                    Expanded(child: _TabPill(selected: false, text: 'Riwayat Perbaikan')),
                  ],
                ),
                const SizedBox(height: 12),
                UserListCard(
                  title: 'Laptop',
                  subtitle: 'Bintang Audi • Pinjam hingga 28 Maret 2024',
                  leadingIcon: Icons.laptop_rounded,
                  trailingChip: const UserChip(
                    text: 'Sedang dipinjam',
                    background: Color(0xFFB0D8A6),
                    foreground: Colors.black,
                  ),
                  onTap: () {},
                ),
                const SizedBox(height: 10),
                UserListCard(
                  title: 'Mouse',
                  subtitle: 'Melissa Putri • 14 Maret 2024',
                  leadingIcon: Icons.mouse_rounded,
                  trailingChip: const UserChip(
                    text: 'Sudah dikembalikan',
                    background: Color(0xFFB0D8A6),
                    foreground: Colors.black,
                  ),
                  onTap: () {},
                ),
                const SizedBox(height: 10),
                UserListCard(
                  title: 'Printer',
                  subtitle: 'Budi Agung • 15 Feb 2024',
                  leadingIcon: Icons.print_rounded,
                  trailingChip: const UserChip(
                    text: 'Sudah dikembalikan',
                    background: Color(0xFFB0D8A6),
                    foreground: Colors.black,
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
          ),
        ],
      ),
    );
  }
}

class _TabPill extends StatelessWidget {
  const _TabPill({required this.selected, required this.text});

  final bool selected;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      decoration: BoxDecoration(
        color: selected ? UserUi.primary : const Color(0xFFF6EDF2),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFC5C5C5)),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: selected ? Colors.white : Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}

