import 'package:flutter/material.dart';

class DetailPeminjamanBarangUser extends StatelessWidget {
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
                top: 51,
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
                top: 94.22,
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
                  height: 551,
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
                top: 66,
                child: Container(
                  width: 70,
                  height: 66,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                ),
              ),
              Positioned(
                left: 172,
                top: 95,
                child: Container(
                  width: 69,
                  height: 58,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 67,
                          height: 70,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(),
                          child: Stack(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 65,
                top: 172,
                child: SizedBox(
                  width: 284,
                  height: 29,
                  child: Text(
                    'Detail Peminjaman Barang',
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
                left: 22,
                top: 215,
                child: Container(
                  width: 369,
                  height: 83,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFCF9FD),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFC5C5C5),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 22,
                top: 215,
                child: Container(
                  width: 369,
                  height: 50,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFCF9FD),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFC5C5C5),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 28,
                top: 331,
                child: Container(
                  width: 359,
                  height: 50,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFAF3FB),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFC5C5C5),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 28,
                top: 381,
                child: Container(
                  width: 359,
                  height: 73,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFAF3FB),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFC5C5C5),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 48,
                top: 422,
                child: Container(
                  width: 322,
                  height: 26,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF0E6F3),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ),
              Positioned(
                left: 28,
                top: 454,
                child: Container(
                  width: 359,
                  height: 66,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFAF3FB),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFC5C5C5),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 38,
                top: 484,
                child: Container(
                  width: 340,
                  height: 29,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF1E8F3),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFC5C5C5),
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 32,
                top: 221,
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
                left: 86,
                top: 221,
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
                left: 86,
                top: 242,
                child: SizedBox(
                  width: 195,
                  height: 32,
                  child: Text(
                    'Elektronik',
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
                left: 63,
                top: 270,
                child: SizedBox(
                  width: 195,
                  height: 32,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Stok ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: '10 Tersedia',
                          style: TextStyle(
                            color: const Color(0xFF00D46F),
                            fontSize: 13,
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
                left: 28,
                top: 305,
                child: SizedBox(
                  width: 195,
                  height: 32,
                  child: Text(
                    'Informasi Peminjaman',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 22,
                top: 265,
                child: Container(
                  width: 369,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: const Color(0xFFC5C5C5),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 28,
                top: 418,
                child: Container(
                  width: 358,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: const Color(0xFFC5C5C5),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 34,
                top: 268,
                child: Container(
                  width: 23,
                  height: 23,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/23x23"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 365,
                top: 264,
                child: SizedBox(
                  width: 5,
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
                left: 38,
                top: 335,
                child: Container(
                  width: 43,
                  height: 43,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/43x43"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 92,
                top: 337,
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
                left: 81,
                top: 388,
                child: SizedBox(
                  width: 184,
                  height: 32,
                  child: Text(
                    'Tanggal Peminjaman',
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
                left: 76,
                top: 459,
                child: SizedBox(
                  width: 184,
                  height: 32,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Catatan ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: '(Opsional)',
                          style: TextStyle(
                            color: const Color(0xFF8B8B8B),
                            fontSize: 13,
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
                left: 81,
                top: 425,
                child: SizedBox(
                  width: 184,
                  height: 32,
                  child: Text(
                    '24 April 2024',
                    style: TextStyle(
                      color: const Color(0xFF7C7694),
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 92,
                top: 359,
                child: SizedBox(
                  width: 184,
                  height: 32,
                  child: Text(
                    '+ Tambah Nama',
                    style: TextStyle(
                      color: const Color(0xFF868BC6),
                      fontSize: 11,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 48,
                top: 388,
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/22x22"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 57,
                top: 428,
                child: Container(
                  width: 13,
                  height: 13,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/13x13"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 48,
                top: 460,
                child: Container(
                  width: 21,
                  height: 19,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/21x19"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 48,
                top: 489,
                child: SizedBox(
                  width: 269,
                  height: 38,
                  child: Text(
                    'Masukkan catatan peminjaman barang...',
                    style: TextStyle(
                      color: const Color(0xFF8B8B8B),
                      fontSize: 13,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 260,
                top: 424,
                child: Container(
                  width: 108,
                  height: 22,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFBEBD2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ),
              Positioned(
                left: 292,
                top: 425,
                child: SizedBox(
                  width: 69,
                  height: 32,
                  child: Text(
                    '1 Mei 2024',
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
                left: 267,
                top: 426,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/20x20"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 26,
                top: 523,
                child: Container(
                  width: 359,
                  height: 130,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFAF3FB),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFC5C5C5),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 68,
                top: 526,
                child: SizedBox(
                  width: 195,
                  height: 20,
                  child: Text(
                    'Foto Barang',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 39,
                top: 523,
                child: Container(
                  width: 24,
                  height: 23,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/24x23"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 132,
                top: 558,
                child: Container(
                  width: 145,
                  height: 80,
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
                left: 170,
                top: 572,
                child: Container(
                  width: 82,
                  height: 58,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/82x58"),
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