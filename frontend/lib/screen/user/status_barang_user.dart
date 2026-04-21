import 'package:flutter/material.dart';

import 'user_ui.dart';

class StatusBarangUserScreen extends StatelessWidget {
  const StatusBarangUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = <({IconData icon, String name, String borrower, String status, String due, String late, Color color})>[
      (icon: Icons.laptop_mac_rounded, name: 'Laptop', borrower: 'Bintang Audi', status: 'Dipinjam', due: 'Batas Pengembalian 28 Maret 2024', late: '2 hari lagi', color: const Color(0xFFF3D88B)),
      (icon: Icons.mouse_rounded, name: 'Mouse', borrower: 'Melissa Putri', status: 'Dipinjam', due: 'Batas Pengembalian 27 Maret 2024', late: '1 hari lagi', color: const Color(0xFFF3D88B)),
      (icon: Icons.print_rounded, name: 'Printer', borrower: 'Budi Agung', status: 'Telat Dikembalikan', due: 'Batas Pengembalian 25 Maret 2024', late: 'Terlambat 2 hari', color: const Color(0xFFFFC2C0)),
      (icon: Icons.desktop_windows_rounded, name: 'Monitor', borrower: 'Putri Ayu', status: 'Dipinjam', due: 'Batas Pengembalian 26 Maret 2024', late: 'Terlambat Besok', color: const Color(0xFFF3D88B)),
    ];

    return UserPageScaffold(
      child: UserFramedPage(
        title: 'Status Barang',
        topIcon: const Icon(Icons.receipt_long_rounded, size: 46, color: Color(0xFF90B7E1)),
        child: Column(
          children: [
            const Row(
              children: [
                Expanded(child: _SummaryCard(title: 'Sedang\nDipinjam', value: '5', subtitle: 'Barang', color: Color(0xFFDCE5FA), icon: Icons.content_paste_rounded)),
                SizedBox(width: 8),
                Expanded(child: _SummaryCard(title: 'Telah\nDikembalikan', value: '7', subtitle: 'Barang', color: Color(0xFFE0F5E3), icon: Icons.inventory_2_rounded)),
                SizedBox(width: 8),
                Expanded(child: _SummaryCard(title: 'Terlambat\nDikembalikan', value: '2', subtitle: 'Barang', color: Color(0xFFFFE4D9), icon: Icons.warning_amber_rounded)),
              ],
            ),
            const SizedBox(height: 12),
            const Row(
              children: [
                Expanded(child: _SmallTab(text: 'Semua', active: true)),
                SizedBox(width: 8),
                Expanded(child: _SmallTab(text: 'Sedang Dipinjam', active: false)),
                SizedBox(width: 8),
                Expanded(child: _FilterTab()),
              ],
            ),
            const SizedBox(height: 12),
            const UserMockSearch(hint: 'Cari barang atau peminjam...'),
            const SizedBox(height: 12),
            ...items.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: UserSectionCard(
                  child: Row(
                    children: [
                      UserProductThumb(icon: item.icon),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
                            Text(item.borrower, style: const TextStyle(fontSize: 12)),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    item.due,
                                    style: const TextStyle(fontSize: 11),
                                  ),
                                ),
                                Text(item.late, style: const TextStyle(fontSize: 11, color: UserUi.textMuted)),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Container(
                              height: 5,
                              width: 90,
                              decoration: BoxDecoration(
                                color: const Color(0xFFD5D0D5),
                                borderRadius: BorderRadius.circular(99),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      UserPill(
                        text: item.status,
                        background: item.color,
                        foreground: item.status == 'Telat Dikembalikan' ? const Color(0xFFE05656) : Colors.black87,
                      ),
                      const SizedBox(width: 8),
                      const UserPill(text: 'Detail >', background: UserUi.blue, foreground: Colors.white),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Menampilkan 4 dari 5 barang dipinjam',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                _pageButton('<'),
                const SizedBox(width: 4),
                const Text('1', style: TextStyle(fontSize: 22, color: Color(0xFF7269B4))),
                const SizedBox(width: 10),
                const Text('2', style: TextStyle(fontSize: 22, color: UserUi.textMuted)),
                const SizedBox(width: 4),
                _pageButton('>'),
              ],
            ),
            const SizedBox(height: 12),
            const UserSectionCard(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 92),
                child: UserPrimaryButton(text: 'Pinjam Barang'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _pageButton(String text) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: const Color(0xFFF8F0F5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: UserUi.frameBorder),
      ),
      alignment: Alignment.center,
      child: Text(text, style: const TextStyle(fontSize: 18, color: UserUi.textMuted)),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.color,
    required this.icon,
  });

  final String title;
  final String value;
  final String subtitle;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 92,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: UserUi.frameBorder),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            children: [
              Icon(icon, size: 22, color: UserUi.textMuted),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(value, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900)),
          Text(subtitle, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }
}

class _SmallTab extends StatelessWidget {
  const _SmallTab({required this.text, required this.active});

  final String text;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34,
      decoration: BoxDecoration(
        color: active ? UserUi.blue : const Color(0xFFF8F0F7),
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (active) const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white, size: 20),
          Text(
            text,
            style: TextStyle(
              color: active ? Colors.white : Colors.black87,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterTab extends StatelessWidget {
  const _FilterTab();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34,
      decoration: BoxDecoration(
        color: const Color(0xFFF1ECF4),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.filter_alt_rounded, size: 18, color: Color(0xFF4F7CC7)),
          SizedBox(width: 6),
          Text('Filter'),
        ],
      ),
    );
  }
}
