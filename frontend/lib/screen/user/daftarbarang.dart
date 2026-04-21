import 'package:flutter/material.dart';
import 'user_ui.dart';

class DaftarBarangUser extends StatelessWidget {
  const DaftarBarangUser({super.key});

  @override
  Widget build(BuildContext context) {
    return UserPageScaffold(
      title: 'Daftar Barang',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: const [
              Expanded(child: _StatTile(label: 'Barang', value: '225', color: Color(0xFFE0E7FA))),
              SizedBox(width: 10),
              Expanded(child: _StatTile(label: 'Barang', value: '11', color: Color(0xFFFFF0DB))),
              SizedBox(width: 10),
              Expanded(child: _StatTile(label: 'Barang', value: '5', color: Color(0xFFFCE7E2))),
            ],
          ),
          const SizedBox(height: 12),
          const _FilterRow(),
          const SizedBox(height: 12),
          const UserSearchField(hintText: 'Cari nama barang...'),
          const SizedBox(height: 12),
          UserListCard(
            title: 'Laptop',
            subtitle: 'Bintang Audi',
            leadingIcon: Icons.laptop_rounded,
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
            subtitle: 'Melissa Putri',
            leadingIcon: Icons.monitor_rounded,
            trailingChip: const UserChip(
              text: 'Hampir habis',
              background: Color(0xFFFDEDC7),
              foreground: Color(0xFF8C7A7A),
            ),
            onTap: () {},
          ),
          const SizedBox(height: 10),
          UserListCard(
            title: 'Printer',
            subtitle: 'Budi Agung • 4 sisa',
            leadingIcon: Icons.print_rounded,
            trailingChip: const UserChip(
              text: 'Tersedia',
              background: Color(0xFF74D294),
              foreground: Colors.white,
            ),
            onTap: () {},
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 44,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: UserUi.primary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {},
              icon: const Icon(Icons.assignment_outlined, color: Colors.white),
              label: const Text(
                'Pinjam Barang',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.label, required this.value, required this.color});

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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
        ],
      ),
    );
  }
}

class _FilterRow extends StatelessWidget {
  const _FilterRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 38,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: UserUi.primary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {},
              child: const Text(
                'Semua Barang',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 12),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: SizedBox(
            height: 38,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: const Color(0xFFFBF6F8),
                side: BorderSide(color: UserUi.border.withValues(alpha: 0.4)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {},
              child: const Text(
                'Elektronik',
                style: TextStyle(color: Color(0xFF878787), fontWeight: FontWeight.w800, fontSize: 12),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 46,
          height: 38,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: const Color(0xFFFBF6F8),
              side: BorderSide(color: UserUi.border.withValues(alpha: 0.4)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              padding: EdgeInsets.zero,
            ),
            onPressed: () {},
            child: const Icon(Icons.tune_rounded, color: Color(0xFF878787), size: 18),
          ),
        ),
      ],
    );
  }
}

