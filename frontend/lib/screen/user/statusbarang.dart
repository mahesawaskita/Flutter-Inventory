import 'package:flutter/material.dart';
import 'user_ui.dart';

class StatusBarangUser extends StatelessWidget {
  const StatusBarangUser({super.key});

  @override
  Widget build(BuildContext context) {
    return UserPageScaffold(
      title: 'Status Barang',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: const [
              Expanded(child: _StatusStat(label: 'Sedang\ndipinjam', value: '5', color: Color(0xFFE0E7FA))),
              SizedBox(width: 10),
              Expanded(child: _StatusStat(label: 'Telah\ndikembalikan', value: '7', color: Color(0xFFE8F3EF))),
              SizedBox(width: 10),
              Expanded(child: _StatusStat(label: 'Terlambat\ndikembalikan', value: '2', color: Color(0xFFFCE7E2))),
            ],
          ),
          const SizedBox(height: 12),
          const _Segment(),
          const SizedBox(height: 12),
          const UserSearchField(hintText: 'Cari barang atau peminjam...'),
          const SizedBox(height: 12),
          UserListCard(
            title: 'Laptop',
            subtitle: 'Bintang Audi • Batas 28 Maret 2024 • 2 hari lagi',
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
            title: 'Mouse',
            subtitle: 'Melissa Putri • Batas 27 Maret 2024 • 1 hari lagi',
            leadingIcon: Icons.mouse_rounded,
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
            subtitle: 'Budi Agung • Batas 25 Maret 2024 • Terlambat 2 hari',
            leadingIcon: Icons.print_rounded,
            trailingChip: const UserChip(
              text: 'Telat',
              background: Color(0xFFFFC0CA),
              foreground: Color(0xFFAB3B3B),
            ),
            onTap: () {},
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 44,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: UserUi.primary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {},
              child: const Text(
                'Pinjam Barang',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusStat extends StatelessWidget {
  const _StatusStat({required this.label, required this.value, required this.color});

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFB0A0A0), width: 2),
      ),
      child: Column(
        children: [
          Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
          const SizedBox(height: 4),
          Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class _Segment extends StatelessWidget {
  const _Segment();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF0F8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: UserUi.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: const Text('Semua', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 12)),
            ),
          ),
          const SizedBox(width: 6),
          const Expanded(
            child: Center(
              child: Text('Sedang dipinjam', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
            ),
          ),
          const SizedBox(width: 6),
          SizedBox(
            width: 90,
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: UserUi.border.withValues(alpha: 0.35)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                backgroundColor: const Color(0xFFE7E6F8),
              ),
              onPressed: () {},
              icon: const Icon(Icons.tune_rounded, size: 16),
              label: const Text('Filter', style: TextStyle(fontSize: 12)),
            ),
          ),
        ],
      ),
    );
  }
}

