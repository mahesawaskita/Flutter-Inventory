import 'package:flutter/material.dart';
import 'package:frontend/constants/user_assets.dart';

class DashboardUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with greeting
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: const Color(0xFF4A4A6A),
                        child: Image.asset(
                          'assets/image/user/dashboard/user 1.png',
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Hi,',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                color: Color(0xFF7A7A9E),
                              ),
                            ),
                            const Text(
                              'Muhammad Riza',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'No. Karyawan 2390343091',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Menu Grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  // Row 1: 2 items
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _MenuButton(
                        icon: 'assets/image/user/dashboard/070-wishlist 1.png',
                        label: 'Kembali\nBarang',
                        onTap: () {},
                      ),
                      _MenuButton(
                        icon: 'assets/image/user/dashboard/Pengembalian Barang Logo (2) 1.png',
                        label: 'Daftar\nBarang',
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Row 2: 2 items
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _MenuButton(
                        icon: 'assets/image/user/dashboard/054-qr code scan 1.png',
                        label: 'Barcode\nScanner',
                        onTap: () {},
                      ),
                      _MenuButton(
                        icon: 'assets/image/user/dashboard/028-shipping 1.png',
                        label: 'Peminjaman\nBarang',
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Row 3: Center item
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _MenuButton(
                        icon: 'assets/image/user/dashboard/056-document 1.png',
                        label: 'Status\nBarang',
                        onTap: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  final String icon;
  final String label;
  final VoidCallback onTap;

  const _MenuButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFFE0E0E0),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(16),
            color: const Color(0xFFFAF7FB),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                icon,
                width: 60,
                height: 60,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
                ),
              ),
              Positioned(
                left: 9,
                top: 55,
                child: Container(
                  width: 394,
                  height: 102,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFDF7F9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 35,
                top: 80,
                child: Container(
                  width: 53,
                  height: 53,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Stack(),
                ),
              ),
              Positioned(
                left: 97,
                top: 79,
                child: SizedBox(
                  width: 168,
                  height: 55,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Hi, \n',
                          style: TextStyle(
                            color: const Color(0xFF1A1A1A),
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: 'Muhammad Riza\n',
                          style: TextStyle(
                            color: const Color(0xFF1A1A1A),
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 310,
                top: 69,
                child: Container(
                  width: 9,
                  height: 9,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF8C00FF),
                    shape: OvalBorder(),
                  ),
                ),
              ),
              Positioned(
                left: 329,
                top: 63,
                child: SizedBox(
                  width: 57,
                  height: 17,
                  child: Text(
                    'User',
                    style: TextStyle(
                      color: const Color(0xFF8C00FF),
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 293,
                top: 91,
                child: SizedBox(
                  width: 112,
                  height: 30,
                  child: Text(
                    'No. Karyawan\n    2390343091',
                    style: TextStyle(
                      color: const Color(0xFF1A1A1A),
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 34,
                top: 275,
                child: Container(
                  width: 98,
                  height: 102,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFEF8FA),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 3,
                        color: const Color(0xFFB0A0A0),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 44,
                top: 330,
                child: SizedBox(
                  width: 78,
                  height: 22,
                  child: Text(
                    'Kembalian Barang',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 52,
                top: 264,
                child: Container(
                  width: 62,
                  height: 62,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/62x62"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}