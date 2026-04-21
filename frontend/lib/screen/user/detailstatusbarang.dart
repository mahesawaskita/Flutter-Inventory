import 'package:flutter/material.dart';

class DetailStatusBarangUser extends StatelessWidget {
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
                left: 54.80,
                top: 77.75,
                child: Container(
                  transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(3.11),
                  width: 32.77,
                  height: 32.77,
                  child: Stack(),
                ),
              ),
              Positioned(
                left: 9,
                top: 116,
                child: Container(
                  width: 394,
                  height: 652,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFEDE2F0),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 3,
                        color: const Color(0xFFAC9BAB),
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 151,
                top: 70,
                child: Container(
                  width: 106,
                  height: 78,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFFFBFB),
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
                left: 185,
                top: 51,
                child: Container(
                  width: 72,
                  height: 66,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                ),
              ),
              Positioned(
                left: 96,
                top: 163,
                child: SizedBox(
                  width: 229,
                  height: 29,
                  child: Text(
                    'Detail Status Barang',
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
                left: 508.80,
                top: 54.75,
                child: Container(
                  transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(3.11),
                  width: 32.77,
                  height: 32.77,
                  child: Stack(),
                ),
              ),
              Positioned(
                left: 171,
                top: 76,
                child: Container(
                  width: 65,
                  height: 65,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: Icon(Icons.image, size: 20, color: Colors.grey.shade400),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 26,
                top: 218,
                child: Container(
                  width: 362,
                  height: 123,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFAF0F8),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFFAF0F8),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 26,
                top: 218,
                child: Container(
                  width: 362,
                  height: 48,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF0EAF6),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFB1B1B1),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 75,
                top: 547,
                child: Container(
                  width: 313,
                  height: 36,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFAF0F8),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFB1B1B1),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 16,
                top: 348,
                child: Container(
                  width: 381,
                  height: 41,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFAF0F8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1)),
                  ),
                ),
              ),
              Positioned(
                left: 16,
                top: 590,
                child: Container(
                  width: 381,
                  height: 41,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFAF0F8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1)),
                  ),
                ),
              ),
              Positioned(
                left: 388,
                top: 266,
                child: Container(
                  transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(3.14),
                  width: 362,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: const Color(0xFF9E9E9E),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 388,
                top: 310,
                child: Container(
                  transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(3.14),
                  width: 362,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: const Color(0xFF9E9E9E),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 388,
                top: 424,
                child: Container(
                  transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(3.14),
                  width: 362,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: const Color(0xFF9E9E9E),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 388,
                top: 465,
                child: Container(
                  transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(3.14),
                  width: 362,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: const Color(0xFF9E9E9E),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 388,
                top: 503,
                child: Container(
                  transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(3.14),
                  width: 362,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: const Color(0xFF9E9E9E),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 388,
                top: 540,
                child: Container(
                  transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(3.14),
                  width: 362,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: const Color(0xFF9E9E9E),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 29,
                top: 219,
                child: Container(
                  width: 70,
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
                left: 29,
                top: 267,
                child: Container(
                  width: 41,
                  height: 43,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: Icon(Icons.image, size: 20, color: Colors.grey.shade400),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 35,
                top: 311,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: Icon(Icons.image, size: 20, color: Colors.grey.shade400),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 25,
                top: 353,
                child: Container(
                  width: 31,
                  height: 31,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: Icon(Icons.image, size: 20, color: Colors.grey.shade400),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 26,
                top: 393,
                child: Container(
                  width: 29,
                  height: 30,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Stack(),
                ),
              ),
              Positioned(
                left: 16,
                top: 420,
                child: Container(
                  width: 50,
                  height: 51,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: Icon(Icons.image, size: 20, color: Colors.grey.shade400),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 25,
                top: 469,
                child: Container(
                  width: 34,
                  height: 30,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: Icon(Icons.image, size: 20, color: Colors.grey.shade400),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 23,
                top: 503,
                child: Container(
                  width: 39,
                  height: 40,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: Icon(Icons.image, size: 20, color: Colors.grey.shade400),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 23,
                top: 591,
                child: Container(
                  width: 39,
                  height: 40,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: Icon(Icons.image, size: 20, color: Colors.grey.shade400),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 22.88,
                top: 546.08,
                child: Container(
                  transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-0.10),
                  width: 39.99,
                  height: 39.99,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: Icon(Icons.image, size: 20, color: Colors.grey.shade400),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 30,
                top: 646,
                child: Container(
                  width: 142,
                  height: 69,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFD7D7D7),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFB1B1B1),
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 246,
                top: 646,
                child: Container(
                  width: 142,
                  height: 69,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFD7D7D7),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFB1B1B1),
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 40,
                top: 648,
                child: Container(
                  width: 118,
                  height: 67,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: Icon(Icons.image, size: 20, color: Colors.grey.shade400),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 256,
                top: 648,
                child: Container(
                  width: 118,
                  height: 67,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: Icon(Icons.image, size: 20, color: Colors.grey.shade400),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 28,
                top: 644,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: Icon(Icons.image, size: 20, color: Colors.grey.shade400),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 244,
                top: 644,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: Icon(Icons.image, size: 20, color: Colors.grey.shade400),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 93,
                top: 222,
                child: SizedBox(
                  width: 105,
                  height: 23,
                  child: Text(
                    'Nama Barang',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 45,
                top: 357,
                child: SizedBox(
                  width: 168,
                  height: 23,
                  child: Text(
                    'Detail Peminjaman',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 50,
                top: 599,
                child: SizedBox(
                  width: 168,
                  height: 23,
                  child: Text(
                    'Foto Pengembalian',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 61,
                top: 288,
                child: SizedBox(
                  width: 105,
                  height: 23,
                  child: Text(
                    'Budi Agung',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 277,
                top: 397,
                child: SizedBox(
                  width: 104,
                  height: 23,
                  child: Text(
                    'Budi Agung',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 277,
                top: 436,
                child: SizedBox(
                  width: 104,
                  height: 23,
                  child: Text(
                    '24 Mar 2024',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 277,
                top: 475,
                child: SizedBox(
                  width: 104,
                  height: 23,
                  child: Text(
                    '26 Mar 2024',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 71,
                top: 241,
                child: SizedBox(
                  width: 105,
                  height: 23,
                  child: Text(
                    'Laptop',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 19,
                top: 268,
                child: SizedBox(
                  width: 170,
                  height: 23,
                  child: Text(
                    'Peminjam',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 40,
                top: 397,
                child: SizedBox(
                  width: 153,
                  height: 23,
                  child: Text(
                    'Nama Peminjam',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 42,
                top: 436,
                child: SizedBox(
                  width: 153,
                  height: 23,
                  child: Text(
                    'Tanggal Dipinjam',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 39,
                top: 475,
                child: SizedBox(
                  width: 153,
                  height: 23,
                  child: Text(
                    'Tanggal Kembali',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 8,
                top: 512,
                child: SizedBox(
                  width: 153,
                  height: 23,
                  child: Text(
                    'Status',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 78,
                top: 555,
                child: SizedBox(
                  width: 257,
                  height: 23,
                  child: Text(
                    'Laptop rusak LCD retak, perlu perbaikan',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 257,
                top: 315,
                child: Container(
                  width: 124,
                  height: 22,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF49E3D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 235,
                top: 316,
                child: SizedBox(
                  width: 171,
                  height: 23,
                  child: Text(
                    'Terlambat 2 Hari',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 249,
                top: 511,
                child: Container(
                  width: 125,
                  height: 22,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF49E3D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 228,
                top: 512,
                child: SizedBox(
                  width: 170,
                  height: 23,
                  child: Text(
                    'Terlambat 2 Hari',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 65,
                top: 316,
                child: SizedBox(
                  width: 170,
                  height: 23,
                  child: Text(
                    '24 Mar 2024 - 26 Mar 2024',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 377,
                top: 390,
                child: SizedBox(
                  width: 4,
                  height: 32,
                  child: Text(
                    '>',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 377,
                top: 428,
                child: SizedBox(
                  width: 4,
                  height: 32,
                  child: Text(
                    '>',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 377,
                top: 467,
                child: SizedBox(
                  width: 4,
                  height: 32,
                  child: Text(
                    '>',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 377,
                top: 505,
                child: SizedBox(
                  width: 4,
                  height: 32,
                  child: Text(
                    '>',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
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

