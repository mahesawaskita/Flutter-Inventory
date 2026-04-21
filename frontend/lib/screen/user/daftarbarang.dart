import 'package:flutter/material.dart';
import 'user_ui.dart';

class DaftarBarangUser extends StatelessWidget {
  const DaftarBarangUser({super.key});

  @override
  Widget build(BuildContext context) {
    return UserPageScaffold(
      title: 'Daftar Barang',
      child: UserFramedPage(
        title: 'Daftar Barang',
        topIcon: const Icon(Icons.favorite, color: Color(0xFFF16A82)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: const [
                Expanded(child: _StatTile(label: 'Barang', value: '225', color: Color(0xFFDBE7FF), icon: Icons.inventory_2_rounded)),
                SizedBox(width: 10),
                Expanded(child: _StatTile(label: 'Barang', value: '11', color: Color(0xFFFFF0DB), icon: Icons.flash_on_rounded)),
                SizedBox(width: 10),
                Expanded(child: _StatTile(label: 'Barang', value: '5', color: Color(0xFFFFE5E1), icon: Icons.warning_rounded)),
              ],
            ),
            const SizedBox(height: 10),
            const _FilterRow(),
            const SizedBox(height: 10),
            const UserSearchField(hintText: 'Cari nama barang...'),
            const SizedBox(height: 10),
            _ItemRow(
              icon: Icons.laptop_mac_rounded,
              title: 'Laptop',
              subtitle: 'Bintang Audi',
              chip: const UserChip(text: 'Tersedia', background: Color(0xFF7AD08D), foreground: Colors.white),
              onDetail: () {},
            ),
            const SizedBox(height: 10),
            _ItemRow(
              icon: Icons.monitor_rounded,
              title: 'Monitor',
              subtitle: 'Melissa Putri',
              chip: const UserChip(text: 'Hampir Habis', background: Color(0xFFF4E3B5), foreground: Color(0xFF7D6B55)),
              footnote: '4 sisa',
              onDetail: () {},
            ),
            const SizedBox(height: 10),
            _ItemRow(
              icon: Icons.print_rounded,
              title: 'Printer',
              subtitle: 'Budi Agung',
              chip: const UserChip(text: 'Tersedia', background: Color(0xFF7AD08D), foreground: Colors.white),
              onDetail: () {},
            ),
            const SizedBox(height: 10),
            _ItemRow(
              icon: Icons.dns_rounded,
              title: 'Server',
              subtitle: 'Putri Ayu',
              chip: const UserChip(text: 'Habis', background: Color(0xFFFF7E73), foreground: Colors.white),
              footnote: '0 trouble',
              onDetail: () {},
            ),
            const SizedBox(height: 10),
            _ItemRow(
              icon: Icons.mouse_rounded,
              title: 'Mouse',
              subtitle: 'Ujang Lurah',
              chip: const UserChip(text: 'Hampir Habis', background: Color(0xFFF4E3B5), foreground: Color(0xFF7D6B55)),
              footnote: '3 sisa',
              onDetail: () {},
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
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

class _StatTile extends StatelessWidget {
  const _StatTile({required this.label, required this.value, required this.color, required this.icon});

  final String label;
  final String value;
  final Color color;
  final IconData icon;

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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Icon(icon, color: Colors.black87, size: 20),
          ),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
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
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.keyboard_arrow_left_rounded, color: Colors.white),
                  SizedBox(width: 4),
                  Text('Semua Barang', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 12)),
                ],
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
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.info_outline_rounded, color: Color(0xFF878787), size: 16),
                  SizedBox(width: 6),
                  Text('Elektronik', style: TextStyle(color: Color(0xFF878787), fontWeight: FontWeight.w800, fontSize: 12)),
                ],
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
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_rounded, color: Color(0xFF878787), size: 18),
                  SizedBox(width: 6),
                  Text('Demuana', style: TextStyle(color: Color(0xFF878787), fontWeight: FontWeight.w800, fontSize: 12)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ItemRow extends StatelessWidget {
  const _ItemRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.chip,
    required this.onDetail,
    this.footnote,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Widget chip;
  final VoidCallback onDetail;
  final String? footnote;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF9F1FB),
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.black87),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w900)),
                Text(subtitle, style: const TextStyle(fontSize: 12)),
                if (footnote != null) ...[
                  const SizedBox(height: 4),
                  Text(footnote!, style: const TextStyle(fontSize: 10, color: UserUi.textMuted)),
                ],
              ],
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              chip,
              const SizedBox(height: 6),
              Material(
                color: UserUi.primary,
                borderRadius: BorderRadius.circular(12),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: onDetail,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
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
        ],
      ),
    );
  }
}

