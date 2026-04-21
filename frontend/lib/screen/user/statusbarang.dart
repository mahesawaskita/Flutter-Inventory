import 'package:flutter/material.dart';

class StatusBarangUser extends StatelessWidget {
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
                left: 287,
                top: 52,
                child: SizedBox(
                  width: 67,
                  height: 48,
                  child: Text(
                    'Lanjut',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 60.46,
                top: 95.22,
                child: Container(
                  transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(3.11),
                  width: 32.77,
                  height: 32.77,
                  child: Stack(),
                ),
              ),
              Positioned(
                left: 12,
                top: 132,
                child: Container(
                  width: 389,
                  height: 633,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFEDE2F0),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 3,
                        color: const Color(0xFFAC9BAB),
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 159,
                top: 92,
                child: Container(
                  width: 95,
                  height: 75,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFBF0F8),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 3,
                        color: const Color(0xFFAC9BAB),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 187,
                top: 67,
                child: Container(
                  width: 70,
                  height: 66,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                ),
              ),
              Positioned(
                left: 131,
                top: 172,
                child: SizedBox(
                  width: 225,
                  height: 31,
                  child: Text(
                    'Status Barang',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Paytone One',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 171,
                top: 95,
                child: Container(
                  width: 71,
                  height: 68,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Stack(),
                ),
              ),
              Positioned(
                left: 27,
                top: 213,
                child: Container(
                  width: 114,
                  height: 75,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFE0E7FA),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 2,
                        color: const Color(0xFFB0A0A0),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 146,
                top: 213,
                child: Container(
                  width: 118,
                  height: 75,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFE8F3EF),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 2,
                        color: const Color(0xFFB0A0A0),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 269,
                top: 213,
                child: Container(
                  width: 117,
                  height: 75,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFCE7E2),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 2,
                        color: const Color(0xFFB0A0A0),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 30,
                top: 255,
                child: SizedBox(
                  width: 60,
                  height: 23,
                  child: Text(
                    '5',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 164,
                top: 255,
                child: SizedBox(
                  width: 37,
                  height: 23,
                  child: Text(
                    '7',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 288,
                top: 255,
                child: SizedBox(
                  width: 37,
                  height: 23,
                  child: Text(
                    '2',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 278,
                top: 222,
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/35x35"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 29,
                top: 260,
                child: SizedBox(
                  width: 126,
                  height: 23,
                  child: Text(
                    'Barang',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 192,
                top: 262,
                child: SizedBox(
                  width: 96,
                  height: 23,
                  child: Text(
                    'Barang',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 316,
                top: 262,
                child: SizedBox(
                  width: 96,
                  height: 23,
                  child: Text(
                    'Barang',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 314,
                top: 219,
                child: SizedBox(
                  width: 96,
                  height: 23,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Terlambat\n',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: 'Dikembalikan',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 188,
                top: 222,
                child: SizedBox(
                  width: 91,
                  height: 23,
                  child: Text(
                    'Telah\nDikembalikan',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 67,
                top: 219,
                child: SizedBox(
                  width: 96,
                  height: 23,
                  child: Text(
                    'Sedang\nDipinjam',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 27,
                top: 341,
                child: Container(
                  width: 357,
                  height: 27,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF7EDF8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 33,
                top: 344,
                child: Container(
                  width: 23,
                  height: 22,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Stack(),
                ),
              ),
              Positioned(
                left: 62,
                top: 348,
                child: SizedBox(
                  width: 156,
                  height: 23,
                  child: Text(
                    'Cari barang atau peminjam... ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF7F7F7F),
                      fontSize: 11,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 35,
                top: 222,
                child: Container(
                  width: 32,
                  height: 33,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/32x33"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 154,
                top: 222,
                child: Container(
                  width: 32,
                  height: 33,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/32x33"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 28,
                top: 378,
                child: Container(
                  width: 357,
                  height: 67,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFAF0F8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 28,
                top: 448,
                child: Container(
                  width: 357,
                  height: 67,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFAF0F8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 27,
                top: 517,
                child: Container(
                  width: 359,
                  height: 67,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFAF0F8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 312,
                top: 525,
                child: Container(
                  width: 67,
                  height: 27,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF3280FF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              Positioned(
                left: 31,
                top: 383,
                child: Container(
                  width: 49,
                  height: 40,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/49x40"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 312,
                top: 388,
                child: Container(
                  width: 67,
                  height: 27,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF3280FF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              Positioned(
                left: 230,
                top: 389,
                child: Container(
                  width: 75,
                  height: 20,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFDEDC7),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              Positioned(
                left: 230,
                top: 457,
                child: Container(
                  width: 75,
                  height: 20,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFDEDC7),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              Positioned(
                left: 177,
                top: 525,
                child: Container(
                  width: 128,
                  height: 20,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFFC0CA),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              Positioned(
                left: 321,
                top: 392,
                child: SizedBox(
                  width: 121,
                  height: 32,
                  child: Text(
                    'Detail',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 241,
                top: 390,
                child: SizedBox(
                  width: 121,
                  height: 32,
                  child: Text(
                    'Dipinjam',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 184,
                top: 526,
                child: SizedBox(
                  width: 121,
                  height: 32,
                  child: Text(
                    'Telat Dikembalikan',
                    style: TextStyle(
                      color: const Color(0xFFAB3B3B),
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 359,
                top: 384,
                child: SizedBox(
                  width: 5,
                  height: 32,
                  child: Text(
                    '>',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 321,
                top: 529,
                child: SizedBox(
                  width: 121,
                  height: 32,
                  child: Text(
                    'Detail',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 85,
                top: 452,
                child: SizedBox(
                  width: 184,
                  height: 32,
                  child: Text(
                    'Mouse',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 85,
                top: 383,
                child: SizedBox(
                  width: 184,
                  height: 32,
                  child: Text(
                    'Laptop',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 85,
                top: 403,
                child: SizedBox(
                  width: 184,
                  height: 32,
                  child: Text(
                    'Bintang Audi',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 85,
                top: 471,
                child: SizedBox(
                  width: 184,
                  height: 32,
                  child: Text(
                    'Melissa Putri',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 85,
                top: 540,
                child: SizedBox(
                  width: 184,
                  height: 32,
                  child: Text(
                    'Budi Agung',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 85,
                top: 522,
                child: SizedBox(
                  width: 184,
                  height: 32,
                  child: Text(
                    'Printer',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 359,
                top: 521,
                child: SizedBox(
                  width: 5,
                  height: 32,
                  child: Text(
                    '>',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 312,
                top: 458,
                child: Container(
                  width: 67,
                  height: 27,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF3280FF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              Positioned(
                left: 321,
                top: 462,
                child: SizedBox(
                  width: 75,
                  height: 32,
                  child: Text(
                    'Detail',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 241,
                top: 458,
                child: SizedBox(
                  width: 96,
                  height: 32,
                  child: Text(
                    'Dipinjam',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 359,
                top: 454,
                child: SizedBox(
                  width: 5,
                  height: 32,
                  child: Text(
                    '>',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 31,
                top: 519,
                child: Container(
                  width: 47,
                  height: 47,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/47x47"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 27,
                top: 586,
                child: Container(
                  width: 359,
                  height: 67,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFAF0F8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 234,
                top: 595,
                child: Container(
                  width: 71,
                  height: 20,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFDEDC7),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              Positioned(
                left: 312,
                top: 594,
                child: Container(
                  width: 67,
                  height: 27,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF3280FF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              Positioned(
                left: 241,
                top: 596,
                child: SizedBox(
                  width: 121,
                  height: 32,
                  child: Text(
                    'Dipinjam',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 321,
                top: 598,
                child: SizedBox(
                  width: 121,
                  height: 32,
                  child: Text(
                    'Detail',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 85,
                top: 609,
                child: SizedBox(
                  width: 184,
                  height: 32,
                  child: Text(
                    'Putri Ayu',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 85,
                top: 591,
                child: SizedBox(
                  width: 184,
                  height: 32,
                  child: Text(
                    'Monitor',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 359,
                top: 590,
                child: SizedBox(
                  width: 5,
                  height: 32,
                  child: Text(
                    '>',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 36,
                top: 588,
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/42x42"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 28,
                top: 441,
                child: Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/58x58"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 27,
                top: 296,
                child: Container(
                  width: 209,
                  height: 31,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFAF0F8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 246,
                top: 296,
                child: Container(
                  width: 70,
                  height: 31,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFE7E6F8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 28,
                top: 297,
                child: Container(
                  width: 79,
                  height: 29,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF3479F8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 107,
                top: 296,
                child: Container(
                  transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(1.57),
                  width: 31,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: const Color(0xFFE9DEE6),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 53,
                top: 302,
                child: SizedBox(
                  width: 132,
                  height: 32,
                  child: Text(
                    'Semua',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 119,
                top: 302,
                child: SizedBox(
                  width: 132,
                  height: 32,
                  child: Text(
                    'Sedang Dipinjam',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 276,
                top: 302,
                child: SizedBox(
                  width: 132,
                  height: 32,
                  child: Text(
                    'Filter',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 52,
                top: 502,
                child: Opacity(
                  opacity: 0.50,
                  child: Container(
                    width: 28,
                    height: 5,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFB5B5B5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 85,
                top: 496,
                child: SizedBox(
                  width: 184,
                  height: 32,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Batas Pengembalian ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: '27 Maret 2024',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
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
                left: 282,
                top: 496,
                child: SizedBox(
                  width: 223,
                  height: 32,
                  child: Text(
                    '1 hari lagi',
                    style: TextStyle(
                      color: const Color(0xFF878787),
                      fontSize: 10,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 267,
                top: 497,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/12x12"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 85,
                top: 565,
                child: SizedBox(
                  width: 184,
                  height: 32,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Batas Pengembalian ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: '25 Maret 2024',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
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
                left: 282,
                top: 565,
                child: SizedBox(
                  width: 223,
                  height: 32,
                  child: Text(
                    'Terlambat 2 hari',
                    style: TextStyle(
                      color: const Color(0xFF878787),
                      fontSize: 10,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 267,
                top: 566,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/12x12"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 52,
                top: 639,
                child: Opacity(
                  opacity: 0.50,
                  child: Container(
                    width: 28,
                    height: 5,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFB5B5B5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 85,
                top: 633,
                child: SizedBox(
                  width: 184,
                  height: 32,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Batas Pengembalian ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: '26 Maret 2024',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
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
                left: 282,
                top: 633,
                child: SizedBox(
                  width: 223,
                  height: 32,
                  child: Text(
                    'Terlambat Besok',
                    style: TextStyle(
                      color: const Color(0xFFC19401),
                      fontSize: 10,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 267,
                top: 634,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/12x12"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 85,
                top: 427,
                child: SizedBox(
                  width: 184,
                  height: 32,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Batas Pengembalian ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: '28 Maret 2024',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
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
                left: 282,
                top: 427,
                child: SizedBox(
                  width: 223,
                  height: 32,
                  child: Text(
                    '2 hari lagi',
                    style: TextStyle(
                      color: const Color(0xFF878787),
                      fontSize: 10,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 267,
                top: 428,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/12x12"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 246,
                top: 550,
                child: Opacity(
                  opacity: 0.50,
                  child: Container(
                    width: 55,
                    height: 5,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFFF3A5A),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 230,
                top: 545,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/16x16"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 27,
                top: 696,
                child: Container(
                  width: 359,
                  height: 60,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF3F3F3),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFD3D3D3),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 130,
                top: 705,
                child: Container(
                  width: 149,
                  height: 32,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF3280FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.50),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 256,
                top: 703,
                child: SizedBox(
                  width: 5,
                  height: 32,
                  child: Text(
                    '>',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 146,
                top: 710,
                child: SizedBox(
                  width: 198,
                  height: 32,
                  child: Text(
                    'Pinjam Barang',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 269,
                top: 663,
                child: Container(
                  width: 116,
                  height: 27,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFCF6FA),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFB3B3B3),
                      ),
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 355,
                top: 663,
                child: Container(
                  width: 30,
                  height: 27,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFCF6FA),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFB3B3B3),
                      ),
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 269,
                top: 663,
                child: Container(
                  width: 32,
                  height: 27,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFCF6FA),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFB3B3B3),
                      ),
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 233,
                top: 665,
                child: SizedBox(
                  width: 102,
                  height: 23,
                  child: Text(
                    '<',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF797979),
                      fontSize: 16,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 289,
                top: 666,
                child: SizedBox(
                  width: 102,
                  height: 23,
                  child: Text(
                    '2',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF797979),
                      fontSize: 16,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 265,
                top: 666,
                child: SizedBox(
                  width: 102,
                  height: 23,
                  child: Text(
                    '1',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF3998FC),
                      fontSize: 16,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 379,
                top: 688,
                child: SizedBox(
                  width: 17,
                  height: 23,
                  child: Transform(
                    transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(3.14),
                    child: Text(
                      '<',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF797979),
                        fontSize: 16,
                        fontFamily: 'Phetsarath',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 24,
                top: 667,
                child: SizedBox(
                  width: 210,
                  height: 23,
                  child: Text(
                    'Menampilkan 4 dari 5 barang dipinjam',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 251,
                top: 299,
                child: Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/25x25"),
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