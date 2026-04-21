import 'package:flutter/material.dart';
import 'user_ui.dart';

class StatusBarangUser extends StatelessWidget {
  const StatusBarangUser({super.key});

  @override
  Widget build(BuildContext context) {
    return UserPageScaffold(
      title: 'Status Barang',
      child: UserFramedPage(
        title: 'Status Barang',
        topIcon: const Icon(Icons.attach_money_rounded, color: Color(0xFFFF5D87)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: const [
                Expanded(child: _StatusStat(icon: Icons.assignment_rounded, label: 'Sedang\nDipinjam', value: '5', color: Color(0xFFDBE7FF))),
                SizedBox(width: 10),
                Expanded(child: _StatusStat(icon: Icons.verified_rounded, label: 'Telah\nDikembalikan', value: '7', color: Color(0xFFE2F6EC))),
                SizedBox(width: 10),
                Expanded(child: _StatusStat(icon: Icons.warning_rounded, label: 'Terlambat\nDikembalikan', value: '2', color: Color(0xFFFFE5E1))),
              ],
            ),
            const SizedBox(height: 10),
            const _FilterBar(),
            const SizedBox(height: 10),
            const UserSearchField(hintText: 'Cari barang atau peminjam...'),
            const SizedBox(height: 10),
            _StatusItem(
              icon: Icons.laptop_mac_rounded,
              title: 'Laptop',
              subtitle: 'Bintang Audi',
              meta: 'Batas Pengembalian 28 Maret 2024  •  2 hari lagi',
              chip: const UserChip(text: 'Dipinjam', background: Color(0xFFF4E3B5), foreground: Colors.black),
              onDetail: () {},
            ),
            const SizedBox(height: 10),
            _StatusItem(
              icon: Icons.mouse_rounded,
              title: 'Mouse',
              subtitle: 'Melissa Putri',
              meta: 'Batas Pengembalian 27 Maret 2024  •  1 hari lagi',
              chip: const UserChip(text: 'Dipinjam', background: Color(0xFFF4E3B5), foreground: Colors.black),
              onDetail: () {},
            ),
            const SizedBox(height: 10),
            _StatusItem(
              icon: Icons.print_rounded,
              title: 'Printer',
              subtitle: 'Budi Agung',
              meta: 'Batas Pengembalian 25 Maret 2024  •  Terlambat 2 hari',
              chip: const UserChip(text: 'Telat Dikembalikan', background: Color(0xFFFFB4C2), foreground: Color(0xFFB13A4B)),
              onDetail: () {},
            ),
            const SizedBox(height: 10),
            _StatusItem(
              icon: Icons.monitor_rounded,
              title: 'Monitor',
              subtitle: 'Putri Ayu',
              meta: 'Batas Pengembalian 26 Maret 2024  •  Terlambat Besok',
              chip: const UserChip(text: 'Dipinjam', background: Color(0xFFF4E3B5), foreground: Colors.black),
              onDetail: () {},
            ),
            const SizedBox(height: 8),
            const Text(
              'Menampilkan 4 dari 5 barang dipinjam',
              style: TextStyle(fontSize: 11),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Expanded(child: SizedBox()),
                _Pager(),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
              child: Center(
                child: SizedBox(
                  height: 42,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: UserUi.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                    ),
                    onPressed: () {},
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Pinjam Barang', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900)),
                        SizedBox(width: 8),
                        Icon(Icons.chevron_right_rounded, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusStat extends StatelessWidget {
  const _StatusStat({required this.icon, required this.label, required this.value, required this.color});

  final IconData icon;
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
        border: Border.all(color: UserUi.frameBorder, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
          const SizedBox(height: 4),
          Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class _FilterBar extends StatelessWidget {
  const _FilterBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 34,
            decoration: BoxDecoration(
              color: UserUi.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: const Row(
              children: [
                Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white),
                SizedBox(width: 4),
                Text('Semua', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 12)),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            height: 34,
            decoration: BoxDecoration(
              color: const Color(0xFFF3EAF4),
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: const Text('Sedang Dipinjam', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            height: 34,
            decoration: BoxDecoration(
              color: const Color(0xFFE9E7F7),
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.science_outlined, size: 16),
                SizedBox(width: 6),
                Text('Filter', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _StatusItem extends StatelessWidget {
  const _StatusItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.meta,
    required this.chip,
    required this.onDetail,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String meta;
  final Widget chip;
  final VoidCallback onDetail;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: const Color(0xFFF9F1FB), borderRadius: BorderRadius.circular(14)),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                child: Icon(icon, color: Colors.black87),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.w900)),
                    Text(subtitle, style: const TextStyle(fontSize: 12)),
                  ],
                ),
              ),
              chip,
              const SizedBox(width: 10),
              Material(
                color: UserUi.primary,
                borderRadius: BorderRadius.circular(12),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: onDetail,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Detail', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 12)),
                        SizedBox(width: 6),
                        Icon(Icons.chevron_right_rounded, color: Colors.white, size: 18),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const SizedBox(width: 54),
              Expanded(
                child: Text(
                  meta,
                  style: const TextStyle(fontSize: 10, color: UserUi.textMuted),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Pager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: UserUi.frameBorder.withValues(alpha: 0.35)),
      ),
      child: Row(
        children: const [
          SizedBox(width: 34, child: Center(child: Icon(Icons.chevron_left_rounded, size: 18))),
          VerticalDivider(width: 1),
          SizedBox(width: 28, child: Center(child: Text('1', style: TextStyle(color: UserUi.primary, fontWeight: FontWeight.w800)))),
          SizedBox(width: 28, child: Center(child: Text('2'))),
          VerticalDivider(width: 1),
          SizedBox(width: 34, child: Center(child: Icon(Icons.chevron_right_rounded, size: 18))),
        ],
      ),
    );
  }
}

