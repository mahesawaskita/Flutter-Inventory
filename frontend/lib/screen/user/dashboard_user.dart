import 'package:flutter/material.dart';

import 'user_ui.dart';

class DashboardUserScreen extends StatefulWidget {
  const DashboardUserScreen({super.key});

  @override
  State<DashboardUserScreen> createState() => _DashboardUserScreenState();
}

class _DashboardUserScreenState extends State<DashboardUserScreen> {
  int? _selectedMenuIndex;

  @override
  Widget build(BuildContext context) {
    final menus = <({IconData icon, String title})>[
      (icon: Icons.sync_alt_rounded, title: 'Kembalian\nBarang'),
      (icon: Icons.favorite_rounded, title: 'Daftar\nbarang'),
      (icon: Icons.receipt_long_rounded, title: 'Status Barang'),
      (icon: Icons.qr_code_scanner_rounded, title: 'Barcode\nScanner'),
      (icon: Icons.local_shipping_rounded, title: 'Peminjaman\nBarang'),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(8, 24, 8, 24),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                decoration: BoxDecoration(
                  color: UserUi.card,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        color: Color(0xFFDFE2EC),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.person, size: 40, color: Color(0xFF5C678A)),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Hi,', style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic)),
                          SizedBox(height: 2),
                          Text(
                            'Muhammad Riza',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.circle, size: 10, color: Color(0xFF8A20F7)),
                            SizedBox(width: 8),
                            Text('User', style: TextStyle(fontSize: 14, color: Color(0xFF8A20F7))),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text('No. Karyawan', style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic)),
                        SizedBox(height: 4),
                        Text('2390343091', style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 120),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 28,
                runSpacing: 54,
                children: menus.asMap().entries.map((entry) {
                  int index = entry.key;
                  var menu = entry.value;
                  bool isSelected = _selectedMenuIndex == index;

                  return SizedBox(
                    width: 98,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedMenuIndex = index;
                        });
                        // Navigasi atau aksi sesuai menu yang dipilih
                        _handleMenuTap(menu.title);
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 98,
                            height: 98,
                            decoration: BoxDecoration(
                              color: isSelected ? const Color(0xFFE8DCEB) : const Color(0xFFFDF7FB),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected ? UserUi.frameBorder : UserUi.frameBorder,
                                width: 3,
                              ),
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                        color: UserUi.frameFill.withValues(alpha: 0.5),
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      ),
                                    ]
                                  : null,
                            ),
                            child: Icon(
                              menu.icon,
                              size: 52,
                              color: isSelected ? const Color(0xFF8A20F7) : const Color(0xFF33343D),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            menu.title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: isSelected ? FontWeight.w900 : FontWeight.w800,
                              color: isSelected ? const Color(0xFF8A20F7) : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleMenuTap(String menuTitle) {
    // Tambahkan navigasi atau aksi sesuai menu yang dipilih
    debugPrint('Menu "$menuTitle" dipilih');
    
    // Contoh navigasi bisa ditambahkan di sini:
    // switch (menuTitle) {
    //   case 'Kembalian\nBarang':
    //     Navigator.push(context, MaterialPageRoute(builder: (_) => PengembalianBarangPage()));
    //     break;
    //   case 'Daftar\nbarang':
    //     Navigator.push(context, MaterialPageRoute(builder: (_) => DaftarBarangPage()));
    //     break;
    //   // ... dan seterusnya
    // }
  }
}
