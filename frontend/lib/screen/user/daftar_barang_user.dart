import 'package:flutter/material.dart';

import 'user_ui.dart';

class DaftarBarangUserScreen extends StatefulWidget {
  const DaftarBarangUserScreen({super.key});

  @override
  State<DaftarBarangUserScreen> createState() => _DaftarBarangUserScreenState();
}

class _DaftarBarangUserScreenState extends State<DaftarBarangUserScreen> {
  @override
  Widget build(BuildContext context) {
    final items = <({IconData icon, String name, String owner, String status, Color color, String stock})>[
      (icon: Icons.laptop_mac_rounded, name: 'Laptop', owner: 'Bintang Audi', status: 'Tersedia', color: const Color(0xFF74D294), stock: ''),
      (icon: Icons.desktop_windows_rounded, name: 'Monitor', owner: 'Melissa Putri', status: 'Hampir Habis', color: const Color(0xFFF0D48A), stock: '4 sisa'),
      (icon: Icons.print_rounded, name: 'Printer', owner: 'Budi Agung', status: 'Tersedia', color: const Color(0xFF74D294), stock: ''),
      (icon: Icons.dns_rounded, name: 'Server', owner: 'Putri Ayu', status: 'Habis', color: const Color(0xFFFA7B6F), stock: '0 trouble'),
      (icon: Icons.mouse_rounded, name: 'Mouse', owner: 'Ujang Lurah', status: 'Hampir Habis', color: const Color(0xFFF0D48A), stock: '3 sisa'),
    ];

    return UserPageScaffold(
      child: UserFramedPage(
        title: 'Daftar Barang',
        topIcon: const Icon(Icons.favorite_rounded, size: 48, color: Color(0xFF22B9D2)),
        child: Column(
          children: [
            Row(
              children: const [
                Expanded(child: _StatCard(color: Color(0xFFDDE5F8), icon: Icons.inventory_2_rounded, value: '225', label: 'Barang')),
                SizedBox(width: 8),
                Expanded(child: _StatCard(color: Color(0xFFFDF0C5), icon: Icons.bolt_rounded, value: '11', label: 'Barang')),
                SizedBox(width: 8),
                Expanded(child: _StatCard(color: Color(0xFFFFE0D7), icon: Icons.warning_amber_rounded, value: '5', label: 'Barang')),
              ],
            ),
            const SizedBox(height: 12),
            const Row(
              children: [
                Expanded(child: _FilterChip(label: 'Semua Barang', active: true, icon: Icons.chevron_left_rounded)),
                SizedBox(width: 8),
                Expanded(child: _FilterChip(label: 'Elektronik', active: false, icon: Icons.info_outline_rounded)),
                SizedBox(width: 8),
                Expanded(child: _FilterChip(label: 'Demuana', active: false, icon: Icons.add_rounded)),
              ],
            ),
            const SizedBox(height: 12),
            const UserMockSearch(hint: 'Cari nama barang...'),
            const SizedBox(height: 12),
            ...items.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: UserSectionCard(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    children: [
                      UserProductThumb(icon: item.icon),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
                            Text(item.owner, style: const TextStyle(fontSize: 12)),
                            if (item.stock.isNotEmpty) ...[
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(item.stock, style: const TextStyle(fontSize: 11, color: UserUi.textMuted)),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Container(
                                      height: 5,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFD6D1D7),
                                        borderRadius: BorderRadius.circular(99),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      UserPill(
                        text: item.status,
                        background: item.color,
                        foreground: item.status == 'Habis' ? Colors.white : Colors.white,
                      ),
                      const SizedBox(width: 8),
                      const UserPill(
                        text: 'Detail  >',
                        background: UserUi.blue,
                        foreground: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            const UserSectionCard(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 60),
                child: UserPrimaryButton(text: 'Pinjam Barang'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.color,
    required this.icon,
    required this.value,
    required this.label,
  });

  final Color color;
  final IconData icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 92,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: UserUi.frameBorder),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 28),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
          Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.active,
    required this.icon,
  });

  final String label;
  final bool active;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      decoration: BoxDecoration(
        color: active ? UserUi.blue : const Color(0xFFF7F0F6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18, color: active ? Colors.white : UserUi.textMuted),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: active ? Colors.white : UserUi.textLight,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
