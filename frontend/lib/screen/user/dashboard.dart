import 'package:flutter/material.dart';

class DashboardUser extends StatelessWidget {
  const DashboardUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 414,
          height: 896,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              Positioned(
                left: 159,
                top: 285,
                child: Container(
                  width: 101,
                  height: 88,
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
                left: 97,
                top: 429,
                child: Container(
                  width: 95,
                  height: 90,
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
                left: 221,
                top: 430,
                child: Container(
                  width: 98,
                  height: 90,
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
                left: 286,
                top: 285,
                child: Container(
                  width: 98,
                  height: 79,
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
                left: 286,
                top: 333,
                child: SizedBox(
                  width: 104,
                  height: 23,
                  child: Text(
                    'Status Barang',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF1A1A1A),
                      fontSize: 11,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 158,
                top: 332,
                child: SizedBox(
                  width: 106,
                  height: 21,
                  child: Text(
                    'Daftar\nbarang',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF1A1A1A),
                      fontSize: 11,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 94,
                top: 471,
                child: SizedBox(
                  width: 101,
                  height: 20,
                  child: Text(
                    'Barcode\nScanner',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF1A1A1A),
                      fontSize: 11,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 231,
                top: 466,
                child: SizedBox(
                  width: 78,
                  height: 22,
                  child: Text(
                    'Peminjaman Barang',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF1A1A1A),
                      fontSize: 11,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 304,
                top: 269,
                child: Container(
                  width: 71,
                  height: 68,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Stack(),
                ),
              ),
              Positioned(
                left: 110,
                top: 408,
                child: Container(
                  width: 69,
                  height: 58,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Stack(),
                ),
              ),
              Positioned(
                left: 177,
                top: 269,
                child: Container(
                  width: 71,
                  height: 63,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Stack(),
                ),
              ),
              Positioned(
                left: 251,
                top: 405,
                child: Container(
                  width: 53,
                  height: 65,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Stack(),
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