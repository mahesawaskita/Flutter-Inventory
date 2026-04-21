import 'package:flutter/material.dart';

class PengembalianBarangUser extends StatelessWidget {
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
                left: 12,
                top: 174,
                child: Container(
                  width: 389,
                  height: 612,
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
                left: 162,
                top: 90,
                child: Container(
                  width: 89,
                  height: 81,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFBF0F8),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 3,
                        color: const Color(0xFFAC9BAB),
                      ),
                      borderRadius: BorderRadius.circular(9),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 30,
                top: 217,
                child: Container(
                  width: 293,
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
                left: 31,
                top: 218,
                child: Container(
                  width: 134,
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
                left: 165,
                top: 217,
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
                left: 246,
                top: 217,
                child: Container(
                  transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(1.57),
                  width: 31,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: const Color(0xFFE8DDE5),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 28,
                top: 258,
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
                left: 28,
                top: 294,
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
                left: 292,
                top: 305,
                child: Container(
                  width: 87,
                  height: 27,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF3280FF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              Positioned(
                left: 28,
                top: 364,
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
                left: 292,
                top: 375,
                child: Container(
                  width: 87,
                  height: 27,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF3280FF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              Positioned(
                left: 27,
                top: 433,
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
                left: 311,
                top: 442,
                child: Container(
                  width: 68,
                  height: 27,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF3280FF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              Positioned(
                left: 189,
                top: 438,
                child: Container(
                  width: 114,
                  height: 20,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFFC0CA),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              Positioned(
                left: 243,
                top: 464,
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
                left: 52,
                top: 416,
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
                left: 52,
                top: 485,
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
                left: 27,
                top: 506,
                child: Container(
                  width: 358,
                  height: 33,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF4ECF7),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  ),
                ),
              ),
              Positioned(
                left: 26,
                top: 544,
                child: Container(
                  width: 361,
                  height: 95,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFAF0F8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 52,
                top: 625,
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
                left: 26,
                top: 644,
                child: Container(
                  width: 361,
                  height: 87,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFAF0F8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 35,
                top: 670,
                child: Container(
                  width: 342,
                  height: 49,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFE3DDF0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 43,
                top: 677,
                child: Container(
                  width: 328,
                  height: 35,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF0EAF6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 290,
                top: 583,
                child: Container(
                  width: 87,
                  height: 27,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF3280FF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              Positioned(
                left: 33,
                top: 571,
                child: Container(
                  width: 346,
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
                left: 123,
                top: 677,
                child: Container(
                  width: 248,
                  height: 35,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF3998FC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.50),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 59.80,
                top: 89.75,
                child: Container(
                  transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(3.11),
                  width: 32.77,
                  height: 32.77,
                  child: Stack(),
                ),
              ),
              Positioned(
                left: 173,
                top: 97,
                child: Container(
                  width: 68,
                  height: 68,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: Icon(Icons.image, size: 20, color: Colors.grey.shade400),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 88,
                top: 176,
                child: SizedBox(
                  width: 238,
                  height: 29,
                  child: Text(
                    'Pengembalian Barang',
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
                left: 34,
                top: 261,
                child: Container(
                  width: 23,
                  height: 22,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Stack(),
                ),
              ),
              Positioned(
                left: 31,
                top: 299,
                child: Container(
                  width: 49,
                  height: 40,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: Icon(Icons.image, size: 20, color: Colors.grey.shade400),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 28,
                top: 358,
                child: Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: Icon(Icons.image, size: 20, color: Colors.grey.shade400),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 56,
                top: 223,
                child: SizedBox(
                  width: 132,
                  height: 32,
                  child: Text(
                    'Sedang Dipinjam',
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
                left: 300,
                top: 309,
                child: SizedBox(
                  width: 121,
                  height: 32,
                  child: Text(
                    'Kembalikan',
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
                left: 300,
                top: 379,
                child: SizedBox(
                  width: 121,
                  height: 32,
                  child: Text(
                    'Kembalikan',
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
                left: 298,
                top: 587,
                child: SizedBox(
                  width: 121,
                  height: 32,
                  child: Text(
                    'Kembalikan',
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
                left: 319,
                top: 446,
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
                left: 174,
                top: 223,
                child: SizedBox(
                  width: 132,
                  height: 32,
                  child: Text(
                    'Terlambat',
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
                left: 261,
                top: 223,
                child: SizedBox(
                  width: 132,
                  height: 32,
                  child: Text(
                    'Riwayat',
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
                left: 61,
                top: 266,
                child: SizedBox(
                  width: 224,
                  height: 23,
                  child: Text(
                    'Cari barang yang hendak dikembalikan... ',
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
                left: 85,
                top: 368,
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
                top: 299,
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
                top: 319,
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
                top: 387,
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
                top: 456,
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
                top: 595,
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
                top: 438,
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
                left: 198,
                top: 440,
                child: SizedBox(
                  width: 184,
                  height: 32,
                  child: Text(
                    'Telat Dikembalikan',
                    style: TextStyle(
                      color: const Color(0xFFAB3B3B),
                      fontSize: 10,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 85,
                top: 577,
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
                left: 40,
                top: 547,
                child: SizedBox(
                  width: 223,
                  height: 32,
                  child: Text(
                    'Barang yang akan dikembalikan',
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
                top: 438,
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
                left: 348,
                top: 677,
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
                left: 155,
                top: 684,
                child: SizedBox(
                  width: 198,
                  height: 32,
                  child: Text(
                    'Konfirmasi Pengembalian',
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
                left: 85,
                top: 341,
                child: SizedBox(
                  width: 184,
                  height: 32,
                  child: Text(
                    'Batas Pengembalian 28 Maret 2024',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 85,
                top: 410,
                child: SizedBox(
                  width: 184,
                  height: 32,
                  child: Text(
                    'Batas Pengembalian 27 Maret 2024',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 85,
                top: 479,
                child: SizedBox(
                  width: 184,
                  height: 32,
                  child: Text(
                    'Batas Pengembalian 25 Maret 2024',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 85,
                top: 618,
                child: SizedBox(
                  width: 184,
                  height: 32,
                  child: Text(
                    'Batas Peduli 25 Maret 2024',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 40,
                top: 515,
                child: SizedBox(
                  width: 223,
                  height: 32,
                  child: Text(
                    'Menampilkan 2 dari 2 barang dikembalikan',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 111,
                top: 650,
                child: SizedBox(
                  width: 223,
                  height: 32,
                  child: Text(
                    'Ada 1 barang yang siap dikembalikan',
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
                left: 282,
                top: 341,
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
                left: 282,
                top: 410,
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
                left: 282,
                top: 479,
                child: SizedBox(
                  width: 223,
                  height: 32,
                  child: Text(
                    'Terlambat 2 hari',
                    style: TextStyle(
                      color: const Color(0xFFC36262),
                      fontSize: 10,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 239,
                top: 618,
                child: SizedBox(
                  width: 223,
                  height: 32,
                  child: Text(
                    'Terlambat 2 hari',
                    style: TextStyle(
                      color: const Color(0xFFC36262),
                      fontSize: 10,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 227,
                top: 459,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: Icon(Icons.image, size: 20, color: Colors.grey.shade400),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 31,
                top: 435,
                child: Container(
                  width: 47,
                  height: 47,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: Icon(Icons.image, size: 20, color: Colors.grey.shade400),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 31,
                top: 573,
                child: Container(
                  width: 47,
                  height: 47,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: Icon(Icons.image, size: 20, color: Colors.grey.shade400),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 267,
                top: 342,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: Icon(Icons.image, size: 20, color: Colors.grey.shade400),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 267,
                top: 411,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: Icon(Icons.image, size: 20, color: Colors.grey.shade400),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 224,
                top: 619,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: Icon(Icons.image, size: 20, color: Colors.grey.shade400),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 267,
                top: 480,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: Icon(Icons.image, size: 20, color: Colors.grey.shade400),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 131,
                top: 684,
                child: Container(
                  width: 19,
                  height: 19,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: Icon(Icons.image, size: 20, color: Colors.grey.shade400),
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

